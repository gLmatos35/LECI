	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 10
	
	.data
str1:	.asciiz	"\nConteudo do array:\n"
	.align 	2
lst:	.word	8, -4, 3, 5, 124, -15, 87, 9, 27, 15
	.text
	.globl 	main

# Mapa de registos
# $t0 = p
# $t1 = SIZE
# $t2 = SIZE*4
# $t3 = lista + SIZE*4

main:
	la	$t0, lst
	li	$t1, SIZE
	sll	$t2, $t1, 2
	addu	$t3, $t2, $t0

for:	bge	$t0, $t3, efor
	lw	$a0, 0($t0)
	li	$v0, print_int
	syscall
	li	$a0, ';'
	li	$v0, print_chr
	syscall
	addi	$t0, $t0, 4
	j 	for
efor:	jr	$ra
	
	
