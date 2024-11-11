	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 33
	
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
##############################################################################
toascii:
	addi	$a0, $a0, '0'
if:	ble	$a0, '9', eif
	addi	$a0, $a0, 7
eif:	move	$v0, $a0
	jr	$ra
	
	
###############################################################################
# Mapa de registos

# $t0 = *s
# $t1 = digit
itoa:	addiu	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a2

	
	
do:	rem	$t0, $s0, $s1
	div	$s0, $s0, $s1
	move	$a0, $t0
	jal	toascii
	sb	$v0, 0($s2)
	addiu	$s2, $s2, 1
	bgt	$s0, 0, do
	sb	$0, 0($s2)
	move	$a0, $s3
	jal	strrev
	move	$v0, $s3

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	addiu	$sp, $sp, 20
	jr	$ra
	
##########################################################################

	.data
array:	.space	33

	.text
print_int_ac1:
	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	la	$a2, array
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addiu	$sp, $sp, 12
	jr	$ra
	
	
	
#######################################################
	.data
str1:	.asciiz	"Introduza um numero: "
str2:	.asciiz	"\nBase: "
	.text
	.globl main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$t0, $v0
	la	$a0, str2
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$a1, $v0
	move	$a0, $t0
	jal	print_int_ac1
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
	




	