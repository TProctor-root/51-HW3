.text

##############################
# EC FUNCTIONS
##############################

decode_message1:
    #Define your code here
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)   
    sw $s6, 8($sp)
    sw $s7, 12($sp) 
    
    move $s0, $a0 # input 
    move $s1, $a1 # output
    li $v0, 0
    li $t0, '('
    li $t1, ')'
    li $s7, 0
    while:
    lb $k0, 0($s0)
    addi $sp, $sp, -4
    sw $ra, ($sp)
    move $a0, $k0
    jal check
    lw $ra, ($sp)
    addi $sp, $sp, 4
    beqz $k0, do
    li $t7, 0
    beq $k0, $t0, gar # (
    j sorry
    
    gar:
    sb $t0, ($s1)
    addi $s1, $s1, 1
    
    found: 
    lb $k1, 1($s0)
    addi $sp, $sp, -4
    sw $ra, ($sp)
    move $a0, $k1
    jal check
    lw $ra, ($sp)
    addi $sp, $sp, 4
    beq $k1, $t1, trouble # )
    
    addi $sp, $sp, -4
    sw $k1, 0($sp)
    addi $s7, $s7, 1   
    addi $s0, $s0, 1
    j found
    
    trouble:    
    beqz $s7, presorry
    lw $k1, 0($sp)
    addi $sp, $sp, 4
    
    sb $k1, ($s1)
    addi $s1, $s1, 1
    addi $s7, $s7, -1
    j trouble

    presorry:
    sb $t1, ($s1)
    addi $s1, $s1, 1
    addi $v0, $v0, 1
    sorry:
        
    addi $s0, $s0, 1
    j while
    
    do:
    li $t0, 0
    sb $t0, ($s1)
   
    lw $s7, 12($sp)
    lw $s6, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 16
    
    jr $ra
    
    check:
    li $s6, ' '
    beq $a0, $t0, spyro2
    beq $a0, $t1, spyro2
    beq $a0, $t2, spyro2
    beq $a0, $t3, spyro2 
    beq $a0, $t4, spyro2
    beq $a0, $t5, spyro2
  
    beq $a0, $s6, spyro2
    li $t4, '0'
    li $t5, '9'
    blt $a0, $t4, theendR
    ble $a0, $t5, spyro2
    li $t4, 'A'
    li $t5, 'Z'
    li $t6, 'a' 
    li $t7, 'z' 
   
    blt $a0, $t4, theendR
    ble $a0, $t5, spyro2
    blt $a0, $t6, theendR
    ble $a0, $t7, spyro2
   
    j theendR
    
    theendR:
    li $t4, 4
    mul $t6, $t4, $s7
    addi $t6, $t6, 4
    lw $ra, ($sp)
    add $sp, $sp, $t6
    
    j do
    
    spyro2:
    li $t0, '('
    li $t1, ')'
    li $t2, '['
    li $t3, ']'
    li $t4, '{'
    li $t5, '}'
    jr $ra

decode_message2:
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)  
    sw $s6, 8($sp)
    sw $s7, 12($sp) 
    
    move $s0, $a0 # input 
    move $s1, $a1 # output
    li $v0, 0
    li $t0, '('
    li $t1, ')'
    li $t2, '['
    li $t3, ']'
    li $t4, '{'
    li $t5, '}'
    li $s7, 0
    while1:
    lb $k0, 0($s0)
    addi $sp, $sp, -4
    sw $ra, ($sp)
    move $a0, $k0
    jal check
    lw $ra, ($sp)
    addi $sp, $sp, 4
    beqz $k0, do1
    li $t7, 0
    li $a3, 0
    beq $k0, $t0, gar1 # (
    beq $k0, $t2, gar2
    beq $k0, $t4, gar3

    j sorry1
    
    gar1:
    sb $t0, ($s1)
    addi $s1, $s1, 1
    addi $a3, $a3, 1
    addi $s0, $s0, 1
    addi $sp, $sp, -4
    sw $t1, 0($sp)
    addi $s7, $s7, 1   
    
    j found1
    
    gar2:
    sb $t2, ($s1)
    addi $s1, $s1, 1
    addi $a3, $a3, 1
    addi $s0, $s0, 1
    addi $sp, $sp, -4
    sw $t3, 0($sp)
    addi $s7, $s7, 1   
    j found1
    
    gar3:
    sb $t4, ($s1)
    addi $s1, $s1, 1
    addi $a3, $a3, 1
    addi $s0, $s0, 1
    addi $sp, $sp, -4
    sw $t5, 0($sp)
    addi $s7, $s7, 1   
    j found1
    
    prefound1:
    addi $s0, $s0, 1
    
    found1: 
    lb $k1, 0($s0)
    addi $sp, $sp, -4
    sw $ra, ($sp)
    move $a0, $k1
    jal check
    lw $ra, ($sp)
    addi $sp, $sp, 4
    beq $k1, $t0, gar1 # (
    beq $k1, $t2, gar2
    beq $k1, $t4, gar3
    beq $k1, $t1, trouble1 # )
    beq $k1, $t3, trouble1
    beq $k1, $t5, trouble1
    addi $sp, $sp, -4
    sw $k1, 0($sp)
    addi $s7, $s7, 1   
    addi $s0, $s0, 1
    j found1
  
    trouble1:    
    beqz $s7, presorry1
    
    lw $k1, 0($sp)
    addi $sp, $sp, 4
    
    sb $k1, ($s1)
    addi $s1, $s1, 1
    addi $s7, $s7, -1
    beq $k1, $t1, presorry1
    beq $k1, $t3, presorry1
    beq $k1, $t5, presorry1
    j trouble1

    presorry1:
    addi $a3, $a3, -1
    addi $v0, $v0, 1
    bgtz $a3, prefound1
    sorry1:
        
    addi $s0, $s0, 1
    j while1
    
    do1:
    li $t0, 0
    sb $t0, ($s1)
   
    lw $s7, 12($sp)
    lw $s6, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 16
    
    jr $ra