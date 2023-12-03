menu:

	addi ra, zero, 0x20
	slli ra, ra, 8  # 0x20 lo pasa a 0x00002000 es la direccion de memoria  donde inicia la el teclado
	lw sp,0(ra)     # lee el teclado y guarda el valor en sp 
	
	addi t0, zero, 0x05 # guarda el valor de F1
	addi t1, zero, 0x06 # guarda el valor de F2
	addi t2, zero, 0x04 # guarda el valor de F3
		
	beq sp, t0, reset_tecla_tex        # verifica si es F1
	beq sp, t1, reset_tecla_cal        # verifica si es F2
	beq sp, t2, modo_sensor            # verifica si es F3

reset_tecla_tex:

	addi ra, zero, 0x20        
	slli ra, ra, 8                # 0x20 lo pasa a 0x00002000 es la direccion de memoria  donde inicia la el teclado
	addi sp, zero, 0
	sw sp,0(ra)
	beq zero, zero, modo_texto  

modo_texto: 

	addi ra, zero, 0x20
	slli ra, ra, 8             # 0x20 lo pasa a 0x00002000 es la direccion de memoria  donde inicia la el teclado
	lw sp,0(ra)                # lee el teclado y guarda el valor en sp
	beq sp, zero, modo_texto   # verifica si es un 0 se queda esperando un valor
	
	addi t0, zero, 0x1b        # guarda el valor de ESC
	beq sp, t0, menu           # verifica si es ESC
	
	addi ra, zero, 0x20        
	slli ra, ra, 8       
	addi ra, ra, 0x24          # pasa a la direccion 0x2000 y le suma 24  quedando en 2024	
	
	sw sp, 0(ra)               # manda a la direccion 2024 el dato del teclado y escribe un 1 en la direccion 2020
	addi ra, zero, 0x20
	slli ra, ra, 8       
	addi ra, ra, 0x20          # pasa a la direccion 0x2000 y le suma 20  quedando en 2020
	addi sp, zero, 0x1
	sw sp, 0(ra)	        
	
	beq zero, zero, reset_tecla_tex  # termina el ciclo y vuelve a modo texto
	
reset_tecla_cal:

	addi ra, zero, 0x20        
	slli ra, ra, 8                # 0x20 lo pasa a 0x00002000 es la direccion de memoria  donde inicia la el teclado
	addi sp, zero, 0
	sw sp,0(ra)
	beq zero, zero, modo_calculadora  

	
modo_calculadora:
		
	addi ra, zero, 0x20
	slli ra, ra, 8                   # 0x20 lo pasa a 0x00002000 es la direccion de memoria  donde inicia la el teclado
	lw sp,0(ra)                      # lee el teclado y guarda el valor en sp
	beq sp, zero, modo_calculadora   # verifica si es un 0 se queda esperando un valor

	addi t0, zero, 0x1b              # guarda el valor de ESC
	beq sp, t0, menu                 # verifica si es ESC
	
	addi s0, zero, 0x30        # guarda el codigo del 0
	addi s1, zero, 0x31        # guarda el codigo del 1
	addi s2, zero, 0x32        # guarda el codigo del 2
	addi s3, zero, 0x33        # guarda el codigo del 3
	addi s4, zero, 0x34        # guarda el codigo del 4
	addi s5, zero, 0x35        # guarda el codigo del 5
	addi s6, zero, 0x36        # guarda el codigo del 6
	addi s7, zero, 0x37        # guarda el codigo del 7
	addi s8, zero, 0x38        # guarda el codigo del 8
	addi s9, zero, 0x39        # guarda el codigo del 9
	
	addi t3, zero, 0x2b        # guarda el codigo de la suma
	addi t4, zero, 0x2d        # guarda el codigo de la resta
	addi t5, zero, 0x2a        # guarda el codigo de la multiplicacion
	addi t6, zero, 0x0a        # guarda el codigo del enter
	
	


modo_sensor:

