addi x1, x0, 11
addi x5, x0, 2
addi x3, x0, 3
addi x7, x0, 1
beq x1, x0, factorialcero
beq x1, x7, factorialuno
beq x1, x5, factorialdos
beq x1, x3, factorialtres
loop:
mul x5, x5, x3 
addi x3, x3, 1
blt x3, x1, loop
sw x5, 0(x0)
jal x9, end
factorialcero:
addi x5, x0, 1
jal x9, end
factorialuno:
addi x5, x0, 1
jal x9, end
factorialdos:
addi x5, x0, 2
jal x9, end
factorialtres:
addi x5, x0, 6
jal x9, end
end:
lw x6, 0(x0)
mul x6, x6, x1
