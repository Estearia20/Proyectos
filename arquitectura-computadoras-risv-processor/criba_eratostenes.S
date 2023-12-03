addi x1, x0, 8
addi x10, x0, 1
sub x13, x1, x10
addi x1, x1, 1
addi x2, x0, 2
addi x3, x3, 1
lista:
sw x2, 0(x3)
addi x2, x2, 1
addi x3, x3, 1
bne x2, x1, lista
addi x3, x0, 1
addi x9, x0, 50
main:
lw x4, 0(x3)
lw x5, 0(x3)
lista_de_eliminados:
add x5, x5, x4
add x0, x0, x0
bge x5, x1, loop
sw x5, 0(x9)
addi x9, x9, 1
jal x31, lista_de_eliminados
loop:
addi x3, x3, 1
addi x15, x15, 1
beq x15, x13, acomodar
jal x31, main
acomodar:
addi x12, x0, 1
addi x3, x0, 1
sub x9, x9, x12
comparar:
lw x14, 0(x3)
lw x16, 0(x9)
add x0, x0, x0
beq x14, x16, cero
addi x3, x3, 1
bge x3, x1, next
jal x31, comparar
cero:
sw x0, 0(x3)
addi x3, x3, 1
beq x3, x1, next
jal x31, comparar
next:
addi x3, x0, 1
sub x9, x9, x12
lw x22, 0(x9)
add x0, x0, x0
beq x22, x0, end
jal x31, comparar
end:







