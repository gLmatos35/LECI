        .equ readInt10,5
        .equ printInt,6
        .equ printInt10,7
        .equ printStr,8

        .data
str:    .asciiz "\nIntroduza um inteiro (sinal e módulo): "
f10:    .asciiz "\nValor em base 10 (signed): "
f2:     .asciiz  "\nValor em base 2: "
f16:    .asciiz "\nValor em base 16: "
f10un:  .asciiz "\nValor em base 10 (unsigned): "
f10unf: .asciiz "\nValor em base 10 (unsigned), formatado: "

        .text
        .globl main
main:   addi $sp,$sp,-4
        sw $s0,0($sp)

        la $a0,str
        li $v0,printStr
        syscall                 # printStr("\nIntroduza um inteiro (sinal e módulo): ");

        li $v0,readInt10
        syscall                 # readInt10();
        move $s0,$v0

        la $a0,f10
        li $v0,printStr
        syscall
        move $a0,$s0
        li $v0,printInt10
        syscall

        la $a0,f2
        li $v0,printStr
        syscall
        move $a0,$s0
        li $a1,2
        li $v0,printInt
        syscall

        la $a0,f16
        li $v0,printStr
        syscall
        move $a0,$s0
        li $a1,16
        li $v0,printInt
        syscall

        la $a0,f10un
        li $v0,printStr
        syscall
        move $a0,$s0
        li $a1,10
        li $v0,printInt
        syscall

        la $a0,f10unf
        li $v0,printStr
        syscall
        move $a0,$s0
        li $a1,10
        li $t0,5
        sll $t0,$t0,16
        or $a1,$a1,$t0          # 10 | 5 << 16
        li $v0,printInt
        syscall

        lw $s0,0($sp)
        addi $sp,$sp,4

        li $v0,0                # return 0;

        jr $ra
