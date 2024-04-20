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
        andi $t1,$t1,0xFFFE
        sw $t1,trise($t0)               # RE0 as output

        lui $t0,baseAdd
        lw $t1,trisd($t0)
        ori $t1,$t1,0x0100              
        # 0000 0001 0000 0000
        sw $t1,trisd($t0)               # RD8 as input

while:
        lui $t0,baseAdd
        lw $t1,portd($t0)
        andi $t2,$t1,0x0100             # isolar bit RD8
        srl $t2,$t2,8                   # ??????
        lw $t1,late($t0)
        andi $t1,0xFFFE                 # colocar RE0 a 0
        # xor $t2,$t2,1                   # alternar bit
        or $t1,$t1,$t2                  # RE0 = RB0
        sw $t1,trise($t0)

        ## ??? 

        j while

        jr $ra
