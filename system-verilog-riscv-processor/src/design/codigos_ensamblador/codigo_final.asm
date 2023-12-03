############################################################################################ INICIO MENU PRINCIPAL
menu_principal:

addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24           # ra = dir mem 2024       uart_data

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20           # sp = dir mem 2020       uart_ctrl

addi gp, zero, 0x20
slli gp, gp, 8              # gp = dir mem 2000       teclado

addi t5, zero, 0x30
slli t5, t5, 8              # t5 = dir mem 3000       ROM de texto
   
addi s9, zero, 0x30         # direccion maxima a la que llega a leer
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
    
        beq a2, zero, loop_lector                   # termina el ciclo y vuelve a modo texto

reset_sel:

	sw zero, 0(gp)               # mete un 0 en el teclado   
  
rev1:                                # revisa que ya haya un 0 en el teclado
	lw t3, 0(gp)
	beq t3, zero, sel_modo
	beq zero, zero, rev1

sel_modo:    

	lw t4, 0(gp)                  # lee el teclado y guarda el valor en t4
	beq t4, t0, modo_texto        # verifica si es un F1 se queda esperando un valor
	beq t4, t1, modo_calculadora1 # verifica si es un F2 se queda esperando un valor
	beq t4, t2, modo_sensor       # verifica si es un F3 se queda esperando un valor
	beq zero, zero, sel_modo      # si es otra tecla reinicia y queda esperando
	
############################################################################################ FIN MOSTRAR TEXTO DE MENU
	
############################################################################################ INICIO MODO TEXTO
	
modo_texto:

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
	
############################################################################################ FIN MODO TEXTO

############################################################################################ INICIO MODO CALCULADORA
modo_calculadora1:

addi ra, zero, 0x20
slli ra, ra, 8			# Se guarda un 2000, dir del teclado

addi a0, zero, 0x1b		# ascii del ESC
addi a1, zero, 0x1		# constante de 1
addi a3, zero, 0x1		# constante inicial de 1
addi a4, zero, 0x39		# constante de 9 en ascii
addi a5, zero, 0x2b             # codigo ascii de la suma
addi a6, zero, 0x2d             # codigo ascii de la resta
addi a7, zero, 0x2a             # codigo ascii de la multiplicacion
addi sp, zero, 0x0d             # codigo del teclado del enter
addi t1, zero, 0x2		# constante de 2
addi t2, zero, 0x3		# constante de 3
addi t3, zero, 0x4		# constante de 4
addi t4, zero, 0x5		# constante de 5
addi t5, zero, 0x6		# constante de 6
addi t6, zero, 0x7		# constante de 7
addi gp, zero, 0x8		# constante de 8
addi s11, zero, 0x3d		# constante con el ascii del =
addi s10, zero, 0xf		# constante de f
addi s9, zero, 0x30		# constante de 30

reset_teclado:

	sw zero, 0(ra)
	addi a2, zero, 0x30	# constante inicial de 30

lee_tecla:

	lw t0, 0(ra)		# lee valor del teclado
	beq t0, zero, lee_tecla
	beq t0, a0, menu_principal	# si t0 es en ascii ESC va al menu principal
	beq a3, t1, segundo_num
	beq a3, t2, tercer_num
	beq a3, t3, cuarto_num
	beq a3, t4, quinto_num
	beq a3, t5, sexto_num
	beq a3, t6, septimo_num
	beq a3, gp, octavo_num


primer_num:

	beq t0, a2, guarda1
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, primer_num
	
guarda1:

	add s0, zero, t0		# en s0 está el primer digito
	addi a3, zero, 0x2		# marcador en 2
	sw s0, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s0, s0, s9
	beq zero, zero, revisa_uart_calcu


segundo_num:

	beq t0, a2, guarda2num	# revisa si es numero
	beq t0, a5, guarda2op	# revisa si es suma
	beq t0, a6, guarda2op	# revisa si es resta
	beq t0, a7, guarda2op	# revisa si es multiplicacion
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, segundo_num

guarda2num:

	add s1, zero, t0		# en s1 está el segundo digito
	addi a3, zero, 0x3		# marcador en 3
	sw s1, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s1, s1, s9
	beq zero, zero, revisa_uart_calcu

