# g10_1
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
# $f12 = float x
# $a0 = int y
xtoy:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,12($sp)
	
	mov.s $f2,$f12	# float x
	move $s1,$a0	# int y
		
	li $t0,0		# i = 0
	la $t1,k1
	l.s $f4,0($t1)	# $f4 = result = 1.0
	
	move $a0,$s1	
	jal abs		# $v0 = abs(y)
	
for:	bge $t0,$v0,endf

if:	ble $s1,$0,else
	mul.s $f4,$f4,$f2
	j endif

else:	div.s $f4,$f4,$f2

endif:	
	addi $t0,$t0,1
	j for
endf:	
	mov.s $f0,$f4		# return result
	
	lw $s0,4($sp)
	lw $s1,12($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,16
	jr $ra
	
#####	
	
# int abs(int val)
# $a0 = int val
abs:	move $v0,$a0
if2:	bge $v0,$0,endif2
	sub $v0,$0,$v0
endif2:	jr $ra



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










