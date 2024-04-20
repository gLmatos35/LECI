
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

        li $t2,0                        # ring = 1;

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
        blt $v0,13333333,wait            # f = xHz

        lw $t1,trisb($t0)
        ori $t1,$t1,0x000E
        ## 0000 0000 0000 1110
        sw $t1,trisb($t0)               # RB3 - RB1 as inputs

        lw $t1,portb($t0)
        andi $t1,$t1,0x0004

if:     bne $t1,0x0004,if2              ####################
        srl $t3,$t2,3                   # get 4th bit
        xor $t3,$t3,1
        sll $t2,$t2,1
        andi $t2,$t2,0xFFFE
        or $t2,$t2,$t3

        j endifs

if2:    andi $t3,$t2,0x1                   # get 1st bit (from right)
        xor $t3,$t3,1
        srl $t2,$t2,1
        andi $t2,$t2,0xFFF7
        sll $t3,$t3,3
        or $t2,$t2,$t3


endifs:
        andi $t2,$t2,0x000F             # up counter MOD 16

        j while

        jr $ra

### puta que me pariu ja corrijo

### corrigi caralho
