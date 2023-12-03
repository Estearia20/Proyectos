from enum import Enum
import rv32i_functions as rv
from contador_2_bits import MaquinaEstados as ME
import sys
import tty
import termios
import signal
import select

R_TYPE = ["add", "sub", "sll", "slt", "sltu", "xor", "srl", "sra",
          "or", "and", "mul"]

I_TYPE = ["addi", "andi", "ori", "xori", "slti", "sltiu", "slli",
          "srli", "srai"]

B_TYPE = ["beq", "bne", "blt", "bge", "bltu", "bgeu"]

S_TYPE = ["lw", "sw"]

J_TYPE = ["jal", "jalr"]


def getch():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch


def esperar_tecla():
    print("Presione cualquier tecla para continuar...")
    while True:
        if select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], []):
            ch = getch()
            return ch
        try:
            # Verificar si se ha presionado Ctrl+C
            signal.signal(signal.SIGINT, signal.default_int_handler)
        except KeyboardInterrupt:
            sys.exit("Programa cancelado por el usuario")

class BTB:
    def __init__(self):
        # Diccionario para almacenar las entradas del BTB
        self.buffer = {}

    def update(self, pc, target):
        self.buffer[pc] = {"pc": pc, "target": target}

    def lookup(self, pc):
        if pc in self.buffer:
            return self.buffer[pc]

        return None

    def print_content(self):
        print("BTB Content:")
        for pc, target in self.buffer.items():
            print(f"PC: {pc}, Target: {target}")


class PerformType(Enum):
    """Enum class representing different methods

    Attributes:
        FORWARDING (str): File type for use of forwarding
        NONE (str): File type for use of stalls only
        PREDICTION (str): File type for use of branch prediction
        BOTH (str): File type for use of both branch prediction and
            forwarding

    """

    FORWARDING = 'forwarding'
    NONE = 'none'
    PREDICTION = 'prediction'
    BOTH = 'both'

    @staticmethod
    def from_string(value: str) -> Enum:
        """Converts a string value to the corresponding PerformType enum

        Args:
            value (str): The string value representing the performance
                type

        Returns:
            Enum: The corresponding PerformType enum

        Raises:
            ValueError: If the provided value is not a valid PerformType

        """

        for item in PerformType:
            if item.value == value:
                return item
        raise ValueError(f"Invalid PerformType: {value}")



class RISCVPipeline:
    def __init__(self, file_path, ptype):
        self.pipeline_registers = [[None]*5, None, [None]*5,
                                   [None]*5, [None]*5]
        self.pc = 0
        self.memories = [0] * 1024
        self.labels = {}
        self.forward1 = (None, None, None, None)
        self.forward2 = (None, None, None, None)
        self.instructions = []
        self.inst_count = 0
        self.clk = 0
        self.stall = [None, 0]
        self.stall2 = [None, 0]
        self.clock = 0
        self.perform_type = PerformType.from_string(ptype)
        self.btb = BTB()
        self.me = {}
        self.old_pc = None

        with open(file_path, 'r', encoding='utf-8') as file:
            for line in file:
                # Remove leading/trailing whitespace and newline characters
                line = line.strip()
                if line:
                    self.instructions.append(line)

        self.registers = {'x0': 0, 'x1': 0, 'x2': 0, 'x3': 0, 'x4': 0,
                          'x5': 0, 'x6': 0, 'x7': 0, 'x8': 0, 'x9': 0,
                          'x10': 0, 'x11': 0, 'x12': 0, 'x13': 0,
                          'x14': 0, 'x15': 0, 'x16': 0, 'x17': 0,
                          'x18': 0, 'x19': 0, 'x20': 0, 'x21': 0,
                          'x22': 0, 'x23': 0, 'x24': 0, 'x25': 0,
                          'x26': 0, 'x27': 0, 'x28': 0, 'x29': 0,
                          'x30': 0, 'x31': 0}

        self.reg_pipes = [[None]*5, [None]*5, [None]*5, [None]*5, [None]*5]

    def process_instructions(self):
        for idx, line in enumerate(self.instructions):
            line = line.strip()
            if line and ':' in line:
                # It's a label
                # Remove the ":" at the end of the label
                label = line[:-1]
                self.labels[label] = idx

    def check_hazard(self):
        decode_instr = self.pipeline_registers[0]
        execute_instr = self.pipeline_registers[1]
        memory_instr = self.pipeline_registers[2]
        exec_hazard = False
        mem_hazard = False

        if decode_instr is None or execute_instr is None:
            return (False, False)

        d_opcode = decode_instr[0]
        e_opcode = execute_instr['opcode']

        if memory_instr is not None:
            m_opcode = memory_instr[0]

