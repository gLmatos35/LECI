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

        li $t2,1                        # bit = 1;

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
        blt $v0,6666666,wait            # f = xHz

        lw $t1,trisb($t0)
        ori $t1,$t1,0x000E
        ## 0000 0000 0000 1110
        sw $t1,trisb($t0)               # RB3 - RB1 as inputs

        lw $t1,portb($t0)
        andi $t1,$t1,0x0002
if:     bne $t1,0x0002,if2
        bne $t2,0x0008,continue
        li $t2,1                        # reset to 1
        j endifs

continue:
        sll $t2,$t2,1                   # shift bit to the left;
        j endifs

if2:    bne $t2,1,continue2
        li $t2,0x0008
        j endifs

continue2:
        srl $t2,$t2,1                   # shift bit to the right;

endifs:
        andi $t2,$t2,0x000F             # up counter MOD 16

        j while

        jr $ra
