	.data
str1: 	.asciiz "Introduz 2 valores:\n" 
str2:	.asciiz "Soma dos valores: "
	.eqv print_int,1
 	.eqv print_str,4 
 	.eqv read_int,5
		    
	.text 
	.globl main 
main:	la $a0,str1
	li $v0,print_str
	syscall
	li $v0,read_int
	syscall
	move $t0,$v0
	li $v0,read_int
	syscall
	move $t1,$v0
	add $t0,$t0,$t1
	la $a0,str2
	li $v0,print_str
	syscall				# print(str2)
	or $a0,$0,$t0
	li $v0,print_int
	syscall
	jr $ra