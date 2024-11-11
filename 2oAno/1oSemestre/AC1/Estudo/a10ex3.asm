	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	print_float, 2
	.eqv	print_double, 3
	.eqv	read_float, 6
	.eqv	read_double, 7
	.eqv	SIZE, 5
	
	.data
str1:	.asciiz	"\nIntroduza um valor: "
str2:	.asciiz	"M�dia: "
str3:	.asciiz	"\nVar: "
str4:	.asciiz	"\nStdev: "
zero:	.float	0.0
k1f:	.float	1.0
k1:	.double	1.0
k2:	.double	0.0
k3:	.double	0.5
array:	.space	40

	.text
	.globl	main
	
main:	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	la	$s0, array			# array = $s0
	li	$t1, 0				# i = 0 = $t1
loop:	bge	$t1, SIZE, eloop
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	sll	$t2, $t1, 3
	addu	$t3, $s0, $t2
	s.d	$f0, 0($t3)
	addi	$t1, $t1, 1
	j	loop
eloop:	la	$a0, array
	li	$a1, SIZE
	jal	average
	la	$a0, str2
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	la	$a0, array
	li	$a1, SIZE
	jal	var
	la	$a0, str3
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	la	$a0, array
	li	$a1, SIZE
	jal	stdev
	la	$a0, str4
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addiu	$sp, $sp, 8
	li	$v0, 0
	jr	$ra

#############################################################################
abs:	bge	$a0, 0, end
	mul	$a0, $a0, -1
end:	move	$v0, $a0
	jr	$ra

xtoy:
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)		# ser�s o y
	s.s	$f20, 8($sp)		# $f20 = x
	s.s	$f22, 12($sp)		# $f22 = result = 1.0
	mov.s	$f20, $f12		# x
	move	$s0, $a0		# y
	la	$t1, k1f
	l.s	$f22, 0($t1)		# 1.0
	jal	abs
	move	$t0, $v0		# abs(y) = $t0
	li	$t1, 0			# i = 0
for3:	bge	$t1, $t0, efor3		# for(i=0, result=1.0; i < abs(y); i++)

if:	ble	$s0, 0, else
	mul.s	$f22, $f22, $f20
	j	eif
else:	div.s	$f22, $f22, $f20
eif:	addi	$t1, $t1, 1
	j	for3
	
efor3:	mov.s	$f0, $f22
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)		
	l.s	$f20, 8($sp)		
	l.s	$f22, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra
################################################################################
average:
	move	$t0, $a0
	mtc1	$0, $f2
	cvt.d.w	$f2, $f2
	move	$t2, $a1
	addi	$t2, $t2, -1
for2:	blt	$t2, $0, efor2
	l.d	$f4, 0($t0)
	add.d	$f2, $f2, $f4
	addi	$t0, $t0, 8
	addi	$t2, $t2, -1
	j	for2
efor2:	mtc1	$a1, $f6
	cvt.d.w	$f6, $f6
	div.d	$f0, $f2, $f6
	jr	$ra

	
	
###############################################################################

var:	addiu	$sp, $sp, -24
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	s.s	$f20, 16($sp)
	s.s	$f22, 20($sp)
	move	$s0, $a0			# $s0 = array
	move	$s1, $a1			# $s1 = nval
	jal	average
	mov.d	$f22, $f0
	cvt.s.d	$f22, $f22			# $f22 = media			
	li	$s2, 0				# $s2 = i = 0
	la	$t1, zero			
	l.s	$f20, 0($t1)			# $f20 = 0.0 = soma
for:	bge	$s2, $s1, efor
	sll	$t0, $s2, 3
	addu	$t3, $s0, $t0
	l.d	$f2, 0($t3)
	sub.d	$f12, $f2, $f22
	cvt.s.d	$f12, $f12
	li	$a0, 2
	jal	xtoy
	add.s	$f20, $f20, $f0
	addi	$s2, $s2, 1
	j	for
efor:	cvt.d.s	$f20, $f20			# (double)soma
	mtc1	$s1, $f6
	cvt.d.w	$f6, $f6			# (double)nval
	div.d	$f0, $f20, $f6
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	l.s	$f20, 16($sp)
	l.s	$f22, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra
	
#################################################################################
sqrt:
	mov.d	$f2, $f12		# val
	la	$t0, k1			
	l.d	$f10, 0($t0)		# xn = 1.0
	l.d	$f6, 8($t0)		# 0.0
	l.d	$f8, 16($t0)		# 0.5
	li	$t1, 0			# i
if2:	c.le.d	$f2, $f6
	bc1t	else2
do:	mov.d	$f4, $f10		# aux
	div.d	$f10, $f2, $f10		# val/xn
	add.d	$f10, $f10, $f4		# xn + val/xn
	mul.d	$f10, $f8, $f10
	c.eq.d	$f4, $f10
	bc1t	endw
	addi	$t1, $t1, 1		# i++
	bge	$t1, 25, endw
	j	do
        
else2:	mov.d	$f10, $f6
endw:	mov.d	$f0, $f10
	jr	$ra
	
	
#############################################################################

stdev:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	jal	var
	mov.d	$f12, $f0
	jal	sqrt
	lw	$ra, 0($sp)
	addiu	$sp, $sp, -4
	jr	$ra
	
##############################################################################

	
	
	
	
	
	
	
	
