	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	
	.text
	
strlen:	move	$t0, $a0
	li	$t1, 0
while:	lb	$t2, 0($t0)
	beq	$t2, $0, ewhile
	addi	$t1, $t1, 1
	addi	$t0, $t0, 1
	j	while
ewhile:	move	$v0, $t1
	jr	$ra
	
	
	
	.data
	
str1:	.asciiz	"Rafael Carvalho Dias"

	.text
	.globl main
	
main:	la	$a0, str1
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	jal	strlen
	
	move	$a0, $v0
	li	$v0, print_int
	syscall
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
