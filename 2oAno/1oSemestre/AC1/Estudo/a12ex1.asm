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
	.eqv	SIZE, 2
	
	
	.eqv	fname, 4
	.eqv	lname, 22
	.eqv	grade, 40

	.data
	.align	2
array:	.space	132
media:	.float
zero:	.float	0.0
str1: 	.asciiz	"\nNmec: "
str2:	.asciiz	"Primeiro nome: "
str3:	.asciiz	"Último nome: "
str4:	.asciiz	"Nota: "
str5:	.asciiz	"\nMédia: "

max_grade:	
	.float -1

	.text
	
read_data:
	move	$t0, $a0
	move	$t1, $a1
	li	$t2, 0				#i i=0
	li	$t3, 44
loop:	mulu	$t4, $t3, $t2
	addu	$t4, $t4, $t0			# $t4 = student atual
	bge	$t2, $t1, eloop			
	la	$a0, str1			
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t4)
	
	la	$a0, str2
	li	$v0, print_string
	syscall
	
	addi	$a0, $t4, fname
	li	$a1, 17
	li	$v0, read_string
	syscall
	
	la	$a0, str3
	li	$v0, print_string
	syscall
	addi	$a0, $t4, lname
	li	$a1, 14
	li	$v0, read_string
	syscall
	
	la	$a0, str4			
	li	$v0, print_string
	syscall
	li	$v0, read_float
	syscall
	s.s	$f0, grade($t4)
	
	addi	$t2, $t2, 1			# i++
	j	loop
	
	
eloop:
	jr	$ra
##################################################################################

max:	move	$t0, $a0			# $t0 = st = p
	move	$t1, $a1			# $t1 = ns
	move	$t2, $a2			# $t2 = media
	la	$t3, zero
	l.s	$f2, 0($t3)			# $f2 = 0.0 = sum
	la	$t3, max_grade
	l.s	$f4, 0($t3)			# $f4 = -1.0 = max_grade
	li	$t4, 44				# tamanho de estudande = $t4
	mul	$t5, $t4, $t1			# 44*ns
	addu	$t5, $t5, $t0			# st + ns
	
for2:	bge	$t0, $t5, efor2
	l.s	$f6, grade($t0)
	add.s	$f2, $f2, $f6
if:	c.le.s	$f6, $f4
	bc1t	eif
	mov.s	$f4, $f6			# max_grade = p->grade
	move	$t6, $t0			# pmax = p
	addu	$t0, $t0, $t4
	j	for2
eif:	addu	$t0, $t0, $t4
	j	for2	
efor2:	mtc1	$t1, $f8
	cvt.s.w	$f8, $f8
	div.s	$f10, $f2, $f8
	s.s	$f10, 0($t2)
	move	$v0, $t6
	jr	$ra
	
#################################################################################

print_student:
	move	$t0, $a0
	lw	$a0, 0($t0)
	li	$v0, print_intu10
	syscall
	
	li	$a0, '\n'
	li	$v0, print_chr
	syscall
	
	addi	$a0, $t0, fname
	li	$v0, print_string
	syscall
	
	li	$a0, '\n'
	li	$v0, print_chr
	syscall
	
	addi	$a0, $t0, lname
	li	$v0, print_string
	syscall
	
	li	$a0, '\n'
	li	$v0, print_chr
	syscall
	
	l.s	$f12, grade($t0)
	li	$v0, print_float
	syscall
	
	jr	$ra
#################################################################################
	.text
	.globl	main
	 
main:	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	
	la	$a0, array
	li	$a1, SIZE
	jal	read_data
	la	$a0, array
	li	$a1, SIZE
	la	$a2, media
	jal	max
	move	$s0, $v0
	la	$a0, str5
	li	$v0, print_string
	syscall
	la	$t1, media
	l.s	$f12, 0($t1)
	li	$v0, print_float
	syscall
	move	$a0, $s0
	jal	print_student
	li	$v0, 0
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addiu	$sp, $sp, 8
	jr	$ra
	
	

	
	