# Detecta riesgos para instrucciones tipo R
        if d_opcode in R_TYPE:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE[0]):
                    execute_rd = execute_instr["rd"]
                    decode_rs1 = decode_instr[2].replace(",", "")
                    decode_rs2 = decode_instr[3].replace(",", "")

                    if execute_rd == decode_rs1:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

                    if execute_rd == decode_rs2:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs2")

                        else:
                            self.forward2 = (self.pc + 2, "rs2")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rs1 = decode_instr[2].replace(",", "")
                    decode_rs2 = decode_instr[3]

                    if memory_rd and (memory_rd in (decode_rs1, decode_rs2)):
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

# Detecta riesgos para instrucciones tipo I
        if d_opcode in I_TYPE:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE[0]):
                    execute_rd = execute_instr["rd"]
                    decode_rs1 = decode_instr[2].replace(",", "")

                    if execute_rd and (execute_rd == decode_rs1):
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rs1 = decode_instr[2].replace(",", "")

                    if memory_rd and (memory_rd == decode_rs1):
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

# Detecta riesgos para instrucciones lw
        if d_opcode in S_TYPE[0]:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE):
                    execute_rd = execute_instr["rd"]
                    decode_rs1 = decode_instr[2].replace(",", "")
                    indice_abierto = decode_rs1.find("(")
                    indice_cerrado = decode_rs1.find(")")
                    decode_rs1 = decode_rs1[indice_abierto+1:indice_cerrado]

                    if execute_rd == decode_rs1:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rs1 = decode_instr[2].replace(",", "")
                    indice_abierto = decode_rs1.find("(")
                    indice_cerrado = decode_rs1.find(")")
                    decode_rs1 = decode_rs1[indice_abierto+1:indice_cerrado]

                    if memory_rd == decode_rs1:
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

# Detecta riesgos para instrucciones sw
        if d_opcode in S_TYPE[1]:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE[0]):
                    execute_rd = execute_instr["rd"]
                    decode_rd = decode_instr[1].replace(",", "")
                    decode_rs1 = decode_instr[2]
                    indice_abierto = decode_rs1.find("(")
                    indice_cerrado = decode_rs1.find(")")
                    decode_rs1 = decode_rs1[indice_abierto+1:indice_cerrado]

                    if execute_rd == decode_rs1:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

                    if execute_rd == decode_rd:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rd")

                        else:
                            self.forward2 = (self.pc + 2, "rd")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rd = decode_instr[1].replace(",", "")
                    decode_rs1 = decode_instr[2].replace(",", "")
                    indice_abierto = decode_rs1.find("(")
                    indice_cerrado = decode_rs1.find(")")
                    decode_rs1 = decode_rs1[indice_abierto+1:indice_cerrado]

                    if memory_rd in (decode_rs1, decode_rd):
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

# Detecta riesgos para instrucciones tipo B
        if d_opcode in B_TYPE:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE[0]):
                    execute_rd = execute_instr["rd"]
                    decode_rs1 = decode_instr[1].replace(",", "")
                    decode_rs2 = decode_instr[2].replace(",", "")

                    if execute_rd == decode_rs1:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

                    if execute_rd == decode_rs2:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs2")

                        else:
                            self.forward2 = (self.pc + 2, "rs2")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rs1 = decode_instr[2].replace(",", "")
                    decode_rs2 = decode_instr[3]

                    if memory_rd and (memory_rd in (decode_rs1, decode_rs2)):
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

