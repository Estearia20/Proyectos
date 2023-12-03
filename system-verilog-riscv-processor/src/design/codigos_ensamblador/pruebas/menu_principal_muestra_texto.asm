############################################################################################ INICIO MENU PRINCIPAL
menu_principal:

addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24           # ra = dir mem 2024       uart_data

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20           # sp = dir mem 2020       uart_ctrl

addi gp, zero, 0x20
slli gp, gp, 8             # gp = dir mem 2000       teclado

addi t5, zero, 0x30
slli t5, t5, 8             # t5 = dir mem 3000       ROM de texto

addi s9, zero, 0x30b       # direccion maxima a la que llega a leer
slli s9, s9, 8
addi s9, s9, 0x164            

addi a1, zero, 1             # constante con valor 1
addi t0, zero, 0x05          # constante con valor F1
addi t1, zero, 0x06          # constante con valor F2
addi t2, zero, 0x04          # constante con valor F3

###################################################################################### MOSTRAR TEXTO DE MENU

loop_lector:

	lw s1, 0(t5)
	addi t5, t5, 0x4
	beq t5, s9, fin
    beq zero, zero, mandar_texto_menu

mandar_texto_menu:

    sw s1, 0(ra)                   # manda a la direccion 2024 el caracter 
	sw a1, 0(sp)                   # manda a la direccion 2020 un 1

revisa_mandar_texto:

	lw a2, 0(sp)                               # se lee el reg de control del uart
    beq a2, a1, revisa_mandar_texto            # si a0 == 1 se queda esperando hasta que sea 0 
    
    beq a2, zero, loop_lector                  # termina el ciclo y vuelve a modo texto

fin:

###################################################################################### FIN MOSTRAR TEXTO DE MENU