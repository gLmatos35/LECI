	.eqv 	print_int, 1
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 20
	.eqv	SIZE1, 21
	
	.data
str:	.space	SIZE1
str1:	.asciiz "Introduza uma String: "
# Mapa de registos:
# $t0 = p
# $t1 = 'a'
# $t2 = 'A'
# $t3 = 'a' - 'A'
	.text
	.globl 	main
	
main:	
	la	$a0, str1
	li	$v0, print_string
	syscall
	la	$a0, str
	li	$a1, SIZE
	li	$v0, read_string
	syscall
	li	$t1, 'a'
	li	$t2, 'A'
	sub	$t3, $t1, $t2
	
	la	$t0, str
	
while:	lb	$t4, 0($t0)
	beq	$t4, $0, ewhile
	sub	$t4, $t4, $t1
	add	$t4, $t4, $t2
	sb	$t4, 0($t0)
	addi	$t0, $t0, 1
	j	while
ewhile:
	la	$a0, str
	li	$v0, print_string
	syscall
	jr	$ra
	
	