# Detecta riesgos para instrucciones jalr
        if d_opcode in J_TYPE[1]:
            if execute_instr and decode_instr:
                if (e_opcode in R_TYPE) or (e_opcode in I_TYPE) or (e_opcode in S_TYPE[0]):
                    execute_rd = execute_instr["rd"]
                    decode_rs1 = decode_instr[2].replace(",", "")

                    if execute_rd == decode_rs1:
                        exec_hazard = True
                        if e_opcode == S_TYPE[0]:
                            self.stall = [self.pc + 2, 1]

                        elif self.forward1[0] is None:
                            self.forward1 = (self.pc + 2, "rs1")

                        else:
                            self.forward2 = (self.pc + 2, "rs1")

            if memory_instr and decode_instr:
                if (m_opcode in R_TYPE) or (m_opcode in I_TYPE) or (m_opcode in S_TYPE[0]):
                    memory_rd = memory_instr[2]
                    decode_rs1 = decode_instr[2].replace(",", "")

                    if memory_rd and (memory_rd == decode_rs1):
                        mem_hazard = True

                    else:
                        mem_hazard = False

                else:
                    mem_hazard = False

        return (exec_hazard, mem_hazard)

    def fetch(self):
        if self.pc < len(self.instructions):
            line = self.instructions[self.pc].strip()
            if ':' in line:
                self.pc += 1
                return self.fetch()

            self.reg_pipes[0] = line.split().copy()
            self.reg_pipes[0].append(None)

            if self.perform_type in [PerformType.BOTH,
                                     PerformType.PREDICTION]:
                if self.reg_pipes[0][0] in B_TYPE:
                    asd = self.btb.lookup(self.pc)
                    asdf = None
                    self.old_pc = self.pc
                    if self.pc in self.me:
                        asdf = self.me[self.pc].obtener_estado_actual()
                        if self.btb.lookup(self.pc):
                            print(f'\n*****La predicción es {asdf}*****\n')
                    else:
                        print("\n*****La dirección del branch aún no se encuentra en la BTB*****\n")

                    if asd is not None and asdf == 'taken':
                        self.reg_pipes[0][4] = self.pc
                        if self.stall[0]:
                            if self.pc == self.stall[0]-1:
                                self.stall[0] = asd['target']+1

                        self.pc = asd['target']
                        print("\n*****Se utilizó branch prediction*****")
                        print(f"*****         PC nuevo: {asd['target']}        *****\n")

                elif self.reg_pipes[0][0] in J_TYPE:
                    asd = self.btb.lookup(self.pc)
                    self.reg_pipes[0].append(self.pc)

                    if asd is None:
                        print("\n*****La dirección del salto aún no se encuentra en la BTB*****\n")

                    else:
                        if self.stall[0]:
                            self.stall[0] = asd['target']+1

                        self.pc = asd['target']
                        print("\n*****Se utilizó branch prediction, jal siempre salta*****")
                        print(f"*****         PC nuevo: {asd['target']}        *****\n")

            self.clk += 1
            return self.reg_pipes[0]

        # No hay más instrucciones, se coloca None en la etapa de Fetch
        self.reg_pipes[0] = None
        return None

    # ETAPA DE DECODE
    def decode(self):
        components = self.pipeline_registers[0]

        if components is None:
            opcode = None
        else:
            opcode = components[0]

        if opcode in R_TYPE:
            rd = components[1].replace(",", "")
            rs1 = components[2].replace(",", "")
            rs2 = components[3].replace(",", "")
            decoded_instruction = {
                "opcode": opcode,
                "rd": rd,
                "rs1": rs1,
                "rs2": rs2
            }

        elif opcode in I_TYPE:
            rd = components[1].replace(",", "")
            rs1 = components[2].replace(",", "")
            immediate = components[3].replace(",", "")
            decoded_instruction = {
                "opcode": opcode,
                "rd": rd,
                "rs1": rs1,
                "immediate": immediate
            }

        elif opcode in S_TYPE:
            rd = components[1].replace(",", "")
            immediate = components[2].split("(")[0]
            rs1 = components[2].split("(")[1].replace(")", "")
            decoded_instruction = {
                "opcode": opcode,
                "rd": rd,
                "rs1": rs1,
                "immediate": immediate
            }

        elif opcode in B_TYPE:
            rs1 = components[1].replace(",", "")
            rs2 = components[2].replace(",", "")
            offset = components[3].replace(",", "")
            decoded_instruction = {
                "opcode": opcode,
                "rs1": rs1,
                "rs2": rs2,
                "offset": offset
            }

        elif opcode == 'jal':
            rd = components[1].replace(",", "")
            offset = components[2]
            decoded_instruction = {
                "opcode": opcode,
                "rd": rd,
                "offset": offset
            }

        elif opcode == 'jalr':
            rd = components[1].replace(",", "")
            offset = components[2].split("(")[0]
            rs1 = components[2].split("(")[1].replace(")", "")
            decoded_instruction = {
                "opcode": opcode,
                "rd": rd,
                "offset": offset,
                "rs1": rs1
            }

        elif opcode is None:
            decoded_instruction = None

        else:
            decoded_instruction = components[0].replace(":", "")

        self.reg_pipes[1] = decoded_instruction

        if decoded_instruction is not None:
            self.reg_pipes[1]['pred_dir'] = components[-1]

        return self.reg_pipes[1]

