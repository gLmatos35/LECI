	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	.eqv	read_float, 6
	.eqv	read_double, 7
	.eqv	SIZE, 6
	
	.text
	
# Mapa de registos
# $t0 = array
# $t1 = nval
# $t2 = mnval - 1
# $t3 = houveTroca
# $t4 = i

median:	move	$t0, $a0
	move	$t1, $a1
	addi	$t2, $t1, -1
	
do:	li	$t3, 0				# houveTroca = FALSE; 
	li	$t4, 0				# i = 0
for:	bge	$t4, $t2, efor			# for( i = 0; i < nval-1; i++ )
	addi	$t5, $t4, 1			# i+1
	sll	$t6, $t4, 3
	sll	$t5, $t5, 3
	addu	$t5, $t5, $t0
	l.d	$f2, 0($t5)			# array[i+1]
	addu	$t6, $t6, $t0
	l.d	$f4, 0($t6)			# array[i]
if:	c.le.d	$f4, $f2			# if( array[i] > array[i+1] )
	bc1t	eif
	s.d	$f2, 0($t6)			# array[i] = array[i+1];
	s.d	$f4, 0($t5)			# array[i+1] = array[i];
	li	$t3, 1				# houveTroca = TRUE;
	addi	$t4, $t4, 1
	j	for
eif:	addi	$t4, $t4, 1
	j	for
efor:	beq	$t3, 1, do
	div	$t1, $t1, 2
	sll	$t1, $t1, 3
	addu	$t0, $t0, $t1
	l.d	$f0, 0($t0)
	jr	$ra
	
	.data
	
array:	.double	5, 48, 1, 21, 37, 20
str1:	.asciiz	"A mediana é: "
str2:	.asciiz	"\nO array é: "
	.text
	.globl 	main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	la	$a0, array
	li	$a1, SIZE
	jal	median
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	li	$t0, 0
loop:	bge	$t0, SIZE, eloop
	la	$t2, array
	sll	$t1, $t0, 3
	addu	$t2, $t2, $t1
	l.d	$f12, 0($t2)
	li	$v0, print_double
	syscall
	li	$a0, ' '
	li	$v0, print_chr
	syscall
	addi	$t0, $t0, 1
	j 	loop
eloop:	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra

	
	