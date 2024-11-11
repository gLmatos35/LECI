#g9_1
	.eqv print_float,2
	.eqv read_int,5
	
	.data
str1:	.asciiz "Input int (0 if u want to end): "
str2:	.asciiz " * 2.59375 = "
k1:	.float 2.59375
k2:	.float 0.0
	.text
	.globl main
main:	

do:	la $a0,str1
	li $v0,4
	syscall

	li $v0,read_int
	syscall			# read_int()
	move $t0,$v0		# val = read_int()
	
	move $a0,$t0
	li $v0,1
	syscall
	la $a0,str2
	li $v0,4
	syscall
	
	mtc1 $t0,$f0		# move $t0 to $f0 in coprocessor 1
	cvt.s.w $f0,$f0		# convert to single precision
	
	la $t1,k1
	l.s $f2,0($t1)		# $f2 = 2.59375
	
	mul.s $f2,$f0,$f2	# res = (float)val * 2.59375
	
	mov.s $f12,$f2		# $f12 <- res
	li $v0,print_float
	syscall			# print_float(res);
	
	la $t2,k2
	l.s $f4,0($t2)
	
	c.eq.s $f4,$f2
	bc1t end
	li $a0,'\n'
	li $v0,11
	syscall
	j do

end:	move $v0,$0
	jr $ra
	
	
	
	
	
	
	