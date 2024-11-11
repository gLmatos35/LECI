	.eqv 	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 3
	
	.data
str1:	.asciiz "Rafael"
str2:	.asciiz	"Carvalho"
str3:	.asciiz	"Dias"
array:	.word str1, str2, str3

	.text
	.globl main
	
main:	li	$t0, 0
	li	$t1, SIZE
for:	bge	$t0, $t1, efor
	la	$t1, array
	sll	$t2, $t0, 2
	addu	$t2, $t2, $t1
	lw	$a0, 0($t2)
	li	$v0, print_string
	syscall
	li $a0, '\n'
	li $v0, print_chr
	syscall
	addi	$t0, $t0, 1
	j	for
	
efor:	jr	$ra