# ETAPA DE EXECUTE
    def execute(self, source=None, use_forwarding=False):
        decoded_instruction = self.pipeline_registers[1]

        if decoded_instruction is None:
            opcode = None

        else:
            opcode = decoded_instruction["opcode"]

        if opcode in R_TYPE:
            # Execute R-type instruction logic
            rd = decoded_instruction["rd"]
            rs1 = decoded_instruction["rs1"]
            rs2 = decoded_instruction["rs2"]

            if use_forwarding:
                if source[0] == "rs1":
                    rs1_val = source[1]
                    rs2_val = self.registers[rs2]

                if source[0] == "rs2":
                    rs1_val = self.registers[rs1]
                    rs2_val = source[1]
            else:
                rs1_val = self.registers[rs1]
                rs2_val = self.registers[rs2]

            result = rv.execute_r_type(opcode, rs1_val, rs2_val)
            result = [result, rd]

        elif opcode in I_TYPE:
            # Execute I-type instruction logic
            rd = decoded_instruction["rd"]
            rs1 = decoded_instruction["rs1"]

            if use_forwarding:
                if source[0] == "rs1":
                    rs1_val = source[1]
            else:
                rs1_val = self.registers[rs1]

            immediate = decoded_instruction["immediate"]
            immediate = int(immediate)
            result = rv.execute_i_type(opcode, rs1_val, immediate)
            result = [result, rd]

        elif opcode in B_TYPE:
            # Execute B-type instruction logic
            rs1 = decoded_instruction["rs1"]
            rs2 = decoded_instruction["rs2"]

            if use_forwarding:
                if source[0] == "rs1":
                    rs1_val = source[1]
                    rs2_val = self.registers[rs2]

                if source[0] == "rs2":
                    rs1_val = self.registers[rs1]
                    rs2_val = source[1]
            else:
                rs1_val = self.registers[rs1]
                rs2_val = self.registers[rs2]

            offset = decoded_instruction["offset"]
            offset_pos = self.labels[offset]
            current_pc = self.pc
            result = rv.execute_b_type(opcode, rs1_val, rs2_val,
                                       offset_pos, self.pc)
            self.pc = result
            result = [self.pc]
            if current_pc != self.pc and \
               self.perform_type in [PerformType.NONE,
                                     PerformType.FORWARDING]:
                print("\n*****Se tomó el branch, se hace flush*****\n")
                self.reg_pipes[0] = None
                self.reg_pipes[1] = None

            elif decoded_instruction['pred_dir'] is not None:
                if decoded_instruction['pred_dir'] not in self.me:
                    self.me[decoded_instruction['pred_dir']] = ME()

                actual = self.me[decoded_instruction['pred_dir']]. \
                    obtener_estado_actual()

                if current_pc == self.pc:

                    if actual == 'taken':
                        print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                        self.reg_pipes[0] = None
                        self.reg_pipes[1] = None
                        self.pc = decoded_instruction['pred_dir']

                    self.me[decoded_instruction['pred_dir']]. \
                        procesar_evento('!taken')

                else:
                    self.pc = current_pc
                    self.me[decoded_instruction['pred_dir']].procesar_evento('taken')

                    if self.btb.lookup(decoded_instruction['pred_dir']) is None or \
                       actual == "!taken":
                        if self.btb.lookup(decoded_instruction['pred_dir']) is None:
                            print("\n*****El branch aun no está en la BTB*****\n")
                        elif actual == "!taken":
                            print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                        self.btb.update(decoded_instruction['pred_dir'], self.pc)
                        self.reg_pipes[0] = None
                        self.reg_pipes[1] = None

            elif decoded_instruction['pred_dir'] is None:
                line1 = self.instructions[current_pc-1].strip()
                line2 = self.instructions[current_pc-2].strip()

                if ':' in line1 or ':' in line2:
                    current_pc -= 1
                    if current_pc-2 not in self.me:
                        self.me[current_pc-2] = ME()

                    actual = self.me[current_pc-2].obtener_estado_actual()

                    if current_pc+1 == self.pc:

                        if actual == 'taken':
                            print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                            self.reg_pipes[0] = None
                            self.reg_pipes[1] = None

                        self.me[current_pc-2].procesar_evento('!taken')

                    else:
                        self.me[current_pc-2].procesar_evento('taken')

                        if self.btb.lookup(current_pc-2) is None or \
                           actual == "!taken":
                            if self.btb.lookup(current_pc-2) is None:
                                print("\n*****El branch aun no está en la BTB*****\n")
                            elif actual == "!taken":
                                print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                            self.btb.update(self.old_pc, self.pc)
                            self.old_pc = None
                            self.reg_pipes[0] = None
                            self.reg_pipes[1] = None

                else:
                    if current_pc-2 not in self.me:
                        self.me[current_pc-2] = ME()

                    actual = self.me[current_pc-2].obtener_estado_actual()

                    if current_pc == self.pc:

                        if actual == 'taken':
                            print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                            self.reg_pipes[0] = None
                            self.reg_pipes[1] = None

                        self.me[current_pc-2].procesar_evento('!taken')

                    else:
                        self.me[current_pc-2].procesar_evento('taken')

                        if self.btb.lookup(current_pc-2) is None or \
                           actual == "!taken":
                            if self.btb.lookup(current_pc-2) is None:
                                print("\n*****El branch aun no está en la BTB*****\n")
                            elif actual == "!taken":
                                print(f"\n*****Se predijo {actual} incorrectamente, se hace flush*****\n")
                            self.btb.update(current_pc-2, self.pc)
                            self.reg_pipes[0] = None
                            self.reg_pipes[1] = None

        elif opcode in S_TYPE:
            # Execute S-type instruction logic
            rd = decoded_instruction["rd"]
            rd_val = self.registers[rd]
            rs1 = decoded_instruction["rs1"]

            if use_forwarding:
                if source[0] == "rs1":
                    rs1_val = source[1]
                else:
                    rs1_val = self.registers[rs1]

                if source[0] == "rd":
                    rd_val = source[1]

            else:
                rs1_val = self.registers[rs1]

            immediate = decoded_instruction["immediate"]
            result = rv.execute_s_type(opcode, rs1_val, immediate)

            if opcode == 'sw':
                result = [result, rd_val]

            else:
                result = [result, rd]

        elif opcode == 'jal':
            # Execute J-type instruction logic
            rd = decoded_instruction["rd"]
            rd_val = self.registers[rd]
            offset = decoded_instruction["offset"]
            offset_pos = self.labels[offset]
            pc_next = self.pc+1
            result = rv.execute_jal(offset_pos, rd_val, pc_next)
            rd_val = result[1]
            result = [result[0], rd, result[1]]

            if self.perform_type in [PerformType.NONE,
                                     PerformType.FORWARDING]:
                print("\n*****Se tomó el jump, se hace flush*****\n")
                self.reg_pipes[0] = None
                self.reg_pipes[1] = None
                self.pc = result[0]

            else:
                if self.btb.lookup(decoded_instruction['pred_dir']) is None:
                    print("\n*****El jump aun no está en la BTB*****\n")
                    self.reg_pipes[0] = None
                    self.reg_pipes[1] = None
                    self.pc = result[0]
                    self.btb.update(decoded_instruction['pred_dir'], self.pc)

        elif opcode == 'jalr':
            # Execute J-type instruction logic
            rd = decoded_instruction["rd"]
            rd_val = self.registers[rd]
            rs1 = decoded_instruction["rs1"]

            if use_forwarding:
                if source[0] == "rs1":
                    rs1_val = source[1]
            else:
                rs1_val = self.registers[rs1]

            offset = decoded_instruction["offset"]
            pc_next = self.pc+1
            result = rv.execute_jalr(rs1_val, rd_val, int(offset), pc_next)
            rd_val = result[1]
            result = [result[0], rd, result[1]]

            if self.perform_type in [PerformType.NONE,
                                     PerformType.FORWARDING]:
                print("\n*****Se tomó el jump, se hace flush*****\n")
                self.reg_pipes[0] = None
                self.reg_pipes[1] = None
                self.pc = result[0]

            else:
                if self.btb.lookup(decoded_instruction['pred_dir']) is None:
                    print("\n*****El jump aun no está en la BTB*****\n")
                    self.reg_pipes[0] = None
                    self.reg_pipes[1] = None
                    self.pc = result[0]
                    self.btb.update(decoded_instruction['pred_dir'], self.pc)

        elif opcode is None:
            self.reg_pipes[2] = None
            return None

        else:
            raise ValueError("Invalid opcode")

        result.insert(0, opcode)
        self.reg_pipes[2] = result
        return self.reg_pipes[2]

