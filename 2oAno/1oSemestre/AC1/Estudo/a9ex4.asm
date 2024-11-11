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
# Mapa de registos

# $t0 = p
# $t1 = n
# $t2 = u
# $f2 = max
# $f4 = *p
max:
	move	$t0, $a0
	move	$t1, $a1
	addi	$t1, $t1, -1
	sll	$t1, $t1, 3
	addu	$t2, $t1, $t0
	l.d	$f2, 0($a0)
	addi	$t0, $t0, 8
for:
	bgt	$t0, $t2, endf
	l.d	$f4, 0($t0)
if:	c.le.d	$f4, $f2
	bc1t	endif
	mov.d	$f2, $f4
	addi	$t0, $t0, 8
	j	for
endif:	addi	$t0, $t0, 8
	j	for
endf:	mov.d	$f0, $f2
	jr	$ra


## main
	.data
str1:	.asciiz	"O m�ximo �: "
array:	.double	5.0, 7.2, -3.0, 9.2
	.text
	.globl	main
	
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, array
	li	$a1, SIZE
	jal	max
	la	$a0, str1
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	