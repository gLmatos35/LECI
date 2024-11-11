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
k1:	.double	1.0
k2:	.double	0.0
k3:	.double	0.5
str1:	.asciiz	"Introduza um valor: "
str2:	.asciiz	"A ra�z quadrada �: "
	.text

# double sqrt(double val)
sqrt:
	mov.d	$f2, $f12		# val
	la	$t0, k1			
	l.d	$f10, 0($t0)		# xn
	l.d	$f6, 8($t0)		# 0.0
	l.d	$f8, 16($t0)		# 0.5
	li	$t1, 0			# i

if:	c.le.d	$f2, $f6
	bc1t	else
do:	mov.d	$f4, $f10		# aux
	div.d	$f10, $f2, $f10		# val/xn
	add.d	$f10, $f10, $f4		# xn + val/xn
	mul.d	$f10, $f8, $f10

	c.eq.d	$f4, $f10               # (aux != xn)
	bc1t	endw

	addi	$t1, $t1, 1		# i++
	bge	$t1, 25, endw           # (++i < 25)
	j	do
else:	mov.d	$f10, $f6
endw:	mov.d	$f0, $f10
	jr	$ra
	

	.globl	main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	jal	sqrt
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	
	
