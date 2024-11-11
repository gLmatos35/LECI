	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.data
	
str1:	.asciiz "Nº de parametros: "
str2:	.asciiz	": "
str3:	.asciiz	"\nP"
str4:	.asciiz	"\nNº de caracteres: "

# Ainda não está acabado nem estará
	
	.text
	.globl main

main:	move	$t0, $a0
	move	$t1, $a1
	li	$t8, 0
	la	$a0, str1
	li	$v0, print_string
	syscall
	move	$a0, $t0
	li	$v0, print_int
	syscall
	li	$t2, 0
for:	bge	$t2, $t0, efor
	la	$a0, str3
	li	$v0, print_string
	syscall
	move	$a0, $t2
	li	$v0, print_int
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	sll	$t3, $t2, 2
	addu	$t4, $t1, $t3
	lw	$t5, 0($t4)
	move	$a0, $t5
	li	$v0, print_string
	syscall
	la	$a0, str4
	li	$v0, print_string
	syscall
	li	$t7, 0
while:	lw	$t5, 0($t4)
	addu	$t5, $t5, $t7
	lbu	$t6, 0($t5)
	beq	$t6, $0, ewhile
	addi	$t7, $t7, 1
	j 	while
	
	
ewhile:	addi	$t2, $t2, 1
	move	$a0, $t7
	li	$v0, print_int
	syscall
if:	bge	$t8, $t7, e
	move	$t8, $t7
	
e:	j	for
	

	
efor:	move	$a0, $t8
	li	$v0, print_int
	syscall
	li	$v0, 0
	jr	$ra