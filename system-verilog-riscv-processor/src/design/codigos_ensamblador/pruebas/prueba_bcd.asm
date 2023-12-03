addi ra, zero, 0x20
slli ra, ra, 8

addi s2, zero, 0x1


addi s0, zero, 0x0 	      # en decimal es 897
slli s0, s0, 8
addi s0, s0, 0x381

sw s0, 0x14(ra)
sw s0, 0x14(ra)
lw s1, 0x14(ra)

sw s1, 0x8(ra)



andi s1, s1, 0xf

sw s1, 0x24(ra)

sw s2, 0x20(ra)


fin:
	beq zero, zero, fin