# ETAPA DE MEMORY
    def memory(self):
        result = self.pipeline_registers[2]

        if result is None:
            opcode = None

        else:
            opcode = result[0]

        if opcode == "sw":
            # Store word instruction
            address = result[1]
            data = result[2]
            # Perform memory store operation
            self.memories[address] = data
            # Memory access does not produce a result for this instruction
            memory_result = result

        elif opcode == "lw":

            # Load word instruction
            address = result[1]
            # Perform memory load operation
            memory_result = [opcode, result[2], self.memories[address]]

        elif opcode is None:
            memory_result = None

        else:
            # Other instructions that do not involve memory access
            memory_result = self.pipeline_registers[2]

        self.reg_pipes[3] = memory_result

        return self.reg_pipes[3]

# ETAPA DE WRITE BACK
    def write_back(self):
        memory_result = self.pipeline_registers[3]
        for stage in self.pipeline_registers:
            if stage is None:
                self.clk = self.clk

            elif all(element is None for element in stage):
                self.clk = self.clk

            else:
                self.clk += 1

        if memory_result is None:
            opcode = None
            self.inst_count = self.inst_count
            print("Write back: ", memory_result)

        else:
            self.inst_count += 1
            opcode = memory_result[0]

        if opcode in R_TYPE or opcode in I_TYPE:
            # Get the destination register (rd)
            rd = memory_result[2]
            # Update the register file with the result
            self.registers[rd] = memory_result[1]
            print("Write back: ", memory_result)

        elif opcode == "lw":
            # Get the destination register (rd)
            rd = memory_result[1]
            # Update the register file with the value loaded from memory
            self.registers[rd] = memory_result[2]
            print("Write back: ", memory_result)

        elif opcode == "sw":
            self.clk -= 1
            print("Write back: ", memory_result)

        elif opcode in J_TYPE:
            rd = memory_result[2]
            self.registers[rd] = memory_result[3]
            print("Write back: ", memory_result)

        elif opcode in B_TYPE:
            self.clk -= 2
            print("Write back: ", memory_result)

    def write_pipeline(self):
        var = self.reg_pipes.copy()
        self.pipeline_registers = var

    def forwarding(self):

        if self.pc == self.forward1[0]:
            reg = self.forward1[1]
            print("\n*****Se utilizó forwarding*****\n")

            self.forward1 = (None, None)
            return (reg, self.pipeline_registers[2][1], True)

        if self.pc == self.forward2[0]:
            reg = self.forward2[1]
            print("\n*****Se utilizó forwarding*****\n")

            self.forward2 = (None, None)
            return (reg, self.pipeline_registers[2][1], True)

        return (None, None, False)

