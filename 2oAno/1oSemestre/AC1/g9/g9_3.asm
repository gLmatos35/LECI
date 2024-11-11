# g9_3
	.eqv size,4
	.eqv read_int,5
	.eqv print_double,3
	.eqv read_double,7
	.eqv print_str,4

	.data
k1:	.double 0.0

	.text
# double average(double *array, int n)
# $a0 = double *array 		***** é um PONTEIRO para um double
# $a1 = int n
average:	move $t0,$a0		# end base para array
	move $t1,$a1		# int i = n
	la $t2,k1		
	l.d $f0,0($t2)		# double sum = 0.0
	
	addi $t1,$t1,-1		# i-1
		
for_av:	blt $t1,$0,endf_av	# blt porque ja estamos a fazer com i-1
	
	move $t2,$t1		# $t2 = i
	sll $t2,$t2,3		# i*3
	addu $t3,$t0,$t2		# $t3 = array + (i-1)*8
	l.d $f2,0($t3)		# array[i-1]
	add.d $f0,$f0,$f2
	
	addi $t1,$t1,-1
	j for_av

endf_av:
	mtc1 $a1,$f4
	cvt.d.w $f4,$f4
	div.d $f0,$f0,$f4
	jr $ra
	
	.data
	.align 3
array:	.space 32
str1:	.asciiz "\nIntroduza um valor: "
str2:	.asciiz "\nValor da media: "

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,array
	
	li $t1,0			# i = 0

for:	bge $t1,size,endf
	
	la $a0,str1
	li $v0,print_str
	syscall
	
	li $v0,read_int
	syscall
	move	$t5, $v0
	move	$a0, $v0
	li	$v0, 1
	syscall
	mtc1 $t5,$f0
	cvt.d.w $f0,$f0		# double(read_int())
	
	s.d $f0,0($t0)
	addi $t0,$t0,8		# array + 8
	
	addi $t1,$t1,1
	j for
endf:	la $a0,array
	li $a1,size
	jal average
	mov.d $f12,$f0
	li $v0,print_double
	syscall
	
	move $v0,$0		# return 0

	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	








