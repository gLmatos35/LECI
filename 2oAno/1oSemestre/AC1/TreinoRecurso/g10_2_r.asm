# g10_2
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
k1:	.double 1.0
k2:	.double 0.0
k3:	.double 0.5
	
# double sqrt(double val)
	.text
sqrt:	mov.d $f2,$f12		# double val
	
	la $t9,k1
	l.d $f4,0($t9)		# xn = 1.0
	
	li $t0,0			# i = 0
	
	la $t9,k2
	l.d $f6,0($t9)		# 0.0
	
if:	c.le.d $f2,$f6
	bc1t else

do:	mov.d $f8,$f4		# aux = xn
	div.d $f4,$f2,$f4	# val/xn
	add.d $f4,$f4,$f8	# xn + val/xn
	la $t9,k3
	l.d $f10,0($t9)		# 0.5
	mul.d $f4,$f4,$f10	# 0.5 * (xn + val/xn)
	
while:	c.eq.d $f8,$f4
	bc1f check
	j endif
check:	addi $t0,$t0,1		# i++
	blt $t0,25,do
	j endif
	
else:	mov.d $f4,$f6
	
endif:	mov.d $f0,$f4	
	
	jr $ra
	
	
	
	.data
str1:	.asciiz	"Introduza um valor: "
str2:	.asciiz	"A raiz quadrada é: "

	.text
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
				
					
						
							

	
		
			
				