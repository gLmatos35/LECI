# int main(void) 
#    { 
#     int value; 
#     while(1) 
#     { 
#      printStr("\nIntroduza um inteiro (sinal e módulo): "); 
#      value = readInt10(); 
#      printStr("\nValor em base 10 (signed): "); 
#      printInt10(value); 
#      printStr("\nValor em base 2: "); 
#      printInt(value, 2); 
#      printStr("\nValor em base 16: "); 
#      printInt(value, 16); 
#      printStr("\nValor em base 10 (unsigned): "); 
#      printInt(value, 10); 
#      printStr("\nValor em base 10 (unsigned), formatado: "); 
#      printInt(value, 10 | 5 << 16); // ver nota de rodapé 3 
#     } 
#     return 0; 
# }

        .equ readInt10,5
        .equ printInt,6
        .equ printInt10,7
        .equ printStr,8
        
        .data
str1:   .asciiz "\nIntroduza um inteiro (sinal e módulo): "
b10:    .asciiz "\nValor em base 10 (signed): "
b2:     .asciiz "\nValor em base 2: "
b16:     .asciiz "\nValor em base 16: "
b10u:   .asciiz "\nValor em base 10 (unsigned): "
b10uf:  .asciiz "\nValor em base 10 (unsigned), formatado: "

        .text
        .globl main
main:   
while:  la $a0,str1
        li $v0,printStr
        syscall                 # printStr("\nIntroduza um inteiro (sinal e módulo): ");

        li $v0,readInt10
        syscall
        move $t0,$v0            # value = readInt10;

        la $a0,b10
        li $v0,printStr
        syscall                 # printStr("\nValor em base 10 (signed): ");

        move $a0,$t0
        li $v0,printInt10
        syscall                 # printInt10(value);

        la $a0,b2
        li $v0,printStr
        syscall                 # printStr("\nValor em base 2: ");

        move $a0,$t0
        li $a1,2
        li $v0,printInt
        syscall                 # printStr("\nValor em base 2: ");

        la $a0,b16
        li $v0,printStr
        syscall                 # printStr("\nValor em base 16: "); 

        move $a0,$t0
        li $a1,16
        li $v0,printInt
        syscall                 # printInt(value, 16); 

        la $a0,b10u
        li $v0,printStr
        syscall                 # printStr("\nValor em base 10 (unsigned): "); 

        move $a0,$t0
        li $a1,10
        li $v0,printInt
        syscall                 # printInt(value, 10); 

        la $a0,b10uf
        li $v0,printStr
        syscall                 # printStr("\nValor em base 10 (unsigned), formatado: "); 

        move $a0,$t0
        li $t1,5
        sll $t1,$t1,16
        or $a1,$t1,10           # 10 | 5 << 16
        li $v0,printInt
        syscall                 # printInt(value, 10 | 5 << 16);

        j while

        li $v0,0                # return 0;
        jr $ra