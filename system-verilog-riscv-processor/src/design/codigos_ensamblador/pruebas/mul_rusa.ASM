
addi s0, zero, 0x9
addi s4, zero, 0x7

addi t3, zero, 1            # variable para contar de 1 en 1
add a0, zero, s0
addi t6, zero, 0


ruso:
    srli s9, s0, 0x1        # corrimiento a la derecha, divide a la mitad 
	add s9, s9, s9     
	sub a0, a0, s9
	beq a0, zero, es_par
	beq t3, t3, es_impar
	
es_impar:
	add t6, t6, s4         # suma
	beq s0, t3, fin_ruso
	srli s0, s0, 0x1       # corrimiento a la derecha, divide a la mitad
	slli s4, s4, 0x1       # corrimiento a la izquierda, duplica el valor
	addi a0, zero, 0       # reinicia el registro a0
	add a0, a0, s0
	beq t3, t3, ruso
	
es_par:
	srli s0, s0, 0x1
	slli s4, s4, 0x1
	addi a0, zero, 0       # reinicia el registro a0
	add a0, a0, s0  
	beq t3, t3, ruso
	
fin_ruso:
