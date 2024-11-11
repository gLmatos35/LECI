# g4_3a	_
# Mapa de Registos:
# p: $t0 
# pultimo:$t1 
# *p $t2 
# soma: $t3

	.data
	
	.eqv SIZE,4
array:	.word 7692,23,5,234	# int array[4] = {7692, 23, 5, 234}; #+-

str1:	.asciiz "array = {7692,23,5,234}"
str2:	.asciiz "\nSoma dos valores do array: "

	.eqv print_int10,1
	.eqv print_str,4
	
	.text
	.globl main
main:	la $a0,str1
	li $v0,print_str
	syscall
	
	la $a0,str2
	li $v0,print_str
	syscall

	li $t3,0			# int soma = 0; 
	la $t0,array		# p = array;
	
	li $t9,SIZE
	sll $t9,$t9,2		# 4 * 2^2 = 16 ( 4 ints = 4 bytes )
	addu $t1,$t0,$t9		# 
	addiu $t1,$t1,-4		# pultimo=array+SIZE-1	# ??? 
	
while:	bgt $t0,$t1,endW		# while( p <= pultimo ) {

	lw $t2,0($t0)		# $t2 = *p
	add $t3,$t3,$t2		# soma = soma + (*p);
	addiu $t0,$t0,4		# p++
	
	j while
	
endW:	move $a0,$t3
	li $v0,print_int10
	syscall 			# print_int10(soma);
	jr $ra
	
	
	
	
	