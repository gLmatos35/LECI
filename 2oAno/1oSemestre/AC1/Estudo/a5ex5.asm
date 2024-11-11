	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 5
	
	.data
array:	.space	20
str1:	.asciiz "Insira um n�mero: "
	.text
	.globl main
	
main:	li	$t0, 0
	la	$t1, array
	li	$t2, SIZE

for:	bge	$t0, $t2, efor
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t1)
	addi	$t0, $t0, 1
	addi	$t1, $t1, 4
	j for
efor:	li	$t0, 0

for2:	la	$t1, array
	sll	$t9, $t0, 2
	addu	$t1, $t1, $t9
	move	$t8, $t1
	addi	$t3, $t2, -1
	lw	$t5, 0($t1)
	addi	$t4, $t0, 1
	bge	$t0, $t3, efor2
for3:	bge	$t4, $t2, efor3
	lw	$t6, 4($t1)
if:	ble	$t5, $t6, eif
	sw	$t6, 0($t8)
	sw	$t5, 4($t1)
	addi	$t4, $t4, 1
	addi	$t1, $t1, 4
	lw	$t5, 0($t8)
	j for3
eif:	addi	$t4, $t4, 1
	addi	$t1, $t1, 4
	j for3
	
efor3:	addi	$t0, $t0, 1
	j 	for2
	
	
	
	
	
	
efor2:	la	$t1, array
	li	$t0, 0
	
loop:	
	bge	$t0, $t2, endloop
	lw	$a0, 0($t1)
	li	$v0, print_int
	syscall
	li	$a0, '-'
	li	$v0, print_chr
	syscall
	addi	$t0, $t0, 1
	addi	$t1, $t1, 4
	j	loop
endloop:
	jr	$ra