# FUNCION PARA EJECUTAR TODO

    def run(self):
        self.process_instructions()
        pipeline_empty = False

        while not pipeline_empty:

            self.clock += 1

            print(" _______________________________")
            print("|                               |")
            print("|                               |")
            print(f'|      Posición del pc: {self.pc}      |')
            print("|                               |")
            print("|_______________________________|\n")

            # WRITE BACK
            self.write_back()

            # MEMORY
            memory_result = self.memory()
            print("Memory:     ", memory_result)

            # Forwarding
            if self.perform_type in [PerformType.FORWARDING, PerformType.BOTH]:
                forward = self.forwarding()

            # DECODE
            if self.pc != self.stall[0] and self.pc != self.stall2[0]:
                decoded_instruction = self.decode()

            # FETCH
            if self.pc != self.stall[0] and self.pc != self.stall2[0]:
                fetched_instruction = self.fetch()

            if self.stall[0]:
                if self.pc == self.stall[0]:
                    print("\n*****Se utilizó un stall de ejecución*****\n")
                    if self.stall[1] == 2:
                        self.stall[1] = 1
                    else:
                        self.stall = [None, 0]
                    self.pipeline_registers[1] = None
                    self.pc = self.pc - 1

            elif self.stall2[0]:
                if self.pc == self.stall2[0]:
                    print("\n*****Se utilizó un stall de memoria*****\n")
                    if self.stall2[1] == 2:
                        self.stall2[1] = 1
                    else:
                        self.stall2 = [None, 0]
                    self.pipeline_registers[1] = None
                    self.pc = self.pc - 1

