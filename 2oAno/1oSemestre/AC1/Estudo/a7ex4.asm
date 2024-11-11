	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11


	.text
strcpy:
	move	$v0, $a0
	
do:	lb	$t1, 0($a1)
	sb	$t1, 0($a0)
	addiu	$a1, $a1, 1
	addiu	$a0, $a0, 1
	bne	$t1, $0, do
edo:	jr	$ra

################################################
	.text
strcat:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)	
	move	$s0, $a0
	move	$s1, $a1
whi:	lb	$s2, 0($s0)
	beq	$s2, $0, ewhi
	addi	$s0, $s0, 1
	j	whi
ewhi:	move	$a0, $s0
	move	$a1, $s1
	jal	strcpy
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	addiu	$sp, $sp, 16	
	jr	$ra
	
#####################################################

	.data
str1:	.asciiz "guwui "
str2:	.asciiz "é gay!"
str3:	.asciiz "\n"
str4:	.space	51

	.text
	.globl main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a1, str1
	la	$a0, str4
	jal	strcpy
	move	$t0, $v0
	move	$a0, $v0
	li	$v0, print_string
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	la	$a1, str2
	move	$a0, $t0
	jal	strcat
	la	$a0, str4
	li	$v0, print_string
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra	
	
	
	
	
	
	
	
