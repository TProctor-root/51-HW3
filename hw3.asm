.include "hw3_helpers.asm"

.data
symbol: .asciiz "!@#$%^&*."

.text

##############################
# PART 1 FUNCTIONS
##############################

decodedLength:
    #Define your code here
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)   
    sw $s6, 8($sp)
    sw $s7, 12($sp) 
    
    move $s1, $a1  
    la $t1, symbol 
    li $t2, '\0' 
    li $t3, '.'   
    
    beq $s1, $t2, none
    
    roling:
    lb $t4, 0($t1)
    beq $t4, $t3, none
    beq $s1, $t4, fireN
    addi $t1, $t1, 1
    j roling                                                             
    fireN:
                                                                                                                                
    # Increment 
    li $t1, 1
    
    # Return Counter
    li $k0, 0
    
    # first char of string
    lb $s0, 0($a0)
    li $s1, '\0'
    move $s7, $a0
    move $s6, $a1
    
    # loop
    decode:    
    beq $s0, $s1, endcode
    beq $s0, $s6, compare
    j skip
    
    compare:
    # Grab Number    
    move $a0, $s7
    
    li $k1, 2
    add $a0, $a0, $k1
    
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $k0, 4($sp)
    jal atoui
    lw $k0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    li $t1, 1
    
    add $k0, $k0, $v0
    li $t2, 3
    add $s7, $s7, $t2
    lb $s0, 0($s7)
    j decode
    
    skip:
    add $k0, $k0, $t1
    add $s7, $s7, $t1
    lb $s0, 0($s7)
    j decode
    endcode:
      
    beqz $k0, zero
    add $k0, $k0, $t1
    zero:
    move $v0, $k0
    
    j coml
    
    none:
    li $v0, 0
    j coml
    
    coml:
   
    lw $s7, 12($sp)
    lw $s6, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 16
    jr $ra

decodeRun:
    #Define your code here
        
    # Loading Arguments
    addi $sp, $sp, -12
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    
    move $k1, $a1
    move $k0, $a0
    
    blez $k1, endtalker2
    
    li $t1, 'A'
    li $t2, 'Z'
    li $t3, 'a' 
    li $t4, 'z'
    
    blt $k0, $t1, endtalker2
    ble $k0, $t2, startn
    blt $k0, $t3, endtalker2
    ble $k0, $t4, startn
    j endtalker2
    
    endtalker2:
    move $v0, $a2
    li $v1, 0
    j endtalker
    
    startn:
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
     
    # For Loop Limit
    li $t0, 0
    li $t1, 1
    
    dup:
    beq $t0, $s1, complete
    
    sb $s0, ($s2)
    
    add $s2, $s2, $t1
    add $t0, $t0, $t1
    j dup
    complete:
    
    move $v0, $s2
    li $v1, 1
    
    endtalker:
    
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 12
    jr $ra

runLengthDecode:
    #Define your code here
    addi $sp, $sp, -24
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)    
    sw $s4, 16($sp)
    sw $s7, 20($sp) 
    
    move $s3, $a3
    la $t1, symbol 

    li $t3, '.'  
    roling2:
    lb $s4, 0($t1)
    beq $s4, $t3, trueEnd
    beq $s3, $s4, letsGo
    addi $t1, $t1, 1
    j roling2                                                             
    letsGo:

    move $s7, $a0
    
    move $s0, $a0  #input
    move $s1, $a1  #output
    move $s2, $a2  #output size
    move $s3, $a3  #run flag
    
    move $a1, $s3 
     
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal decodedLength
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    blt $s2, $v0, error
    add $t0, $v0, $s1
    addi $t0, $t0, -1
    li $t1, '\0'    
    sb $t1, ($t0)
    
    # Index
    li $t3, 0
    
    # For Limit
    li $k1, 1
    
    lb $k0, 0($s0)
    
    for:
    beq $k0, $t1, last
    
    beq $k0, $s3, right
    
    j left
    
    right:
      
    addi $a0, $s0, 2
    
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s2, 4($sp)
    sw $k0, 8($sp)
    sw $k1, 12($sp)
    sw $t1, 16($sp)
    jal atoui
    lw $t1, 16($sp)
    lw $k1, 12($sp)
    lw $k0, 8($sp)
    lw $s2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 20
     
    move $a1, $v0
    
    lb $a0, 1($s0)
    
    move $a2, $s1
    
    addi $sp, $sp, -20
    sw $ra, 0($sp)
    sw $s2, 4($sp)
    sw $k0, 8($sp)
    sw $k1, 12($sp)
    sw $t1, 16($sp)
    jal decodeRun
    lw $t1, 16($sp)
    lw $k1, 12($sp)
    lw $k0, 8($sp)
    lw $s2, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 20
    
    move $s1, $v0
    
    addi $s0, $s0, 2 
    j bye
    
    left:
    sb $k0, ($s1)
    addi $s1, $s1, 1
    
    bye:
    add $s0, $s0, $k1
    lb $k0, 0($s0)
    j for
    last:
    
    li $v0, 1
    j ending
 
    error:
    li $v0, 0
    j ending
    
    ending:   
    
    beq $a0, $s7, trueEnd
    j justFine
    
    trueEnd:
    li $v0, 0
    
    justFine:
   
    lw $s7, 20($sp)
    lw $s4, 16($sp)
    lw $s3, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 24
    
    jr $ra

