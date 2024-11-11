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

	.data
k1:	.float	1.0
str1:	.asciiz	"Indique a base: "
str2:	.asciiz	"\nIndique o expoente: "
str3:	.asciiz	"\nResultado: "
	.text
	.globl	main

# int abs(int val)
abs:	bge	$a0, 0, end
	mul	$a0, $a0, -1
end:	move	$v0, $a0
	jr	$ra


# float xtoy(float x, int y)
xtoy:
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)		# ser�s o y
	s.s	$f20, 8($sp)		# $f20 = x
	s.s	$f22, 12($sp)		# $f22 = result = 1.0
	mov.s	$f20, $f12		# x
	move	$s0, $a0		# y
	la	$t1, k1
	l.s	$f22, 0($t1)		# 1.0
	jal	abs
	move	$t0, $v0		# abs(y) = $t0
	li	$t1, 0			# i = 0
for:	bge	$t1, $t0, efor		# for(i=0, result=1.0; i < abs(y); i++)

if:	ble	$s0, 0, else
	mul.s	$f22, $f22, $f20
	j	eif
else:	div.s	$f22, $f22, $f20
eif:	addi	$t1, $t1, 1
	j	for
	
efor:	mov.s	$f0, $f22
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)		
	l.s	$f20, 8($sp)		
	l.s	$f22, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra
	
## main
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_float
	syscall
	mov.s	$f12, $f0
	la	$a0, str2
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$a0, $v0
	jal	xtoy
	la	$a0, str3
	li	$v0, print_string
	syscall
	mov.s	$f12, $f0
	li	$v0, print_float
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	




	