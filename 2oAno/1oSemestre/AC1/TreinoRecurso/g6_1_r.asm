# g6_1_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.eqv size,3
	
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
array:	.word str1, str2, str3

	.text
	.globl main
main:	li $t0,0
	la $s0,array
for:	bge $t0,size,endf

	sll $t1,$t0,2		# i*4
	addu $t2,$s0,$t1
	lw $a0,0($t2)
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall

	addi $t0,$t0,1		# i++
	j for
endf:
	jr $ra