##############################
# PART 2 FUNCTIONS
##############################

encodedLength:
    #Define your code here
    addi $sp, $sp, -20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)   
    sw $s6, 12($sp)
    sw $s7, 16($sp) 
     
    move $s6, $a0 
    li $t7, 'A'
    li $t6, 'Z'
    li $t5, 'a' 
    li $t2, 'z' 
    li $t1, '\0'   
    
    beq $s6, $t1, working
    
    thisloop:
    lb $s7, 0($s6)
    beq $s7, $t1, newS
    
    blt $s7, $t7, working
    ble $s7, $t6, newS2
    blt $s7, $t5, working
    ble $s7, $t2, newS2
    newS2:
    
    addi $s6, $s6, 1
    j thisloop
  
    working:
    li $v0, 0
    j hurray
    
    newS:    
    
    # String Argu
    move $s0, $a0
    
    # Int i
    li $t1, 0
    
    # Final Count
    li $v0, 0 
    
    # Argu.size()    
    li $s1, '\0'
    
    # Int j
    li $t2, 0
    
    loop:
    beq $t0,  $s1, loopend
    
    # String Start at(0)
    lb $t0, 0($s0)
    
    move $t2, $t1
    
    # char_count
    li $k0, 1
    
    loop2:
    # argu.at(j)
    lb $t3, 0($s0)
    
    # argu.at(j+1)
    lb $t4, 1($s0)
    beq $t3, $t4, loopend2
    j after
    
    loopend2:
    # char_count++
    addi $k0, $k0, 1
    addi $s0, $s0, 1
    j loop2
    
    after:
    li $k1, 3
    bgt $k0, $k1, afterline
    add $v0, $v0, $k0
    addi $s0, $s0, 1
    lb $t0, 0($s0)
    j loop
    
    afterline:
    addi $v0, $v0, 3
    li $t5, 9
    bgt $k0, $t5, afterlife
    addi $s0, $s0, 1
    lb $t0, 0($s0)
    j loop
    
    afterlife:
    addi $v0, $v0, 1
    addi $s0, $s0, 1
    lb $t0, 0($s0)
    j loop    
    
    loopend:
    
    addi $v0, $v0, 1
    j hurray
       
    hurray:
    
    lw $s7, 16($sp)
    lw $s6, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 20
    
    jr $ra

encodeRun:
    #Define your code here
    addi $sp, $sp, -28
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)    
    sw $s5, 16($sp)    
    sw $s6, 20($sp)
    sw $s7, 24($sp) 
    
    move $s5, $a0 # good
    move $s6, $a1 # good
    move $s7, $a3 # good
    
    blez $s6, theendR
        
    la $t1, symbol 
    li $t2, '\0' 
    li $t3, '.'   
        
    roling3:
    lb $t4, 0($t1)
    beq $t4, $t3, theendR
    beq $s7, $t4, spyro
    addi $t1, $t1, 1
    j roling3                                                                        
                                                     
    spyro:    
    
    li $t4, 'A'
    li $t5, 'Z'
    li $t6, 'a' 
    li $t7, 'z' 
    
    blt $s5, $t4, theendR
    ble $s5, $t5, spyro2
    blt $s5, $t6, theendR
    ble $s5, $t7, spyro2
    j theendR
    
    theendR:
    move $v0, $a2
    li $v1, 0
    j theendL
    
    spyro2:        
    
    # encodeRun_letter G
    move $s0, $a0
    
    # encodeRun_runLength 17
    move $s1, $a1
    
    # encodeRun_output End
    move $s2, $a2
    
    # encodeRun_runFlag !
    move $s3, $a3
    
    li $t0, 3
    li $t1, 4
    
    ble $s1, $t0, step1
    j nextIF
    
    step1:
    # int x = 0
    li $t3, 0
    
    whileL:
    beq $t3, $s1, nextIF
    sb $s0, ($s2)
    addi $s2, $s2, 1
    addi $t3, $t3, 1
    j whileL
    
    nextIF:
    
    bge  $s1, $t1, step2
    j endIF
    
    step2:
    sb $s3, ($s2)
    addi $s2, $s2, 1
    sb $s0, ($s2)
    addi $s2, $s2, 1
    
    li $t3, 2
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $s1
    move $a1, $s2
    move $a2, $t3
    jal uitoa
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    move $s2, $v0    
      
    endIF:
    move $v0, $s2
    li $v1, 1
    
    theendL:
   
    lw $s7, 24($sp)
    lw $s6, 20($sp)
    lw $s5, 16($sp) 
    lw $s3, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 28
    jr $ra

