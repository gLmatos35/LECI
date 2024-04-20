        .equ putChar,3
        .equ printInt,6
        .equ readCoreTimer,11
        .equ resetCoreTimer,12

        .equ baseAdd,0xBF88
        .equ trise,0x6100
        .equ porte,0x6110
        .equ late,0x6120

        .equ trisb,0x6040
        .equ portb,0x6050
        .equ latb,0x6060

        .equ trisd,0x60C0
        .equ portd,0x60D0
        .equ latd,0x60E0

        .data

        .text
        .globl main
main:   lui $t0,baseAdd
        lw $t1,trise($t0)
        andi $t1,$t1,0xFFE1
        ## 1111 1111 1110 0001
        sw $t1,trise($t0)               # RE4 - RE1 as outputs

        li $t2,0                        # counter = 0;

while:
        lw $t1,late($t0)
        andi $t1,$t1,0xFFE1             # set RE4 - RE1 as '0's 
        sll $t3,$t2,1                   # shift counter value to position 1
        or $t1,$t1,$t3                  # merge counter w/ late value (?)
        sw $t1,late($t0)

        li $v0,resetCoreTimer
        syscall
wait:   li $v0,readCoreTimer
        syscall
        blt $v0,10000000,wait            # f = xHz

        lw $t1,trisb($t0)
        ori $t1,$t1,0x000E
        ## 0000 0000 0000 1110
        sw $t1,trisb($t0)               # RB3 - RB1 as inputs

        lw $t1,portb($t0)
        andi $t1,$t1,0x0008
if:     # srl $t1,$t1,3
        # bne $t1,1,if2
        bne $t1,0x0008,if2
        addi $t2,$t2,1                  # counter++ if RB3 == 1;
        j endifs

if2:    addi $t2,$t2,-1                 # counter-- if RB3 == 0;

endifs:
        andi $t2,$t2,0x000F             # up counter MOD 16

        j while

        jr $ra
