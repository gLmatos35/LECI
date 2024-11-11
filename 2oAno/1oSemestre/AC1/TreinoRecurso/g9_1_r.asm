# g9_1_r
	.eqv print_int,1
	.eqv print_float,2
	.eqv print_double,3
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.data
const:	.float 2.59375
zero:	.float 0.0	
	
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
do:	li $v0,read_int
	syscall
	move $t0,$v0		# val
	
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0
	la $t0,const
	l.s $f2,0($t0)
	mul.s $f12,$f0,$f2
	li $v0,print_float
	syscall
	la $t0,zero
	l.s $f2,0($t0)
	
while:	c.eq.s $f12,$f2
	bc1f do

	li $v0,0
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra	
	
	
	
	
	