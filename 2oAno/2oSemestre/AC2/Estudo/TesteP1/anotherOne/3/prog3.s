        .equ baseAddress,0xBF88
        .equ TRISE,0x6100
        .equ PORTE,0x6110
        .equ LATE, 0x6120

        .equ readCoreTimer,11
        .equ resetCoreTimer,12

        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-4
        sw $s0,0($sp)

        lui $t0,baseAddress
        lw $t1,TRISE($t0)
        andi $t1,$t1,0xFFC1
        sw $t1,TRISE($t0)

        li $t2,0x2              # valor inicial

while:  lw $t1,LATE($t0)
        andi $t1,$t1,0xFFC1     # limpar
        or $t1,$t1,$t2          # inserir valor
        sw $t1,LATE($t0)

        li $a0,'\n'
        li $v0,putChar
        syscall

        srl $t3,$t2,1
        move $a0,$t3
        li $a1,2
        li $t4,5
        sll $t4,$t4,16
        or $a1,$a1,$t4pte
        li $v0,printInt
        syscall

        sll $t2,$t2,1
reset:  blt $t2,0x40,skip
        li $t2,0x2              # reset valor
skip:

        li $v0,resetCoreTimer
        syscall
loop:   li $v0,readCoreTimer
        syscall
        blt $v0,8695652,loop

        j while

        lw $s0,0($sp)
        addiu $sp,$sp,4

        li $v0,0                # return 0;

        jr $ra
