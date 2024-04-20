        .equ baseAdd,0xBF88
        .equ trise,0x6100
        .equ porte,0x6110
        .equ late,0x6120

        .equ trisb,0x6040
        .equ portb,0x6050
        .equ latb,0x6060

        .data

        .text
        .globl main
main:   lui $t0,baseAdd
        lw $t1,trise($t0)
        andi $t1,$t1,0xFFFE
        sw $t1,trise($t0)

        lui $t0,baseAdd
        lw $t1,trisb($t0)
        ori $t1,$t1,0x0001
        sw $t1,trisb($t0)

while:
        lui $t0,baseAdd
        lw $t1,portb($t0)
        andi $t2,$t1,0x0001             # isolar bit RB0
        lw $t1,late($t0)
        andi $t1,0xFFFE                 # colocar RE0 a 0
        xor $t2,$t2,1                   # alternar bit
        or $t1,$t1,$t2                  # RE0 = RB0
        sw $t1,trise($t0)

        ## ??? 

        j while

        jr $ra
