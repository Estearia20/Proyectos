main:  addi s0, zero , 8   # se guarda un 8 en el registro s0
       addi s1, zero, 3    # se guarda un 3 en el registro s1
       sub  s2, s0, s1     # se realiza 8-3 y el resultado se guarda en s2
       add  s3, s2, s2     # se realiza 5+5 y el resultado se guarda en s3
       or   s4, s2, s3     # or de 5 con A , debe dar F
       and  s5, s4, s3     # and de F con A, debe dar A
       beq  s0, s5, main   # brach que no deberia de cumplirse
       slt  s6, s1, s0     # compara 3<8 el resultado debe dar un 1 
       beq  s0, s0, inter  # verifica que el valor de s0 sea igual a s0 y salta a inter
       add  s9, s5, s4     # esta instrucción no se ejecuta
       sub  s9, s5, s5     # esta instrucción no se ejecuta  
inter: addi s7, zero, 0x10  # se guarda en el registro s7 10 en hexadecimal
       slli s7, s7, 8      # se desplaza hacia la izquierda 8 veces el 10, dando como resultado 1000
       sw   s0, 4(s7)      # hace un store word en memoria 0x1004  
       lw   s11, 4(s7)     # hace un load word y lo que esté en la dirreción de memoria 0x1004 lo guarda en s11    
       beq  s0, s11, main   # hace un branch hacia la etiqueta main
      
