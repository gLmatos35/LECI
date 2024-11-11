	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	
	.text
	
exchange:
	lb 	$t0, 0($a0)
	lb 	$t1, 0($a1)
	sb 	$t1, 0($a0)
	sb 	$t0, 0($a1)
	jr 	$ra
	
strrev:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$s0, 12($sp)
	
	move	$s0, $a0
	move	$s1, $a0
	move	$s2, $a0
	
while:	lb	$t0, 0($s2)
	beq	$t0, $0, ewhile
	addi	$s2, $s2, 1
	j	while
ewhile:	addi	$s2, $s2, -1

while2:	bge	$s1, $s2, ewhil2
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange
	addi	$s1, $s1, 1
	addi	$s2, $s2, -1
	j	while2
ewhil2:	move	$v0, $s0
	lw	$ra, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s0, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra
	
	.data
str:	.asciiz	"ITED - orievA ed edadisrevinU"
	.text
	.globl main
	
main:	addiu $sp, $sp, 4
	sw $ra, 0($sp)
	la	$a0, str
	jal	strrev
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li $v0, 0
	lw $ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	

	