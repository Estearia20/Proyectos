addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24          # ra = dir mem 2024

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20          # sp = dir mem 2020

addi t4, zero, 0x20
slli t4, t4, 8             # t4 = dir mem 2000
       

addi a1, zero, 1          # constante con valor 1
addi s10, zero, 0xa       # constante con cambio de linea
addi s11, zero, 0xd       # constante con corri carro

reset_tecla_tex:
       
    sw zero, 0(t4)           # mete un 0 en el teclado   

rev:
    lw s8, 0(t4)
    beq s8, zero, modo_texto
    beq zero, zero, rev
	
modo_texto:    

    lw a0,0(t4)                  # lee el teclado y guarda el valor en sp
    beq a0, zero, modo_texto     # verifica si es un 0 se queda esperando un valor
    beq a0, s11, mandar_enter_1  # verifica si es un enter
    sw a0, 0(ra)                 # manda a la direccion 2024 el dato del teclado 
    sw a1, 0(sp)                 # manda a la direccion 2020 un 1

revisa:   
                  
    lw a2, 0(sp)                    # se lee el reg de control del uart
    beq a2, a1, revisa              # si a0 == 1 se queda esperando hasta que sea 0 
    beq a2, zero, reset_tecla_tex   # termina el ciclo y vuelve a modo texto

mandar_enter_1:

    sw s10, 0(ra)                # manda a la direccion 2024 el dato del teclado 
    sw a1, 0(sp)                 # manda a la direccion 2020 un 1

revisa_uno:

    lw a2, 0(sp)                           # se lee el reg de control del uart
    beq a2, a1, revisa_uno             # si a0 == 1 se queda esperando hasta que sea 0 
    beq a2, zero, mandar_enter_2       # termina el ciclo y vuelve a modo texto
        
mandar_enter_2:

    sw s11, 0(ra)                  # manda a la direccion 2024 el dato del teclado 
    sw a1, 0(sp)                   # manda a la direccion 2020 un 1

revisa_dos:

    lw a2, 0(sp)                      # se lee el reg de control del uart
    beq a2, a1, revisa_dos            # si a0 == 1 se queda esperando hasta que sea 0 
    beq a2, zero, reset_tecla_tex     # termina el ciclo y vuelve a modo texto