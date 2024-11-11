# g10_1_r
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
k1:	.float 1.0

	.text
# float xtoy(float x, int y)
xtoy:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)

	mov.s $f2,$f12		# float x
	move $s0,$a0		# int y
	
	li $s1,0			# i = 0
	la $t0,k1
	l.s $f4,0($t0)		# result = 1.0

	move $a0,$s0
	jal abs
	move $s2,$v0		# abs(y)

for:	bge $s1,$s2,endf

if:	ble $s0,$0,else
	
	mul.s $f4,$f4,$f2	# result *= x	
	j endif
	
else:	div.s $f4,$f4,$f2	# result /= x
endif:	
	addi $s1,$s1,1
	j for

endf:	mov.s $f0,$f4		# return result	
				
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)				
	addiu $sp,$sp,16																							
																										
	jr $ra
##

														
####
	.text
# int abs(int val)
abs:	move $t0,$a0		# val

if2:	bge $t0,$0,endif2
	sub $t0,$0,$t0		# val = -val

endif2:	move $v0,$t0		# return val

	jr $ra
	
##
	.data
str1:	.asciiz	"Indique a base: "
str2:	.asciiz	"\nIndique o expoente: "
str3:	.asciiz	"\nResultado: "
	.text
	.globl	main

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