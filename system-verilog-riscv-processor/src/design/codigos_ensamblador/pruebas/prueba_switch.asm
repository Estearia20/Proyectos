addi ra, zero, 0x20        
slli ra, ra, 8       
addi ra, ra, 0x24           # ra = dir mem 2024       uart_data

addi sp, zero, 0x20
slli sp, sp, 8       
addi sp, sp, 0x20           # sp = dir mem 2020       uart_ctrl

addi gp, zero, 0x20
slli gp, gp, 8             # gp = dir mem 2000       teclado

addi tp, zero, 0x20
slli tp, tp, 8       
addi tp, tp, 0x04           # tp = dir mem 2004       switches

addi t0, zero, 0x20
slli t0, t0, 8       
addi t0, t0, 0x10           # t0 = dir mem 2010       timer

addi t1, zero, 0x20
slli t1, t1, 8       
addi t1, t1, 0x100          # t1 = dir mem 2100      spi_ctrl

addi t2, zero, 0x20
slli t2, t2, 8       
addi t2, t2, 0x200          # t2 = dir mem 2200      spi_data

switches:

    lw t3, 0(tp)             # se lee la informacion de los switches
    sw t3, 0(t0)             # se carga en el timer lo que haya en t3
    addi tp, tp, 4

revisa_timer:

    lw t4, 0(t0)                  # carga en t4 el valor que hay en el timer
    sw t4, 0(tp)
    beq t4, zero, spi             # si t4 (cuenta del timer) es 0 salte a solicitar datos al spi    
    beq zero, zero, revisa_timer  # si no es cero sigue revisando

spi:
    addi t5, t5, 0x1    # mete en t5 un 1
    sw t5, 0(tp)
    
fin:
	beq zero, zero, fin