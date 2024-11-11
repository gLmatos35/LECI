	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 3
	
	.data
	
str1:	.asciiz "Rafael"
str2:	.asciiz "Carvalho"
str3:	.asciiz "Dias"
array:	.word	str1, str2, str3
str4:	.asciiz "\nString #"

	.text
	.globl main
	
# Mapa de registos
# $t1 = i
# $t3 = j
	
main:	li	$t1, 0
	li	$t2, SIZE
for:	bge	$t1, $t2, efor
	la	$a0, str4
	li	$v0, print_string
	syscall
	move	$a0, $t1
	li	$v0, print_int
	syscall
	li	$a0, ':'
	li	$v0, print_chr
	syscall
	li	$t3, 0

	
while:	la	$t0, array
	sll	$t4, $t1, 2
	addu	$t0, $t0, $t4
	lw	$t6, 0($t0)
	addu	$t6, $t6, $t3
	lb	$t5, 0($t6)
	beq	$t5, $0, ewhile
	move	$a0, $t5
	li	$v0, print_chr
	syscall
	li	$a0, '-'
	li	$v0, print_chr
	syscall
	addi	$t3, $t3, 1
	j	while
ewhile:	addi	$t1, $t1, 1
	j 	for
efor:	jr	$ra
	
	
	
	
	
	
	
	
	
	
	
	
	