	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	.eqv	read_float, 6
	.eqv	read_double, 7
	.data
	
k1:	.double	5.0
k2:	.double	9.0
k3:	.double	32.0
str:	.asciiz	"\nInsira um valor: "
str2:	.asciiz	"\nValor convertido: "
	.text
f2c:	la	$t0, k1
	l.d	$f2, 0($t0)
	l.d	$f4, 8($t0)
	l.d	$f6, 16($t0)
	sub.d	$f6, $f12, $f6
	div.d	$f2, $f2, $f4
	mul.d	$f4, $f2, $f6	
	mov.d	$f0, $f4
	jr	$ra
	
	
	.text
	.globl 	main
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	mov.d	$f12, $f0
	jal	f2c
	la	$a0, str2
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, -4
	jr	$ra




