	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 3
	
	.data
	
str1:	.asciiz "Rafael\n"
str2:	.asciiz "Carvalho\n"
str3:	.asciiz "Dias\n"
array:	.word	str1, str2, str3

	.text
	.globl main
	
# Mapa de registos

# $t0 = p
# $t1 = pultimo
main:	la	$t0, array
	li	$t1, SIZE
	sll	$t1, $t1, 2
	addu	$t1, $t1, $t0
	
for:	bge	$t0, $t1, efor
	lw	$a0, 0($t0)
	li	$v0, print_string
	syscall
	addi	$t0, $t0, 4
	j	for
	
efor:	jr	$ra
		
	
	
	
	
	
	