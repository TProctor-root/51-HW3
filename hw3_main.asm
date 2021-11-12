.include "hw3.asm"

##############################################################
# Do NOT place any code in this file!
# This file is NOT part of your homework 3 submission.
#
# Modify this file or create new files to test your functions.
##############################################################

.data
str_input: .asciiz "Input: "
str_result: .asciiz "Result: "
str_return: .asciiz "Return: "

# decodedLength
decodedLength_header: .asciiz "\n\n********* decodedLength *********\n"
decodedLength_input: .asciiz "sss!j4q!F5"
decodedLength_runFlag: .ascii "!"

# decodeRun
decodeRun_header: .asciiz "\n\n********* decodeRun *********\n"
decodeRun_letter: .ascii "G"
.align 2
decodeRun_runLength: .word 6
decodeRun_output: .asciiz "asd9u2j,as,j213se!"


# runLengthDecode
runLengthDecode_header: .asciiz "\n\n********* runLengthDecode *********\n"
runLengthDecode_input: .asciiz "sss!j4q!F5"
runLengthDecode_output: .asciiz "jhjkhasd987(!@q2j312kja214asasHJU!#Kasjd21"
.align 2
runLengthDecode_outputSize: .word 18
runLengthDecode_runFlag: .ascii "!"

# encodedLength
encodedLength_header: .asciiz "\n\n********* encodedLength *********\n"
encodedLength_input: .asciiz "xxhhhhhhhhhhhhhhhuuunnnnnnnrere"

# encodeRun
encodeRun_header: .asciiz "\n\n********* encodeRun *********\n"
encodeRun_letter: .ascii "G"
.align 2
encodeRun_runLength: .word 17
encodeRun_output: .asciiz "JASDo823das[23]4[d!!13qdfas21qdqewsf[aes234[faeasdfaaa113"
encodeRun_runFlag: .ascii "!"


# runLengthEncode
runLengthEncode_header: .asciiz "\n\n********* runLengthEncode *********\n"
runLengthEncode_input: .asciiz "AAAhhhhhhhabc"
runLengthEncode_output: .asciiz "f78raewkuiO*A&*(QAWE2qp8947kjdfs244"
.align 2
runLengthEncode_outputSize: .word 10
runLengthEncode_runFlag: .ascii "*"

# editDistance
editDistance_header: .asciiz "\n\n********* editDistance *********\n"
editDistance_input_str1: .asciiz "BunnyBunny"
editDistance_input_str2: .asciiz "FunnyFunny"
.align 2
editDistance_m: .word 5
editDistance_n: .word 5

.text
.globl main

main:

    ############################################
    # TEST CASE for decodedLength
    ############################################

    li $v0, 4
    la $a0, decodedLength_header
    syscall

    la $a0, decodedLength_input
    la $a1, decodedLength_runFlag
    lb $a1, 0($a1) 
    jal decodedLength

    move $t0, $v0
    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    ############################################
    # TEST CASE for decodeRun
    ############################################
    li $v0, 4
    la $a0, decodeRun_header
    syscall
    
    la $a0, decodeRun_letter
    lb $a0, 0($a0) 
    lw $a1, decodeRun_runLength
    la $a2, decodeRun_output
    move $s0, $a2 # make copy of memory address so we can print the string after function returns
    jal decodeRun

    # since $v0 points to an unprocessed part of output[] there is no sense in printing it
    move $t1, $v1

    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t1
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
    
    

    li $v0, 4
    la $a0, str_result
    syscall
    li $v0, 4
    move $a0, $s0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    ############################################
    # TEST CASE for runLengthDecode
    ############################################
    li $v0, 4
    la $a0, runLengthDecode_header
    syscall
    la $a0, runLengthDecode_input
    la $a1, runLengthDecode_output
    lw $a2, runLengthDecode_outputSize
    la $a3, runLengthDecode_runFlag
    lb $a3, 0($a3) 

    move $s0, $a1  # make copy of memory address so we can print the string after function returns
    jal runLengthDecode

    move $t0, $v0

    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
    li $v0, 4
    la $a0, str_result
    syscall
    li $v0, 4
    move $a0, $s0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    ############################################
    # TEST CASE for encodedLength
    ############################################
    li $v0, 4
    la $a0, encodedLength_header
    syscall
    la $a0, encodedLength_input
    jal encodedLength

    move $t0, $v0
    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    ############################################
    # TEST CASE for encodeRun
    ############################################
    li $v0, 4
    la $a0, encodeRun_header
    syscall
    
    la $a0, encodeRun_letter
    lb $a0, 0($a0) 
    lw $a1, encodeRun_runLength
    la $a2, encodeRun_output
    la $a3, encodeRun_runFlag
    lb $a3, 0($a3) 
    move $s0, $a2  # make copy of memory address so we can print the string after function returns
    jal encodeRun

    move $t1, $v1
    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t1
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
    li $v0, 4
    la $a0, str_result
    syscall
    li $v0, 4
    move $a0, $s0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

    ############################################
    # TEST CASE for runLengthEncode
    ############################################
    li $v0, 4
    la $a0, runLengthEncode_header
    syscall

    la $a0, runLengthEncode_input
    la $a1, runLengthEncode_output
    lw $a2, runLengthEncode_outputSize
    la $a3, runLengthEncode_runFlag
    lb $a3, 0($a3) 
    move $s0, $a1  # make copy of memory address so we can print the string after function returns
    jal runLengthEncode

    move $t1, $v0

    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t1
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
    li $v0, 4
    la $a0, str_result
    syscall
    li $v0, 4
    move $a0, $s0
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall


    ############################################
    # TEST CASE for editDistance
    ############################################

    li $v0, 4
    la $a0, editDistance_header
    syscall

    la $a0, editDistance_input_str1
    la $a1, editDistance_input_str2
    lw $a2, editDistance_m
    lw $a3, editDistance_n
    jal editDistance

    move $t1, $v0

    li $v0, 4
    la $a0, str_return
    syscall
    li $v0, 1
    add $a0, $zero, $t1
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall


    # Exit main
    li $v0, 10
    syscall


