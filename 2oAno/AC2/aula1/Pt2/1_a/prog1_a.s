# int main(void) 
# { 
#     char c; 
#     int cnt = 0; 
#     do 
#     { 
#        c = getChar(); 
#        putChar( c ); 
#        cnt++; 
#     } while( c != '\n' ); 
#     printInt(cnt, 10); 
#     return 0; 
# }

        .equ getChar,2
        .equ putChar,3
        .equ printInt,6

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-12
        sw $ra,0($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)

        li $s0,0        # cnt = 0
do:     li $v0,getChar
        syscall
        move $s1,$v0    # c = getChar()
        move $a0,$s1
        li $v0,putChar
        syscall
        addiu $s0,$s0,1 # cnt++
while:  bne $s1,'\n',do

        move $a0,$s0
        li $a1,10
        li $v0,printInt     # printInt(cnt,10)
        syscall
        li $v0,0    # return 0     

        lw $ra,0($sp)
        lw $s0,4($sp)
        lw $s1,8($sp)
        addiu $sp,$sp,12
        jr $ra