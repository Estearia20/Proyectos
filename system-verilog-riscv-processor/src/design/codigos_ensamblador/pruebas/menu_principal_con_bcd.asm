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

addi s9, zero, 0x30        # direccion maxima a la que llega a leer
slli s9, s9, 8
addi s9, s9, 0x184

addi a1, zero, 1             # constante con valor 1
addi t0, zero, 0x05          # constante con valor F1
addi t1, zero, 0x06          # constante con valor F2
addi t2, zero, 0x04          # constante con valor F3

###################################################################################### MOSTRAR TEXTO DE MENU

loop_lector:

	lw s1, 0(t5)
	addi t5, t5, 0x4
	beq t5, s9, sel_modo
    beq zero, zero, mandar_texto_menu

mandar_texto_menu:

    sw s1, 0(ra)                   # manda a la direccion 2024 el caracter 
	sw a1, 0(sp)                   # manda a la direccion 2020 un 1

revisa_mandar_texto:

	lw a2, 0(sp)                               # se lee el reg de control del uart
    beq a2, a1, revisa_mandar_texto            # si a0 == 1 se queda esperando hasta que sea 0 
    
    beq a2, zero, loop_lector                  # termina el ciclo y vuelve a modo texto

#reset_sel:

#	sw zero, 0(gp)               # mete un 0 en el teclado   

#rev1:                             # revisa que ya haya un 0 en el teclado
#	lw t3, 0(gp)
#	beq t3, zero, sel_modo
#	beq zero, zero, rev1

sel_modo:    

	lw t4, 0(gp)                  # lee el teclado y guarda el valor en t4
	beq t4, t0, modo_texto        # verifica si es un F1 se queda esperando un valor
	beq t4, t1, modo_calculadora1 # verifica si es un F2 se queda esperando un valor
	beq t4, t2, modo_sensor       # verifica si es un F3 se queda esperando un valor
	beq zero, zero, sel_modo      # si es otra tecla reinicia y queda esperando
	
modo_texto:
####
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
addi a3, zero, 0x1b       # guarda en a3 el ascii del ESC

reset_tecla_tex:

sw zero, 0(t4)           # mete un 0 en el teclado   

rev:
	lw s8, 0(t4)
	beq s8, zero, modo_text
	beq zero, zero, rev

modo_text:

	lw a0, 0(t4)                 # lee el teclado y guarda el valor en sp
	beq a0, zero, modo_text      # verifica si es un 0 se queda esperando un valor
	beq a0, s11, mandar_enter_1  # verifica si es un enter
    beq a0, a3, menu_principal   # verifica si es esc y envia al menu
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

	lw a2, 0(sp)                       # se lee el reg de control del uart
    beq a2, a1, revisa_uno             # si a0 == 1 se queda esperando hasta que sea 0
    beq a2, zero, mandar_enter_2       # termina el ciclo y vuelve a modo texto

mandar_enter_2:

    sw s11, 0(ra)                  # manda a la direccion 2024 el dato del teclado
	sw a1, 0(sp)                   # manda a la direccion 2020 un 1

revisa_dos:

	lw a2, 0(sp)                      # se lee el reg de control del uart
    beq a2, a1, revisa_dos            # si a0 == 1 se queda esperando hasta que sea 0
    beq a2, zero, reset_tecla_tex     # termina el ciclo y vuelve a modo texto
####


modo_calculadora1:

############################################################################################ INICIO MODO CALCULADORA

addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24          # ra = dir mem 2024 UART_data  = 1

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20          # sp = dir mem 2020 UART_ctrl  = 2

addi t4, zero, 0x20
slli t4, t4, 8             # t4 = dir mem 2000 teclado    = 3

addi s11, zero, 0x10
slli s11, s11, 8             # s11 = dir mem 1000 RAM   