guarda2op:

	add s3, zero, t0		# en s3 está la operacion
	addi s1, zero, 0xf		# en s1 está una f, significa que no se usó
	addi s2, zero, 0xf		# en s2 está una f, significa que no se usó
	addi a3, zero, 0x5		# marcador en 5
	sw s3, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu


tercer_num:

	beq t0, a2, guarda3num	# revisa si es numero
	beq t0, a5, guarda3op	# revisa si es suma
	beq t0, a6, guarda3op	# revisa si es resta
	beq t0, a7, guarda3op	# revisa si es multiplicacion
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, tercer_num

guarda3num:

	add s2, zero, t0		# en s2 está el tercer digito
	addi a3, zero, 0x4		# marcador en 4
	sw s2, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s2, s2, s9
	beq zero, zero, revisa_uart_calcu

guarda3op:

	add s3, zero, t0		# en s3 está la operacion
	addi s2, zero, 0xf		# en s2 está una f, significa que no se usó
	addi a3, zero, 0x5		# marcador en 5
	sw s3, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu


cuarto_num:

	beq t0, a5, guarda4	# revisa si es suma
	beq t0, a6, guarda4	# revisa si es resta
	beq t0, a7, guarda4	# revisa si es multiplicacion
	beq zero, zero, reset_teclado

guarda4:

	add s3, zero, t0		# en s3 está la operacion
	addi a3, zero, 0x5		# marcador en 5
	sw s3, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu
	

quinto_num:

	beq t0, a2, guarda5
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, quinto_num

guarda5:

	add s4, zero, t0		# en s4 está el primer digito del segundo numero
	addi a3, zero, 0x6		# marcador en 6
	sw s4, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s4, s4, s9
	beq zero, zero, revisa_uart_calcu


sexto_num:

	beq t0, a2, guarda6num     # revisa si es numero
	beq t0, sp, guarda6enter   # revisa si es enter
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, sexto_num

guarda6num:

	add s5, zero, t0		# en s4 está el segundo digito del segundo numero
	addi a3, zero, 0x7		# marcador en 7
	sw s5, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s5, s5, s9
	beq zero, zero, revisa_uart_calcu

guarda6enter:

	addi s5, zero, 0xf		# en s5 está una f, significa que no se usó
	addi s6, zero, 0xf		# en s6 está una f, significa que no se usó
	addi a3, zero, 0x0		# marcador en 0
	sw s11, 0x24(ra)		# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu


septimo_num:

	beq t0, a2, guarda7num     # revisa si es numero
	beq t0, sp, guarda7enter   # revisa si es enter
	beq a2, a4, reset_teclado
	addi a2, a2, 0x1
	beq zero, zero, septimo_num

guarda7num:

	add s6, zero, t0		# en s4 está el tercer digito del segundo numero
	addi a3, zero, 0x8		# marcador en 8
	sw s6, 0x24(ra)			# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	sub s6, s6, s9
	beq zero, zero, revisa_uart_calcu

guarda7enter:

	addi s6, zero, 0xf		# en s6 está una f, significa que no se usó
	addi a3, zero, 0x0		# marcador en 0
	sw s11, 0x24(ra)		# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu

octavo_num:

	beq t0, sp, guarda8            # revisa si es enter
	beq zero, zero, reset_teclado

guarda8:

	addi a3, zero, 0x0		# marcador en 0
	sw s11, 0x24(ra)		# guarda en el uart data el digito
	sw a1, 0x20(ra)			# guarda un 1 en uart control
	beq zero, zero, revisa_uart_calcu


revisa_uart_calcu:

	lw tp, 0x20(ra)				# carga en tp el uart ctrl
	beq tp, a1, revisa_uart_calcu		# si tp (uart ctrl) = 1 se encicla
	beq a3, zero, desicion_1num		# si tp = 0 se devuelve
	beq tp, zero, reset_teclado


desicion_1num:

	beq s1, s10, desicion_2num
	beq s2, s10, conca2num1
	beq zero, zero, conca1num1


desicion_2num:

	beq s5, s10, desicion_op
	beq s6, s10, conca2num2
	beq zero, zero, conca1num2


