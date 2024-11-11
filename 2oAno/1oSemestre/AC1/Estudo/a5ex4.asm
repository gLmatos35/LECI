	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 5
	.eqv	TRUE, 1
	.eqv	FALSE, 0
	
	.data
array:	.space	20
str1:	.asciiz "Insira um n�mero: "
	.text
	.globl main
	
# Mapa de registos
# $t0 = j
# $t1 = array
# $t2 = SIZE
# $t3 = houveTroca
# $t4 = ultimo
	
main:	li	$t0, 0
	la	$t1, array
	li	$t2, SIZE
	sll	$t4, $t2, 2
	addi	$t4, $t4, -4
	addu	$t4, $t1, $t4

for:	bge	$t0, $t2, do
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t1)
	addi	$t0, $t0, 1
	addi	$t1, $t1, 4
	j for
	
do:	la	$t1, array
	li	$t3, 0
for2:	bge 	$t1, $t4, ewhile
	lw	$t5, 0($t1)
	lw	$t6, 4($t1)
if:	ble	$t5, $t6, eif
	sw	$t6, 0($t1)
	sw	$t5, 4($t1)
	li	$t3, 1
	addi	$t1, $t1, 4
	j	for2
eif:	addi	$t1, $t1, 4
	j	for2

	
	
ewhile:	beq	$t3, 1, do
	li	$t0, 0
	la	$t1, array	
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
	

	
	
	
	
	
	
	