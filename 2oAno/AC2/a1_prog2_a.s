	.eqv getChar,2
	.eqv putChar,3
	.eqv printInt,6

	.text
	.globl main
main:	li $t0,0

do:	li $v0,getChar
	syscall
	move $a0,$t1
	li $v0,putChar
	syscall

	addi $t0,$t0,1

	li $t1,'\n'
while:	bne $a0,$t1,do
	
	move $a0,$t0
	li $a1,10
	li $v0,printInt
	syscall

	li $v0,0
	jr $ra