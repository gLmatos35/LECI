# g9_add
	.eqv print_int, 1
	.eqv read_int, 5
	.eqv read_string, 8
	.eqv print_string, 4
	.eqv print_chr, 11
	.eqv print_float, 2
	.eqv print_double, 3
	.eqv read_float, 6
	.eqv read_double, 7
	.eqv true,1
	.eqv false,0
	.eqv SIZE,6

	.text
# double median(double *array, int nval)
median:	addi $sp,$sp,-4
	sw $s0,0($sp)
	
	move $s0,$a0		# double *array 

do:	li $t0,false		# houveTroca = false
	
	li $t1,0			# i = 0
	move $t2,$a1		# nval
	addi $t2,$t2,-1
for:	bge $t1,$t2,endf
	
	l.d $f0,0($s0)
	l.d $f2,8($s0)
if:	c.le.d $f0,$f2
	bc1t endif

	mov.d $f4,$f0
	mov.d $f0,$f2
	mov.d $f2,$f4
	li $t0,true

endif:	addi $s0,$s0,8		# s++
	addi $t1,$t1,1		# i++
	j for

endf:	
while:	beq $t0,true,do

	sll $a1,$a1,3
	div $a1,$a1,2
	addu $a0,$a0,$a1
	l.d $f0,0($a0)		# array[nval/2]
	
	lw $s0,0($sp)
	addi $sp,$sp,4
	jr $ra


	.data
	
array:	.double	5, 48, 1, 21, 37, 20
str1:	.asciiz	"A mediana �: "
str2:	.asciiz	"\nO array �: "
	.text
	.globl 	main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	la	$a0, array
	li	$a1, SIZE
	jal	median
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	la	$a0, str2
	li	$v0, print_string
	syscall
	li	$t0, 0
loop:	bge	$t0, SIZE, eloop
	la	$t2, array
	sll	$t1, $t0, 3
	addu	$t2, $t2, $t1
	l.d	$f12, 0($t2)
	li	$v0, print_double
	syscall
	li	$a0, ' '
	li	$v0, print_chr
	syscall
	addi	$t0, $t0, 1
	j 	loop
eloop:	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra









