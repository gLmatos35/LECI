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
	
	
	.eqv	int, 16
	.eqv	duplo, 24
	.eqv	a2, 32
	
	.data
k:	.double	0.35
	.align	2
xyz:	.asciiz	"Str_1"
	.space	8
	.word	20
	.align	3
	.double	1
	.asciiz	"Str_2"
	.space	11
	
	.text
	
f2:	move	$t0, $a0
	l.d	$f2, duplo($t0)			# $f2 = g
	lw	$t1, int($t0)			# $t1 = i
	mtc1	$t1, $f4
	cvt.d.w	$f4, $f4			# $f4 = (double)i
	la	$t2, k
	l.d	$f6, 0($t2)
	mul.d	$f8, $f4, $f2
	div.d	$f0, $f8, $f6
	jr	$ra
	
	.text
	.globl	main
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, xyz
	jal	f2
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	