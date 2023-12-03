addi s10, zero, 0xA
addi s11, zero, 0xB
addi t0, zero, 0xC
addi t1, zero, 0xD
addi t2, zero, 0xE
addi t3, zero, 0xF

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20          # 	control uart

addi gp, zero, 0x20
slli gp, gp, 8             # 	teclado

addi tp, zero, 0x22
slli tp, tp, 8		   #	data spi

addi ra, zero, 0          # contador, es 0 ó 1 solamente
addi a0, zero, 1          # constante con valor 1



lw t4, 0(tp)		# lee dato sensor
srli a1, t4, 4		# t2 = 4 bis mas significativos


inicio:

	beq a1, s10, envia_letra
	beq a1, s11, envia_letra
	beq a1, t0, envia_letra
	beq a1, t1, envia_letra
	beq a1, t2, envia_letra
	beq a1, t3, envia_letra

envia:
	addi s0, a1, 0x30
	sw s0, 4(sp)			# guarda en el registro de datos el ascii
	sw a0, 0(sp)			# guarda en registro de control el 1
	beq zero, zero, revisa		# envia a revisa

envia_letra:
	addi s0, a1, 0x37
	sw s0, 4(sp)			# guarda en el registro de datos el ascii
	sw a0, 0(sp)			# guarda en registro de control el 1
	beq zero, zero, revisa		# envia a revisa

revisa:
	lw s2 0(sp)
	beq s2, a0, revisa

slli a1, t4, 28		# borra 4 bits mas significativos
srli a1, a1, 28		# t1 = 4 bits menos significativos del dato
addi ra, ra, 0x1	# aumenta el contador
beq ra, a0, inicio

fin:
	beq zero, zero, fin





