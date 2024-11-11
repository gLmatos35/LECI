	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	
	.text
# Mapa de registos

# $t0 = res
# $t1 = *s
# $t2 = caracter
# $t3 = digit
atoi:	li 	$v0,0
while:	lb	$t0, 0($a0)
	blt	$t0, '0', ewhil
	bgt	$t0, '9', ewhil
	li	$t2, '0'
	sub	$t1, $t0, $t2
	addiu	$a0, $a0, 1
	mul	$v0, $v0, 10
	addu	$v0, $v0, $t1

	j	while
ewhil:	jr	$ra
####################################################################
	.data

str:	.asciiz	"2020 e 2024 sao anos bissextos"
	
	.text
	.globl main
	
main:	addiu	$sp, $sp , -4
	sw	$ra, 0($sp)
	la	$a0, str
	jal	atoi
	move	$a0, $v0
	li	$v0, print_int
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra

 	

	
	
