"""Archivo con funciones para instrucciones RV32I

    Args:
        opcode: mnemónico
        immediate: valor inmediato
        label: sitio en donde saltar tras instruccion
        rs1: contenido del registro fuente 1
        rs2: contenido del registro fuente 2

    """


# Ejecucion de instrucciones tipo R
def execute_r_type(opcode, rs1, rs2):
    if opcode == "add":
        result = execute_add(rs1, rs2)
    elif opcode == "sub":
        result = execute_sub(rs1, rs2)
    elif opcode == "sll":
        result = execute_sll(rs1, rs2)
    elif opcode == "slt":
        result = execute_slt(rs1, rs2)
    elif opcode == "sltu":
        result = execute_sltu(rs1, rs2)
    elif opcode == "xor":
        result = execute_xor(rs1, rs2)
    elif opcode == "srl":
        result = execute_srl(rs1, rs2)
    elif opcode == "sra":
        result = execute_sra(rs1, rs2)
    elif opcode == "or":
        result = execute_or(rs1, rs2)
    elif opcode == "and":
        result = execute_and(rs1, rs2)
    elif opcode == "mul":
        result = execute_mul(rs1, rs2)

    return result


# Ejecucion mul
def execute_mul(rs1, rs2):
    # Perform the addition operation
    result = rs1 * rs2

    return result


# Ejecucion ADD
def execute_add(rs1, rs2):
    # Perform the addition operation
    result = rs1 + rs2

    return result


# Ejecucion SUB
def execute_sub(rs1, rs2):
    # Perform the sub operation
    result = rs1 - rs2

    return result


# Ejecución SLL
def execute_sll(rs1, rs2):
    # Perform the logical left shift operation
    result = rs1 << rs2

    return result


# Ejecución SLT
def execute_slt(rs1, rs2):
    # Perform the comparison operation
    result = int(rs1 < rs2)

    return result


# Ejecución SLTU
def execute_sltu(rs1, rs2):
    # Perform the comparison operation (unsigned)
    result = int(abs(rs1) < abs(rs2))

    return result


# Ejecución XOR
def execute_xor(rs1, rs2):
    # Perform the XOR operation
    result = rs1 ^ rs2

    return result


# Ejecución SRL
def execute_srl(rs1, rs2):
    # Perform the logical right shift operation
    result = rs1 >> rs2

    return result


# Ejecución SRA  (REVISAR)
def execute_sra(rs1, rs2):
    # Perform the arithmetic right shift operation
    result = abs(rs1) >> abs(rs2)

    return result


# Ejecución OR
def execute_or(rs1, rs2):
    # Perform the logical OR operation
    result = rs1 | rs2

    return result


# Ejecución AND
def execute_and(rs1, rs2):
    # Perform the logical AND operation
    result = rs1 & rs2

    return result


# Ejecucion de instrucciones tipo I
def execute_i_type(opcode, rs1, immediate):
    if opcode == "addi":
        result = execute_addi(rs1, immediate)
    elif opcode == "andi":
        result = execute_andi(rs1, immediate)
    elif opcode == "ori":
        result = execute_ori(rs1, immediate)
    elif opcode == "xori":
        result = execute_xori(rs1, immediate)
    elif opcode == "slti":
        result = execute_slti(rs1, immediate)
    elif opcode == "sltiu":
        result = execute_sltiu(rs1, immediate)
    elif opcode == "ori":
        result = execute_slli(rs1, immediate)
    elif opcode == "srli":
        result = execute_srli(rs1, immediate)
    elif opcode == "srai":
        result = execute_srai(rs1, immediate)
    elif opcode == "slli":
        result = execute_slli(rs1, immediate)

    return result


# Ejecución ADDI
def execute_addi(rs1, immediate):
    # Perform the immediate addition operation
    result = rs1 + immediate

    return result


# Ejecución ANDI
def execute_andi(rs1, immediate):
    # Perform the immediate AND operation
    result = rs1 & immediate

    return result


# Ejecución ORI
def execute_ori(rs1, immediate):
    # Perform the immediate OR operation
    result = rs1 | immediate

    return result


# Ejecución XORI
def execute_xori(rs1, immediate):
    # Perform the immediate XOR operation
    result = rs1 ^ immediate

    return result


# Ejecución SLTI
def execute_slti(rs1, immediate):
    # Perform the immediate signed comparison
    result = int(rs1 < immediate)

    return result


# Ejecución SLTIU
def execute_sltiu(rs1, immediate):
    # Perform the immediate unsigned comparison
    result = int(abs(rs1) < immediate)

    return result


# Ejecución SLLI
def execute_slli(rs1, immediate):
    # Perform the logical left shift operation
    result = rs1 << immediate

    return result


# Ejecución SRLI
def execute_srli(rs1, immediate):
    # Perform the logical right shift operation
    result = rs1 >> immediate

    return result


# Ejecución SRAI
def execute_srai(rs1, immediate):
    # Perform the arithmetic right shift operation
    result = abs(rs1) >> immediate

    return result


def execute_b_type(opcode, rs1, rs2, offset, current_pc):

    if opcode == "beq":
        result = execute_beq(rs1, rs2, offset, current_pc)
    elif opcode == "bne":
        result = execute_bne(rs1, rs2, offset, current_pc)
    elif opcode == "blt":
        result = execute_blt(rs1, rs2, offset, current_pc)
    elif opcode == "bge":
        result = execute_bge(rs1, rs2, offset, current_pc)
    elif opcode == "bltu":
        result = execute_bltu(rs1, rs2, offset, current_pc)
    elif opcode == "bgeu":
        result = execute_bgeu(rs1, rs2, offset, current_pc)

    return result


# Ejecucion BEQ
def execute_beq(rs1, rs2, offset, current_pc):

    if rs1 == rs2:
        result = offset
    else:
        result = current_pc

    return result


# Ejecucion BNE
def execute_bne(rs1, rs2, offset, current_pc):

    if rs1 != rs2:
        result = offset
    else:
        result = current_pc
    return result


# Ejecucion BLT
def execute_blt(rs1, rs2, offset, current_pc):

    if rs1 < rs2:
        result = offset
    else:
        result = current_pc
    return result


# Ejecucion BGE
def execute_bge(rs1, rs2, offset, current_pc):

    if rs1 >= rs2:
        result = offset
    else:
        result = current_pc
    return result


# Ejecucion BLTU
def execute_bltu(rs1, rs2, offset, current_pc):

    if rs1 < abs(rs2):
        result = offset
    else:
        result = current_pc
    return result


# Ejecucion BGEU
def execute_bgeu(rs1, rs2, offset, current_pc):

    if rs1 >= abs(rs2):
        result = offset
    else:
        result = current_pc
    return result


def execute_s_type(opcode, rs1, immediate):
    if opcode == "sw":
        result = execute_sw(rs1, immediate)
    elif opcode == "lw":
        result = execute_lw(rs1, immediate)

    return result


# Ejecucion SW
def execute_sw(rs1, immediate):
    address = rs1 + int(immediate)

    return address


# Ejecucio LW
def execute_lw(rs1, immediate):
    address = rs1 + int(immediate)

    return address


# Ejecución JAL
def execute_jal(offset, rd, pc_next):

    # Calcula la dirección de destino sumando el offset al PC actual
    rd = pc_next
    address = [offset, rd]

    return address


# Ejecución JALR
def execute_jalr(rs1, rd, offset, pc_next):
    # Calcula la dirección de destino sumando el
    # inmediato al valor del registro fuente
    rd = pc_next
    address = [rs1+offset, rd]

    return address
