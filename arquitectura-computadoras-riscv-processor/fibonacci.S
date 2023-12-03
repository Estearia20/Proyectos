addi x1, x0, 20   
addi x2, x0, 0 
addi x3, x0, 1 
addi x4, x0, 1 
loop:
beq x1, x4, end
add x5, x3, x2
addi x2, x3, 0
addi x3, x5, 0
addi x4, x4, 1
jal x8, loop
end:
add x0, x0, x0


    
    