addi a1, zero, 1           # guarda un 1 para escribirlo en el UART_ctrl
addi t0, zero, 0x1b        # guarda el valor de ESC
addi s1, zero, 0x39        # guarda el código del 9 
addi t1, zero, 0           # guarda un 1 para el contador de digitos
addi t3, zero, 0x2b        # guarda el codigo de la suma
addi t2, zero, 0x2d        # guarda el codigo de la resta
addi t5, zero, 0x2a        # guarda el codigo de la multiplicacion
addi t6, zero, 0x0d        # guarda el codigo del enter


reset_teclado:
    sw zero, 0(t4)             # mete un 0 en el teclado   
    addi s0, zero, 0x30        # guarda el codigo del 0 contador para los numeros


revi:

	lw s8, 0(t4)
	beq s8, zero, modo_calculadora
	beq zero, zero, revi

modo_calculadora:
		
	lw gp, 0(t4)                      # lee el teclado y guarda el valor en sp


espera:

    beq gp, zero, modo_calculadora
    beq zero, zero, contador_num

contador_num:
    beq t1, zero, veri_num1
    beq t1, ra, veri_num_op1            # equivale al primer digito del primer numero? 
    beq t1, sp, veri_num_op2            # equivale al segundo digito del primer numero?
    beq t1, t4, veri_op                 # equivale al tercer digito del primer numero?
    beq t1, t3, veri_num2               # equivale al primer digito del segundo numero ?
    beq t1, t2, veri_num_enter1         # equivale al segundo digito del segundo numero ?
    beq t1, t5, veri_num_enter2         # equivale al tercer digito del segundo numero ?
    beq t1, t6, veri_enter              # equivale al enter?
#####################################


veri_num1:
    beq gp, t0, menu_principal        # revisa ESC
    beq gp, s0, mandar1
    beq s0, s1, reset_teclado
    addi s0, s0, 1
    beq zero, zero, veri_num1

