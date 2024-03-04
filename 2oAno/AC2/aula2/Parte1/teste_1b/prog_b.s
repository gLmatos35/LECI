# int main(void) 
# { 
#     int counter = 0; 
#     while(1) 
#     { 
#          putChar('\r');                       // cursor regressa ao inicio da linha no ecrã 
#          printInt(counter, 10 | 4 << 16);     // Ver nota de rodapé 1 
#          resetCoreTimer(); 
#          while(readCoreTimer() < 200000); 
#          counter++; 
#     } 
#     return 0; 
# }

        .equ putChar,3
        .equ printInt,6
        .equ readCoreTimer,11
        .equ resetCoreTimer,12

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-8
        sw $ra,0($sp)
        sw $s0,4($sp)

        li $s0,0                # int counter = 0;

loop:  li $a0,'\r'             # cursor regressa ao inicio da linha no ecrã
        li $v0,putChar
        syscall                 # putChar('\r');

        move $a0,$s0
        li $a1,10
        li $t0,4
        sll $t0,$t0,16
        or $a1,$a1,$t0
        li $v0,printInt
        syscall                 # printInt(counter, 10 | 4 << 16);

        li $v0,resetCoreTimer
        syscall                 # resetCoreTimer();

while:  li $v0,readCoreTimer
        syscall                 # readCoreTimer();
        bge $v0,200000,endw     # while(readCoreTimer() < 200000);
        j while

endw:   addiu $s0,$s0,1         # counter++;
        j loop

        li $v0,0                # return 0;

        lw $ra,0($sp)
        lw $s0,4($sp)
        addiu $sp,$sp,8

        jr $ra