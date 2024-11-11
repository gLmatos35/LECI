	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 5
	
	.data
	.align	2
lst:	.space 	20
str1:	.asciiz	"\nIntroduza um numero: "

	.text
	.globl main
# Mapa  de registos
# $t0 = i
# $t1 = lst

main:	li	$t0, 0
	la	$t1, lst
	li	$t2, SIZE
	
while:	beq	$t0, $t2, ewhile
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t1)
	addi	$t1, $t1, 4
	addi	$t0, $t0, 1
	j	while
ewhile:
	jr	$ra