mandar1:
    add t1, zero, ra
    sw gp, 0(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

enviar_dato:
    sw gp, 0(ra)                 # manda a la direccion 2024 el dato del teclado
    sw a1, 0(sp)                 # manda a la direccion 2020 un 1

rev_num1:
    lw a2, 0(sp)                    # se lee el reg de control del uart
    beq a2, a1, rev_num1            # si a0 == 1 se queda esperando hasta que sea 0 
    beq a2, zero, reset_teclado     # termina el ciclo y vuelve a modo texto

##################################

veri_op:
    beq gp, t3, mandar_suma              # verifca si lo que se ingresa es una suma
    beq gp, t2, mandar_resta             # verifca si lo que se ingresa es una resta
    beq gp, t5, mandar_multi             # verifca si lo que se ingresa es una multiplicacion
    beq zero, zero, reset_teclado

mandar_suma:
    add t1, zero, t3
    sw t3, 0xc(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_resta:
    add t1, zero, t3
    sw t2, 0xc(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_multi:
    add t1, zero, t3
    sw t5, 0xc(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

########################################

veri_num_op1: 
    beq gp, s0, mandar_num_op1  
    beq s0, s1, es_op1
    addi s0, s0, 1     
    beq zero, zero, veri_num_op1

mandar_num_op1:
    add t1, zero, sp
    sw gp, 4(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

es_op1:
    beq gp, t3, mandar_suma_op1              # verifca si lo que se ingresa es una suma
    beq gp, t2, mandar_resta_op1             # verifca si lo que se ingresa es una resta
    beq gp, t5, mandar_multi_op1             # verifca si lo que se ingresa es una multiplicacion
    beq zero, zero, reset_teclado

mandar_suma_op1:
    add t1, zero, t3
    sw t3, 4(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_resta_op1:
    add t1, zero, t3
    sw t2, 4(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_multi_op1:
    add t1, zero, t3
    sw t5, 4(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

##########################################

veri_num_op2: 
    beq gp, s0, mandar_num_op2  
    beq s0, s1, es_op2
    addi s0, s0, 1     
    beq zero, zero, veri_num_op2

mandar_num_op2:
    add t1, zero, t4
    sw gp, 8(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

es_op2:
    beq gp, t3, mandar_suma_op2              # verifca si lo que se ingresa es una suma
    beq gp, t2, mandar_resta_op2             # verifca si lo que se ingresa es una resta
    beq gp, t5, mandar_multi_op2             # verifca si lo que se ingresa es una multiplicacion
    beq zero, zero, reset_teclado

mandar_suma_op2:
    add t1, zero, t3
    sw t3, 8(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_resta_op2:
    add t1, zero, t3
    sw t2, 8(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

mandar_multi_op2:
    add t1, zero, t3
    sw t5, 8(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

##########################################

veri_num2:
    beq gp, s0, mandar2  
    beq s0, s1, reset_teclado
    addi s0, s0, 1     
    beq zero, zero, veri_num2

mandar2:
    add t1, zero, t2
    sw gp, 0x10(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

###########################################

veri_num_enter1: 
    beq gp, s0, mandar_num_enter1 
    beq s0, s1, es_enter1
    addi s0, s0, 1     
    beq zero, zero, veri_num_enter1

mandar_num_enter1:
    add t1, zero, t5
    sw gp, 0x14(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato

es_enter1:
    beq gp, t6, mandar_enter1              # verifca si lo que se ingresa es un enter
    beq zero, zero, es_enter1

mandar_enter1:
    sw ra, 0x14(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR  GUARDA 2024 A MODO DE ENTER
    beq zero, zero, enviar_enter



###########################################

veri_num_enter2:  
    beq gp, s0, mandar_num_enter2
    beq s0, s1, es_enter2
    addi s0, s0, 1
    beq zero, zero, veri_num_enter2

mandar_num_enter2:
    add t1, zero, t6
    sw gp, 0x18(s11)                         #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR
    beq zero, zero, enviar_dato         

es_enter2:
    beq gp, t6, mandar_enter2              # verifica si lo que se ingresa es un enter
    beq zero, zero, es_enter2

mandar_enter2:
    sw ra, 0x18(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR  GUARDA 2024 A MODO DE ENTER
    beq zero, zero, enviar_enter


###########################################
veri_enter: 
    beq gp, t6, mandar_enter              # verifica si lo que se ingresa es un enter
    beq zero, zero, veri_enter

mandar_enter:
    sw ra, 0x1c(s11)                        #SE DEBE DE ELIMINAR DESPUES, ES PARA PROBAR  GUARDA 2024 A MODO DE ENTER
    beq zero, zero, enviar_enter

###############################################

enviar_enter:
    addi gp, zero, 0x3d
    sw gp, 0(ra)                 # manda a la direccion 2024 el dato del teclado
    sw a1, 0(sp)                 # manda a la direccion 2020 un 1

rev_enter:
    lw a2, 0(sp)                  # se lee el reg de control del uart
    beq a2, a1, rev_enter         # si a0 == 1 se queda esperando hasta que sea 0 
    beq a2, zero, deco_hexa       # termina el ciclo 

deco_hexa:
    lw s9, 0(s11)
    addi s10, zero, 0x30
    beq s9, t3, operando
    beq s9, t2, operando
    beq s9, t5, operando
    beq s9, zero, operando  
    beq s9, ra, operando
    sub s9, s9, s10

operando:
    sw s9, 0(s11)
    addi s11, s11, 0x4
    addi s9, zero, 0x10
    slli s9, s9, 8
    addi s9, s9, 0x20
    beq s11, s9, lectu_ram
    beq zero, zero deco_hexa

lectu_ram:
    addi s11, zero, 0x10
    slli s11, s11, 8             # s11 = dir mem 1000 RAM   
    add s9, zero, zero
    add s0, zero, zero
    add s1, zero, zero
    add s2, zero, zero
    add s3, zero, zero
    add gp, zero, zero
    add s6, zero, zero      # contador para numeros
    addi s7, zero, 9        # numero maximo
    add s8, zero, zero      #contador iniciado en 0

    addi s10, zero, 0x10
    slli s10, s10, 8                 
    addi s10, s10, 0x1c             # s10 = 1028 

intro_numero:
    lw s9, 0(s11)
    beq s9, s6, guarde
    addi s6, s6, 1
    beq s6, s7, operacion
    beq zero, zero, intro_numero

guarde:
    beq s8, zero, modo_uno
    beq s8, ra, modo_dos
    beq s8, sp, modo_tres

modo_uno:
    add s2, zero, s9
    add s8, zero, ra
    beq zero, zero, reinicio_conta

modo_dos:
    add s1, zero, s2
    add s2, zero, s9
    add s8, zero, sp
    beq zero, zero, reinicio_conta

modo_tres:
    add s0, zero, s1
    add s1, zero, s2
    add s2, zero, s9
    add s8, s8, t4
    beq zero, zero, reinicio_conta

reinicio_conta:

addi s11, s11, 4
beq  s11, s10, decision
add s6, zero, zero
beq gp, zero, intro_numero
beq s9, t3, operacion 
beq s9, t2, operacion 
beq s9, t5, operacion
beq zero, zero, intro_numero2




operacion:
    add gp, zero, s9
    addi s11, s11, 4
    add s6, zero, zero
    add s8, zero, zero
    beq zero, zero, intro_numero2 
##################################################
intro_numero2:
lw s9, 0(s11)
beq s9, s6, guarde2
addi s6, s6, 1
beq s9, ra, decision
beq zero, zero, intro_numero2

guarde2:

beq s8, zero, modo_uno2
beq s8, ra, modo_dos2
beq s8, sp, modo_tres2

modo_uno2:
add s5, zero, s9
add s8, zero, ra
beq zero, zero, reinicio_conta

modo_dos2:
add s4, zero, s5
add s5, zero, s9
add s8, zero, sp
beq zero, zero, reinicio_conta

modo_tres2:
add s3, zero, s4
add s4, zero, s5
add s5, zero, s9
add s8, s8, t4
beq zero, zero, reinicio_conta
##################################################

decision:
    slli s0, s0, 8     # 400  
    slli s1, s1, 4     # 30
    add s2, s2, s1    # 32
    add s0, s2, s0    # 432
    
    slli s3, s3, 8     # 400
    slli s4, s4, 4     # 30
    add s4, s4, s5    # 32
    add s3, s4, s3    # 432

    beq gp, t3, suma        # revisa si gp es igual a t3 (que contiene el caracter de la suma)
    beq gp, t2, resta       # revisa si gp es igual a t2 (que contiene el caracter de la resta)
    beq gp, t5, multi       # revisa si gp es igual a t5 (que contiene el caracter de la multiplicacion)

#########################################################
suma:
    add s8, s0, s3  # s8 = s0 + s3

    beq, zero, zero, ciclo_envio

#########################################################
resta:
    sub s8, s0, s3  # s8 = s0 - s3

    beq, zero, zero, ciclo_envio

######################################################### LE TOCA A GOHAM
multi:

addi a4, zero, 1     # variable para dividir a la mitad 
addi t3, zero, 1     # variable para contar de 1 en 1

ruso:
	srl s9, s0, a4        # corrimiento a la derecha, divide a la mitad 
	add s9, s9, s9
	sub a0, a0, s9
	beq a0, zero, es_par
	beq t3, t3, es_impar
	
es_impar:
	add t6, t6, s3        # suma
	beq s0, t3, fin_ruso
	srl s0, s0, a4       # corrimiento a la derecha, divide a la mitad 
	sll s3, s3, a4       # corrimiento a la izquierda, duplica el valor 
	addi a0, zero, 0       # reinicia el registro a0
	add a0, a0, s0
	beq t3, t3, ruso

es_par:
	srl s0, s0, a4
	sll s3, s3, a4
	addi a0, zero, 0       # reinicia el registro a0
	add a0, a0, s0
	beq t3, t3, ruso
	
fin_ruso:
    add s8, zero, t6
    beq, zero, zero, ciclo_envio

#########################################################
ciclo_envio:

sw s8, 0x14(t4)      # manda el resultado (s8) al deco bcd
sw s8, 0x14(t4)      # manda el resultado (s8) al deco bcd
lw s8, 0x14(t4)      # bcd -> s8 = 0000 0000 0000 0000 0010 0011

addi a0, zero, 0x14        # cont1 = 20
addi a2, zero, 4           # a2 = 4
addi a3, zero, 1           # a3 = 1

revisa_ceros:
    srl s6, s8, a0        # desplaza s6, a0 veces a la derecha
    sub a0, a0, a2        # decrementa cont1 a0 = a0 - 4
    beq s6, zero, revisa_ceros        # si el digito en s6 es = 0 vuelve al ciclo

addi a0, a0, 4				# le suma 4 al contador
    #cont1 = 4

envia_resultado:
    andi s6, s6, 0xf        # purga todo el numero, tiene solo el digito que quiere enviar
    addi s6, s6, 0x30       # se le suma 30 a s6 para convertirlo a ascii
    sw s6, 0x24(t4)         # carga s6 en el uart data
    sw a3, 0x20(t4)         # carga un 1 en el uart de control 

revisar_uart_sum:
    lw s7, 0x20(t4)                   # cargue lo que tiene el uart ctrl
    beq s7, a3, revisar_uart_sum      # si uart ctrl es 1, sigue esperando

beq a0, zero, enter_calculadora   # si el contador es igual a 0, vuelve al inicio modo calcu
sub a0, a0, a2                    # decrementa cont1 a0 = a0 - 4
srl s6, s8, a0                    # desplaza s8, a0 veces, y lo almacena en s6
beq zero, zero, envia_resultado   # continua enviando digitos

enter_calculadora:

#cambio_linea

addi t5, zero, 0xA    # ascii de cambio de linea
addi t6, zero, 0xD    # ascii de retorno de carro

sw t5, 0x24(t4)        # carga caracter 0xa (ascci de cambio de linea) en el uart_data
sw a3, 0x20(t4)        # carga un 1 en uart_ctrl

revisa_envio21:

	lw s7 0x20(t4)                 # carga en s7 lo que tiene el uart_ctrl
	beq s7, a3, revisa_envio21     # revisa si es 1, entonces se encicla si es asi, si no sigue

sw t6, 0x24(t4)        # carga caracter 0xd (ascii de retorno carro) en el uart_data
sw a3, 0x20(t4)        # carga un 1 en uart_ctrl

revisa_envio31:

	lw s7 0x20(t4)                   # carga en s7 lo que tiene el uart_ctrl     
	beq s7, a3, revisa_envio31       # revisa si es 1, entonces se encicla si es asi, si no sigue

beq zero, zero, modo_calculadora1        # se regresa a esperar nuevos digitos


############################################################################################ FIN MODO CALCULADORA





modo_sensor:
	
############################################################################################ INICIO MODO SENSOR
inicio_sensor:

addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24           # ra = dir mem 2024       uart_data

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20           # sp = dir mem 2020       uart_ctrl

addi gp, zero, 0x20
slli gp, gp, 8              # gp = dir mem 2000       teclado

addi tp, zero, 0x20
slli tp, tp, 8       
addi tp, tp, 0x04           # tp = dir mem 2004       switches

addi t0, zero, 0x20
slli t0, t0, 8       
addi t0, t0, 0x10           # t0 = dir mem 2010       timer

addi t1, zero, 0x21
slli t1, t1, 8              # t1 = dir mem 2100      spi_ctrl

addi t2, zero, 0x22
slli t2, t2, 8              # t2 = dir mem 2200      spi_data  

switches:

    lw t3, 0(tp)            # se lee la informacion de los switches
    sw t3, 0(t0)            # se carga en el timer lo que haya en t3

revisa_timer:

    lw t4, 0(t0)                  # carga en t4 el valor que hay en el timer
    beq t4, zero, spi             # si t4 (cuenta del timer) es 0 salte a solicitar datos al spi    
    beq zero, zero, revisa_timer  # si no es cero sigue revisando

spi:

    addi t5, t5, 1    # mete en t5 un 1
    sw t5, 0(t1)      # escribe el 1 de t5 en el spi_control

espera_spi:

    lw t6, 0(t1)                    # se lee el reg de control del spi
    beq t6, t5, espera_spi          # si t6 == 1 se queda esperando hasta que sea 0 

######################### envia dato a uart ##################################

addi s10, zero, 0xA
addi s11, zero, 0xB
addi t0, zero,  0xC
addi t1, zero,  0xD
addi t2, zero,  0xE
addi t3, zero,  0xF
addi a2, zero, 0x1b        # guarda en a2 el ascii del ESC

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20          # 	control uart

addi gp, zero, 0x20
slli gp, gp, 8             # 	teclado

addi tp, zero, 0x22
slli tp, tp, 8		   #	data spi

addi ra, zero, 0           # contador, es 0 ó 1 solamente
addi a0, zero, 1           # constante con valor 1

lw t4, 0(tp)		       # lee dato sensor
srli a1, t4, 4		       # t2 = 4 bits mas significativos

inicio_envio:

	beq a1, s10, envia_letra
	beq a1, s11, envia_letra
	beq a1, t0, envia_letra
	beq a1, t1, envia_letra
	beq a1, t2, envia_letra
	beq a1, t3, envia_letra

	addi s0, a1, 0x30
	sw s0, 4(sp)			# guarda en el registro de datos el ascii
	sw a0, 0(sp)			# guarda en registro de control el 1
	beq zero, zero, revisa_envio	# envia a revisa

envia_letra:

	addi s0, a1, 0x37
	sw s0, 4(sp)			# guarda en el registro de datos el ascii
	sw a0, 0(sp)			# guarda en registro de control el 1
	beq zero, zero, revisa_envio  # envia a revisa_envio

revisa_envio:

	lw s2 0(sp)
	beq s2, a0, revisa_envio

slli a1, t4, 28		# borra 4 bits mas significativos
srli a1, a1, 28		# t1 = 4 bits menos significativos del dato
addi ra, ra, 0x1	# aumenta el contador
beq ra, a0, inicio_envio

#cambio_linea

addi t5, zero, 0xA
addi t6, zero, 0xD

sw t5, 4(sp)        # carga caracter 0xa (ascci de cambio de linea) en el uart_data
sw a0, 0(sp)        # carga un 1 en uart_ctrl

revisa_envio2:

	lw s2 0(sp)                   # carga en s2 lo que tiene el uart_ctrl
	beq s2, a0, revisa_envio2     # revisa si es 1, entonces se encicla si es asi, si no sigue

sw t6, 4(sp)        # carga caracter 0xd (ascii de retorno carro) en el uart_data
sw a0, 0(sp)        # carga un 1 en uart_ctrl

revisa_envio3:

	lw s2 0(sp)                   # carga en s2 lo que tiene el uart_ctrl     
	beq s2, a0, revisa_envio3     # revisa si es 1, entonces se encicla si es asi, si no sigue


# ver_esc_sensor

    lw s3, 0(gp)                  # guarda en s3 lo que hay en el teclado
    beq s3, a2, menu_principal    # si el valor del teclado (s3) es igual a a2 (esc en ascii), entonces vaya al menu

    beq zero, zero, inicio_sensor    # regresa a la captura de datos


###########################################################


############################################################################################ FIN MODO SENSOR


###################################################################################### FIN MOSTRAR TEXTO DE MENU

