	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	.eqv	read_float, 6
	.eqv	read_double, 7
	.eqv	print_intu10, 36
	
	.eqv	nmec, 0
	.eqv	pnome, 4
	.eqv	lnome, 22
	.eqv	grade, 40
	
	.data
	.align	2
	
struct:	.word	114258
	.asciiz	"Rafael"
	.space	11
	.asciiz	"Dias"
	.space	10
	.align	2
	.float	20.0
str1: 	.asciiz	"\nNmec: "
str2:	.asciiz	"\nNome: "
str3:	.asciiz	"\nNota: "
	.text
	.globl	main

	
main:	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	la	$t0, struct
	sw	$v0, 0($t0)
	lw	$a0, 0($t0)
	li	$v0, print_int
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	la	$a0, struct
	addi	$a0, $a0, pnome
	li	$a1, 17
	li	$v0, read_string
	syscall

	addi	$a0, $t0, pnome
	li	$v0, print_string
	syscall
	li	$a0, ' '
	li	$v0, print_chr
	syscall
	la	$t0, struct
	addi	$a0, $t0, lnome
	li	$v0, print_string
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	l.s	$f12, grade($t0)
	li	$v0, print_float
	syscall
	jr	$ra
	

	

	
