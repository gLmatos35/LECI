	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.text
# Mapa de registos

# $t0 = dividendo
# $t1 = divisor
# $t2 = i
# $t3 = bit
divis:	sll	$t1, $a1, 16
	andi	$t0, $a0, 0xffff
	sll	$t0, $t0, 1
	li	$t2, 0
for:	bge	$t2, 16, efor
	li	$t3, 0
if:	blt	$t0, $t1, eif
	sub	$t0, $t0, $t1
	li	$t3, 1
eif:	sll	$t0, $t0, 1
	or	$t0, $t0, $t3
	addi	$t2, $t2, 1
	j	for
	
efor:	srl	$t4, $t0, 1
	lui	$t5, 0xffff
	ori	$t5, $t5, 0x0000
	and	$t5, $t5, $t4
	andi	$t6, $t0, 0xffff
	or	$v0, $t5, $t6
	
	jr	$ra
	
	.data
	
str1:	.asciiz	"Introduza um dividendo: "
str2:	.asciiz	"Indroduza um divisor: "
str3:	.asciiz	"Resultado: "
str4:	.asciiz	"\nResto: "
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
	jal	divis
	move	$t0, $v0
	move	$t1, $v0
	srl	$t0, $t0, 16
	andi	$t1, $t1, 0xffff
	la	$a0, str3
	li	$v0, print_string
	syscall
	move	$a0, $t1 
	li	$v0, print_int
	syscall
	la	$a0, str4
	li	$v0, print_string
	syscall
	move	$a0, $t0 
	li	$v0, print_int
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
