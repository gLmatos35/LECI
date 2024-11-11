#g9_2

	.eqv print_double,3
	.eqv read_double,7
	.eqv print_str,4
	
	.data
k1:	.double 5.0
k2:	.double 9.0
k3:	.double 32.0

str1:	.asciiz "Input temperature (ºF): "
str2:	.asciiz "\nConversion to Celcius: "
	
	.text
# double f2c(double ft)
f2c:	la $t0,k1
	l.d $f2,0($t0)		# 5.0
	l.d $f4,8($t0)		# 9.0
	l.d $f6,16($t0)		# 32.0
	# double ft vem no $f12 e volta para a que a chamou no $f0
	sub.d $f0,$f12,$f6	# ft - 32.0
	div.d $f2,$f2,$f4	# 5.0 / 9.0
	mul.d $f0,$f0,$f2	# 5.0 / 9.0 * (ft - 32.0)
	
	jr $ra
	
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	la $a0,str1
	li $v0,print_str
	syscall			# print_str(str1)
	
	li $v0,read_double
	syscall
	mov.d $f12,$f0
	
	la $a0,str2
	li $v0,print_str
	syscall
	
	jal f2c
	mov.d $f12,$f0
	li $v0,print_double
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	
	
	
	
	
	
	
	