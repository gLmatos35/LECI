	.eqv 	print_int, 1
	.eqv 	read_string, 8
	.eqv 	print_string, 4 
	
	.eqv SIZE, 20
	.eqv SIZE1, 21
	.data
	
str:	.space SIZE1			#static char str[SIZE+1]
str1:	.asciiz "Introduza uma String: "
str2:	.asciiz "N�mero de algarismos: "




	.text
	.globl main
	
# MAPA DE REGISTOS
# $t0 = p
# $t1 = *p



main:	li	$t0, 0
	la	$t1, str
	
	la	$a0, str1
	li	$v0, print_string
	syscall
	move	$a0, $t1
	li	$a1, SIZE
	li	$v0, read_string
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	
while:	lb	$t2, 0($t1)
	beq	$t2, $0, ewhile
	bgt	$t2, '9', eif
	blt	$t2, '0', eif
	addi	$t0, $t0, 1
	
eif:	addiu	$t1, $t1, 1
	j	while
	
ewhile:	move	$a0, $t0
	li	$v0, print_int
	syscall
	jr	$ra
	
	