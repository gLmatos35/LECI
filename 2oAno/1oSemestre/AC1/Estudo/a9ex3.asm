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
	
	
	.data
array:	.space	32
str1:	.asciiz "Insere um valor: "
str2:	.asciiz	"M�dia: "
	.text

average:
	move	$t0, $a0
	mtc1	$0, $f2
	cvt.d.w	$f2, $f2
	move	$t2, $a1
	addi	$t2, $t2, -1
for:	blt	$t2, $0, efor
	l.d	$f4, 0($t0)
	add.d	$f2, $f2, $f4
	addi	$t0, $t0, 8
	addi	$t2, $t2, -1
	j	for
efor:	mtc1	$a1, $f6
	cvt.d.w	$f6, $f6
	div.d	$f0, $f2, $f6
	jr	$ra
	
	
	.text
	.globl	main
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$t0, array
	li	$t1, 0
loop:	bge	$t1, SIZE, endloop
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	
	s.d	$f0, 0($t0)
	addi	$t0, $t0, 8
	addi	$t1, $t1, 1
	j	loop
endloop:
	li	$a1, SIZE
	la	$a0, array
	jal	average
	la	$a0, str2
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	li	$v0, 0
	jr	$ra
	
	
	
	
	
	
	
