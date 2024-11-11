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
	
	.eqv	duplo, 16
	.eqv	inte, 24
	.eqv	charv, 32
	.eqv	flute, 36
	
			
	.data
	.align	2
uvw:	.asciiz	"St1"
	.space	6
	.align	3
	.double	3.141592653589
	.word	291, 756
	.byte	'X'
	.float	1.983
	
	.text
	
f1:	la	$t0, uvw
	l.d	$f2, duplo($t0)			# $f2 = g
	l.s	$f4, flute($t0)			# $f4 = k		
	li	$t2, inte			
	addu	$t2, $t0, $t2
	li	$t3, 1
	sll	$t3, $t3, 2
	addu	$t2, $t2, $t3
	lw	$t1, 0($t2)			# $t1 = a[1]
	mtc1	$t1, $f6
	cvt.d.w	$f6, $f6			# $f6 = double(a[1])
	cvt.d.s	$f4, $f4
	mul.d	$f8, $f2, $f6
	div.d	$f0, $f8, $f4
	cvt.s.d	$f0, $f0
	jr	$ra
	
	
	.globl	main
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	jal	f1
	mov.s	$f12, $f0
	li	$v0, print_float
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	
	
	
	