runLengthEncode:
    #Define your code here
    
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)     
    
    move $s3, $a3  
    la $t1, symbol 
    li $t2, '\0' 
    li $t3, '.'   
        
    roling4:
    lb $t4, 0($t1)
    beq $t4, $t3, yesman
    beq $s3, $t4, yugi
    addi $t1, $t1, 1
    j roling4                                                             
    yugi:
    
    move $s0, $a0  #input
    move $s1, $a1  #output
    move $s2, $a2  #output size
    move $s3, $a3  #run flag
    
    move $a1, $s3 
     
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal encodedLength
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    ble $v0, $s2, newwork
    li $v0, 0
    j who
    newwork:
    
    add $t0, $v0, $s1
    addi $t0, $t0, -1
    li $t1, '\0'    
    sb $t1, ($t0)
    
    do: 
    lb $t2, 0($s0)
    li $t1, '\0'
    beq $t2, $t1, donut
    # char_count
    li $k0, 1
    
    homer:
    lb $t2, 0($s0)
    lb $t3, 1($s0)
    bne $t2,  $t3, marge
    addi $k0, $k0, 1
    addi $s0, $s0, 1
    j homer
    marge:
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $t2
    move $a1, $k0
    move $a2, $s1
    move $a3,  $s3
    jal encodeRun
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    move $s1, $v0
    
    addi $s0, $s0, 1
        
    j do
    donut:
    
    li $v0, 1
    j who
    
    yesman:
    li $v0, 0
    
    who:
     
    lw $s3, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 16
    
    jr $ra

##############################
# PART 3 FUNCTION
##############################

editDistance:
    #Define your code here
    addi $sp, $sp, -32
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)    
    sw $s4, 16($sp)
    sw $s5, 20($sp)    
    sw $s6, 24($sp)
    sw $s7, 28($sp) 
    
    move $s0, $a0 # editDistance_input_str1: BunnyBunny
    move $s1, $a1 # editDistance_input_str2: FunnyFunny
    move $s2, $a2 # editDistance_m: 5
    move $s3, $a3 # editDistance_n: 5
    
    bltz $s2, wrong
    bltz $s3, wrong
    
    li $t0, ':'
    li $t1, 'm'
    li $t2, 'n'
    li $t3, '\n'
    li $t4, ','

    li $v0, 11
    move $a0, $t1 # Print m
    syscall 

    li $v0, 11
    move $a0, $t0
    syscall 
    
    li $v0, 1 
    move $a0, $s2 # Print int m
    syscall

    li $v0, 11 
    move $a0, $t4 # Print int ,
    syscall

    li $v0, 11
    move $a0, $t2 # Print n
    syscall 

    li $v0, 11
    move $a0, $t0
    syscall 
    
    li $v0, 1 
    move $a0, $s3 # Print int n
    syscall

    li $v0, 11 
    move $a0, $t3 # Print int \n
    syscall
    
    beqz $s2, return
    beqz $s3, return2
    j nreturn
    
    return:
    move $v0, $s3
    j wfinish
    
    return2:
    move $v0, $s2 
    j wfinish
    
    nreturn:
    
    li $t0, 1
    
    sub $s5, $s2, $t0  # m-1
    sub $s6, $s3, $t0  # n-1      
    
    add $t1, $s0, $s5
    add $t2, $s1, $s6
    
    lb $k0, 0($t1)   
    lb $k1, 0($t2) 
          
    beq $k0, $k1, returnL
    j returnR
    
    returnL:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s5
    move $a3, $s6
    jal editDistance
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j wfinish                                         
                                                                                                                               
    returnR:
    
    # Insert
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s2
    move $a3, $s6
    jal editDistance
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    move $s4, $v0
    
    # remove
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s5
    move $a3, $s3
    jal editDistance
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    move $s7, $v0  
    
    # replace
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s5
    move $a3, $s6
    jal editDistance
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    move $t0, $v0
    
    # min
    move $v0, $s4
    
    bgt $v0, $s7, min
    j min2
    min:
    move $v0, $s7
    min2:
    bgt $v0, $t0, min3
    j min4
    min3:
    move $v0, $t0
    min4:
    addi $v0, $v0, 1
    j wfinish
        
    wrong:
    li $v0, -1
    
    wfinish:   
   
    lw $s7, 28($sp)
    lw $s6, 24($sp)
    lw $s5, 20($sp) 
    lw $s4, 16($sp)
    lw $s3, 12($sp)
    lw $s2, 8($sp)
    lw $s1, 4($sp)
    lw $s0, 0($sp)
    addi $sp, $sp, 32
    jr $ra
