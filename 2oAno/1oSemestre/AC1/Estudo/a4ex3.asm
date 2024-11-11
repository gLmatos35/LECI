	.eqv 	print_int, 1
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	
	.eqv	SIZE, 4
	.data

array:	.word	2, 23, 5, 20
str1:	.asciiz " A soma é: "
	.text
	.globl main
#Mapa de registos:

# $t0 = soma
# $t1 = p
# $t2 = SIZE
# $t3 = pultimo
	
main:	li	$t0, 0
	la	$t1, array
	li	$t2, SIZE
	sll	$t2, $t2, 2
	addu	$t3, $t2, $t1

	
while:	bge	$t1, $t3, ewhile
	lw	$t4, 0($t1)
	addu	$t0, $t0, $t4
	addi	$t1, $t1, 4
	j while
ewhile:	move	$a0, $t0
	li	$v0, print_int
	syscall
	jr	$ra
	

	
	