#            self.old_pc = self.pc
            # EXECUTE
            if self.perform_type in [PerformType.FORWARDING, PerformType.BOTH]:
                executed_result = self.execute(forward[:2], forward[2])
            else:
                executed_result = self.execute()

            print("Execute:    ", executed_result)

            print("Decode:     ", decoded_instruction)
            print("Fetch:      ", fetched_instruction)

            self.write_pipeline()

            # CHECK HAZARDS
            exe, mem = self.check_hazard()

            if exe:
                print("\n*****Will be a hazard from execution*****")
                if self.perform_type in [PerformType.NONE, PerformType.PREDICTION]:
                    self.stall = [self.pc + 2, 2]

            if mem:
                print("\n*****Will be a hazard from memory*****")
                if self.perform_type in [PerformType.NONE, PerformType.PREDICTION]:
                    if not exe:
                        self.stall2 = [self.pc + 2, 1]

            result = memory_result

            self.pc += 1

            print("\nEstado de los registros:\n")
            print(self.registers)
            print("_____________________________________________________________________\n\n")

            # Revisa si el pipeline esta vacio
            pipeline_empty = fetched_instruction is None and \
                decoded_instruction is None and \
                executed_result is None and \
                memory_result is None

#            esperar_tecla()

        print("---------- Fin de ejecución ----------")
        self.pc -= 1
        self.btb.print_content()
        return result
