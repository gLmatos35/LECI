# g10_3
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
k1:	.double 1.0
k2:	.double 0.0
k3:	.double 0.5

	.text
# double sqrt(double val)
# $f12 = double val
sqrt:	
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
#############################################

	.data
k4:	.float 1.0
	
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
	la $t1,k4
	l.s $f4,0($t1)	# $f2 = result = 1.0
	
	move $a0,$s1	
	jal abs		# $v0 = abs(y)
	
for4:	bge $t0,$v0,endf4

if4:	ble $s1,$0,else4
	mul.s $f4,$f4,$f2
	j endif4

else4:	div.s $f4,$f4,$f2

endif4:	
	addi $t0,$t0,1
	j for4
endf4:	
	mov.s $f0,$f4		# return result
	
	lw $s0,4($sp)
	lw $s1,12($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,16
	jr $ra
	
########################################################
	
# int abs(int val)
# $a0 = int val
abs:	move $v0,$a0
if2:	bge $v0,$0,endif2
	sub $v0,$0,$v0
endif2:	jr $ra
###############################################3
	
	.text
#double var(double *array, int nval)
# $a0 = double *array
# $a1 = int nval
var:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s0,$a0		# double *array
	move $s2,$s1		# copia de $s0, ou seja de $a0
	move $s1,$a1		# nval
	
	jal average
	cvt.s.d $f0,$f0		# double -> float   
				# media =(float)average(...)
	mov.s $f6,$f0		# media
	
	li $t0,0		# i = 0
	la $t1,k2
	l.d $f2,0($t1)	# soma = 0.0
for3:	bge $t0,$s1,endf3		# for(i=0, soma=0.0; i < nval; i++) 
	
	l.d $f4,0($s2)	# array[i]
	addiu $s2,$s2,8	# i++ (double)
	cvt.s.d $f4,$f4	# (float)array[i]
	
	sub.s $f12,$f4,$f6	# (float)array[i] - media
	li $a0,2			# 2	
	jal xtoy		 	# xtoy((float)array[i] - media, 2);
	add.s $f2,$f2,$f0	# soma += ^
	
	addi $t0,$t0,1	# i++
	j for3

endf3:	cvt.d.s $f0,$f2		# (double)soma

	mtc1 $s1,$f4	
	cvt.d.w $f2,$f4		# (double)nval

	div.d $f0,$f0,$f2	# return (double)soma / (double)nval;
	
	lw $s2,12($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,16
	jr $ra

#######################################
	.text
# double stdev(double *array, int nval) 
# $a0 = double *array
# $a1 = int nval
stdev:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	jal var
	# $f0 = var(array,nval)
	jal sqrt
	# $f0 = sqrt(var(array,nval))
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra

#######################################
	.data
k5:	.double 0.0

	.text
# double average(double *array, int n)
# $a0 = double *array 		***** é um PONTEIRO para um double
# $a1 = int n
average:	move $t0,$a0		# end base para array
	move $t1,$a1		# int i = n
	la $t2,k5		
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
#####################################

	.data
str1:	.asciiz	"\nIntroduza um valor: "
str2:	.asciiz	"Média: "
str3:	.asciiz	"\nVar: "
str4:	.asciiz	"\nStdev: "
array:	.space	40

	.text
	.globl main
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








