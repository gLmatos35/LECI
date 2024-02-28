# int main(void)
# {
#       char c;
#       int cnt = 0;
#       do
#       {
#             c = getChar();
#             putChar( c );
#             cnt++;
#       } while( c != '\n' );
#       printInt(cnt, 10);
#       return 0;
# }

        .equ getChar,2
        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-8
        sw $ra,0($sp)
        sw $s0,4($sp)

        li $s0,0                # cnt = 0;
do:     li $v0,getChar          # do
        syscall                 # c = getChar();
        move $t0,$v0            # c
        move $a0,$v0
        addi $a0,$a0,1          # c + 1
        li $v0,putChar
        syscall                 # putChar(c+1):
        addi $s0,$s0,1          # cnt++;

while:  bne $a0,'\n',do         # while (c != '\n') {

        move $a0,$s0            # cnt
        li $a1,10
        li $v0,printInt
        syscall                 # printInt(cnt,10);
        li $v0,0                # return 0;

        lw $ra,0($sp)
        lw $s0,4($sp)
        addiu $sp,$sp,8

        jr $ra

