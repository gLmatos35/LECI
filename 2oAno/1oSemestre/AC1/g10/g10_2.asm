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

	.text
# double sqrt(double val)
# $f12 = double val
squirtle:
	la $t0,k1
	l.d $f2,0($t0)	# xn = 1.0
	li $t0,0		# i = 0
	mov.d $f4,$f12	# $f4 = double val
	
	la $t1,k2
	l.d $f6,0($t1)	# 0.0
	
if:	c.le.d $f4,$f6
	bc1t else
	
do:	mov.d $f8,$f2	# aux = xn
	la $t1,k3
	l.d $f10,0($t1)	# 0.5
	div.d $f2,$f4,$f8	# val/xn
	add.d $f2,$f8,$f2	# xn + val/xn
	mul.d $f2,$f10,$f2	# 0.5 * (xn + val/xn)

while:	c.eq.d $f8,$f2
	bc1f check
	j endif
check:	addi $t0,$t0,1		# ++i
	li $t2,25
	blt $t0,$t2,do
	j endif

else:	mov.d $f2,$f6
		
endif:	mov.d $f0,$f2
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
	jal	squirtle
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
				
					
						
							

	
		
			
					