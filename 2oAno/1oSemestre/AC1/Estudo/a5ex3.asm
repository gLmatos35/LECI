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
str1:	.asciiz "Insira um número: "
	.text
	.globl main

#Mapa de registos:
# $t0 = array
# $t1 = j
# $t2 = SIZE
# $t3 = houveTroca
# $t4 = i
# $t5 = SIZE - 1
# $t6 = posição atual do array
# $t7 = lista[i]
# $t8 = lista[i+1]


main:	la	$t0, array
	li	$t1, 0
	li	$t2, SIZE
for:	bge	$t1, $t2, do
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t0)
	addi	$t1, $t1, 1
	addi	$t0, $t0, 4
	j 	for
	
do:	la	$t0, array
	li	$t3, FALSE
	li	$t4, 0
	addi	$t5, $t2, -1
for2:	bge	$t4, $t5, edo

if:	sll	$t6, $t4, 2
	addu	$t6, $t6, $t0				# posição inicial do array
	lw	$t7, 0($t6)				# lista[i]
	lw	$t8, 4($t6)				# lista[i+1]
	ble	$t7, $t8, eif
	sw	$t8, 0($t6)
	sw	$t7, 4($t6)
	li	$t3, TRUE
	addi	$t4, $t4,1
	j	for2
eif:	addi	$t4, $t4,1
	j 	for2
edo:	beq 	$t3, 1, do
#	A partir daqui ignorem o mapa de registos
imprime:
	la	$t0, array
	li	$t1, SIZE
	sll	$t2, $t1, 2
	addu	$t3, $t2, $t0
for3:	bge	$t0, $t3, efor
	lw	$a0, 0($t0)
	li	$v0, print_int
	syscall
	li	$a0, ';'
	li	$v0, print_chr
	syscall
	addi	$t0, $t0, 4
	j 	for3
efor:	jr	$ra
	
	

	
	
	
	
