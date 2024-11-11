# g9_4
	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	.eqv	read_float, 6
	.eqv	read_double, 7
	.eqv	SIZE, 4
	
	.text
# double max(double *p, unsigned int n)
# $a0 = double *p
# $a1 = int n
lancelot:	
	sll $t9,$a1,3		# n*8
	addi $t9,$t9,-8		# n*8 - 8
	
	addu $t0,$a0,$t9		# double *u = p+n–1;
	
	
	
	l.d $f2,0($a0)		# max = p[0]
	addiu $a0,$a0,8		# p++
	
for:	bgt $a0,$t0,endf
	
	l.d $f4,0($a0)		# *p
if:	c.le.d $f4,$f2
	bc1t endif
	mov.d $f2,$f4		# novo max
endif:
	addiu $a0,$a0,8		# p++
	j for

endf:	mov.d	$f0, $f2
	jr $ra


	.data
str1:	.asciiz	"O máximo é: "
array:	.double	5.0, 7.2, -3.0, 9.2
	.text
	.globl	main
	
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, array
	li	$a1, SIZE
	jal	lancelot
	la	$a0, str1
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	
	
	
	