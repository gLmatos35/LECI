	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	
	.data
k:	.float	2.59375
k2:	.float	0.0
str:	.asciiz	"\nInsira um inteiro: "
	.text
	.globl	main
	
# Mapa de registos

# $f2 = res
	
main:	

do:	la	$a0, str
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	mtc1	$v0, $f4
	cvt.s.w	$f4, $f4
	la	$t0, k
	l.s	$f2, 0($t0)			#res = 2.59375
	mul.s	$f2, $f2, $f4
	mov.s	$f12, $f2
	li	$v0, print_float
	syscall
	la	$t1, k2
	l.s	$f6, 0($t1)
	c.eq.s	$f4, $f6
	bc1t	edo
	j	do
edo:	jr	$ra
