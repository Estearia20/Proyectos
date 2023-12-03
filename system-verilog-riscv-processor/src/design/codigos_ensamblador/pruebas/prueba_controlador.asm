addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24          # ra = dir mem 2024

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20          # sp = dir mem 2020

addi gp, zero, 0x1         # gp = 1

addi s0, zero, 0x53        # guarda el codigo del S
addi s1, zero, 0x65        # guarda el codigo del e
addi s2, zero, 0x6c        # guarda el codigo del l
addi s3, zero, 0x65        # guarda el codigo del e
addi s4, zero, 0x63        # guarda el codigo del c
addi s5, zero, 0x63        # guarda el codigo del c
addi s6, zero, 0x69        # guarda el codigo del i
addi s7, zero, 0x6f        # guarda el codigo del o
addi s8, zero, 0x6e        # guarda el codigo del n
addi s9, zero, 0x65        # guarda el codigo del e
 
addi a0, zero, 1           # contador

addi a1, zero, 1           # Letra 1
addi a2, zero, 2           # Letra 2
addi a3, zero, 3           # Letra 3
addi a4, zero, 4           # Letra 4
addi a5, zero, 5           # Letra 5
addi a6, zero, 6           # Letra 6
addi a7, zero, 7           # Letra 7
addi t3, zero, 8           # Letra 8
addi t4, zero, 9           # Letra 9
addi t5, zero, 10          # Letra 10
 
	
envia_letra:
beq a0, a1, letra_1
beq a0, a2, letra_2
beq a0, a3, letra_3
beq a0, a4, letra_4
beq a0, a5, letra_5
beq a0, a6, letra_6
beq a0, a7, letra_7
beq a0, t3, letra_8
beq a0, t4, letra_9
beq a0, t5, letra_10

letra_1:
	sw s0, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART

	beq zero, zero, revisa

letra_2:
	sw s1, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa
letra_3:
	sw s2, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_4:
	sw s3, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_5:
	sw s4, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_6:
	sw s5, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_7:
	sw s6, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_8:
	sw s7, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_9:
	sw s8, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa

letra_10:
	sw s9, 0(ra)              # Guarda la letra S en el registro de teclado
	sw gp, 0(sp)              # Pone un 1 en el reg control del UART
	beq zero, zero, revisa


revisa:
    lw t0, 0(sp)               # se lee el reg de control del uart
    beq t0, gp, revisa         # Si el registro de t0 es 1, se encicla hasta lo contrario
    beq a0, t5, envia_sig
    addi a0, a0, 1
    beq zero, zero, envia_letra

envia_sig:
    beq zero, zero, envia_sig
