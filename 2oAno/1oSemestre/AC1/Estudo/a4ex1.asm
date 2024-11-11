	.eqv 	print_int, 1
	.eqv 	read_string, 8
	.eqv 	print_string, 4 
	
	.eqv SIZE, 20
	.eqv SIZE1, 21
	.data
	
str:	.space SIZE1			#static char str[SIZE+1]
str1:	.asciiz "Introduza uma String: "
str2:	.asciiz "Número de algarismos: "	
	


	.text
	.globl main
	
# MAPA DE REGISTOS
# $t0 = i
# $t1 = num
main:
	li 	$t0, 0			# i = 0
	li 	$t1, 0			# num = 0
	la	$a0, str1
	li	$v0, print_string
	syscall
	la	$a0, str
	li	$a1, SIZE
	li	$v0, read_string	
	syscall
	la 	$a0, str2
	li 	$v0,print_string    
    	syscall
    	la 	$t2, str
	
while: 	addu	$t3, $t2, $t0
	lb	$t4, 0($t3)
	beq	$t4, $0, ewhile
	bgt	$t4, '9', eif
	blt	$t4, '0', eif
	addi	$t1, $t1, 1
	
eif:	addi	$t0, $t0, 1
	j	while
ewhile:
	move	$a0, $t1
	li	$v0, print_int
	syscall
	jr	$ra