conca1num1:

	slli s0, s0, 8      # 400
    	slli s1, s1, 4      # 30
    	add s2, s2, s1      # 32
   	add s0, s2, s0      # 432			s0 = 432
   	beq zero, zero, desicion_2num

conca2num1:

	slli s0, s0, 4      # 30
   	add s0, s0, s1      # 32			s0 = 32
	beq zero, zero, desicion_2num


conca1num2:

	slli s4, s4, 8      # 400
    	slli s5, s5, 4      # 30
    	add s6, s6, s5      # 32
   	add s4, s6, s4      # 432			s4 = 432
   	beq zero, zero, desicion_op

conca2num2:

	slli s4, s4, 4      # 30
   	add s4, s4, s5      # 32			s4 = 32
   	beq zero, zero, desicion_op



desicion_op:

	sw s0, 0x18(ra)
	sw s0, 0x18(ra)
	lw s0, 0x18(ra)
	
	sw s4, 0x18(ra)
	sw s4, 0x18(ra)
	lw s4, 0x18(ra)
	
	beq s3, a5, suma
	beq s3, a6, resta
	beq s3, a7, multi


suma:

        add s8, s0, s4  # s8 = s0 + s4

        beq, zero, zero, ciclo_envio


resta:

        sub s8, s0, s4  # s8 = s0 - s4

        beq, zero, zero, ciclo_envio


multi:

        addi t3, zero, 1     # variable para contar de 1 en 1
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

        add s8, zero, t6
        beq, zero, zero, ciclo_envio


ciclo_envio:

        sw s8, 0x14(ra)      # manda el resultado (s8) al deco bcd
        sw s8, 0x14(ra)      # manda el resultado (s8) al deco bcd

        lw s8, 0x14(ra)      # bcd -> s8 = 0000 0000 0000 0000 0010 0011

        addi a0, zero, 0x14        # cont1 = 20
        addi a2, zero, 4           # a2 = 4
	addi a3, zero, 1           # a3 = 1

revisa_ceros:

        srl s6, s8, a0        # desplaza s6, a0 veces a la derecha
        beq a0, zero, envia_resultado
        sub a0, a0, a2        # decrementa cont1 a0 = a0 - 4
        beq s6, zero, revisa_ceros        # si el digito en s6 es = 0 vuelve al ciclo

        addi a0, a0, 4				# le suma 4 al contador
                                                #cont1 = 4

envia_resultado:

         andi s6, s6, 0xf        # purga todo el numero, tiene solo el digito que quiere enviar
         addi s6, s6, 0x30       # se le suma 30 a s6 para convertirlo a ascii
         sw s6, 0x24(ra)         # carga s6 en el uart data
         sw a3, 0x20(ra)         # carga un 1 en el uart de control 

revisar_uart_sum:

         lw s7, 0x20(ra)                   # cargue lo que tiene el uart ctrl
         beq s7, a3, revisar_uart_sum      # si uart ctrl es 1, sigue esperando

	 beq a0, zero, enter_calculadora   # si el contador es igual a 0, vuelve al inicio modo calcu
	 sub a0, a0, a2                    # decrementa cont1 a0 = a0 - 4
	 srl s6, s8, a0                    # desplaza s8, a0 veces, y lo almacena en s6
	 beq zero, zero, envia_resultado   # continua enviando digitos

enter_calculadora:

#cambio_linea

	 addi t5, zero, 0xA    # ascii de cambio de linea
	 addi t6, zero, 0xD    # ascii de retorno de carro

	 sw t5, 0x24(ra)        # carga caracter 0xa (ascci de cambio de linea) en el uart_data
	 sw a3, 0x20(ra)        # carga un 1 en uart_ctrl

revisa_envio21:

	 lw s7 0x20(ra)                 # carga en s7 lo que tiene el uart_ctrl
	 beq s7, a3, revisa_envio21     # revisa si es 1, entonces se encicla si es asi, si no sigue

	 sw t6, 0x24(ra)        # carga caracter 0xd (ascii de retorno carro) en el uart_data
 	 sw a3, 0x20(ra)        # carga un 1 en uart_ctrl

revisa_envio31:

	 lw s7 0x20(ra)                   # carga en s7 lo que tiene el uart_ctrl     
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



############################################################################################ FIN MODO SENSOR

############################################################################################ FIN MENU PRINCIPAL
