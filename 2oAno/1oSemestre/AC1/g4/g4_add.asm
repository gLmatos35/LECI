# g4_add
# Mapa de Registos:
# rip $t0
# $t1 - p
# $t2 - *p

	.eqv SIZE,20		# #define SIZE 20
	.eqv SIZEmais1,21	
	.eqv print_str,4		
	.eqv read_str,8

	.data
str:	.space SIZEmais1		# static char str[SIZE+1];
str1:	.asciiz "Introduz uma string: "
str2:	.asciiz "\nString modificada: "

	.text
	.globl main
main:	la $a0,str1
	li $v0,print_str
	syscall			# print_string("Introduza uma string: ");
	
	la $a0,str
	li $a1,SIZE
	li $v0,read_str
	syscall			# read_string(str, SIZE);
	
	la $a0,str2
	li $v0,print_str
	syscall 			# print("\nString modificada: ")
	
	la $t1,str		# p = str; 
### while ### 	
while:	lb $t2,0($t1)		# $t2 = *p
	beq $t2,$0,endW		# while (*p != '\0')
	
	addi $t2,$t2,-0x20	# *p = *p – 'a' + 'A';
	sb $t2,0($t1)		# ??
	addiu $t1,$t1,1		# p++

	j while

endW:	la $a0,str
	li $v0,print_str
	syscall 			# print_string(str); 
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
