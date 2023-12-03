addi x1, x0, 1
addi x2, x0, 5
addi x3, x0, 3
loop:
beq x1, x2, end
addi x1, x1, 1
jal x4, loop
addi x10, x0, 3
addi x11, x0, 4
end:
