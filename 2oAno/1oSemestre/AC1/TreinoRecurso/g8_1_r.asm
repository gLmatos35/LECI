# g8_1_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.text
# unsigned int atoi(char *s)
atoi:	move $t0,$a0	# &s
	
	li $t1,0		# res = 0

while:	lb $t2,0($t0)
	blt $t2,'0',endw
	bgt $t2,'9',endw
	
	li $t9,'0'
	sub $t3,$t2,$t9		# digit
	mul $t4,$t1,10
	addu $t1,$t4,$t3		# res = 10 * res + digit
	
	addi $t0,$t0,1
	j while
endw:
	move $v0,$t1	# return res
	jr $ra

	
###
	.data
str:	.asciiz "2020 e 2024 sao anos bissextos"

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	la $a0,str
	jal atoi
	
	move $a0,$v0
	li $v0,print_int
	syscall
	
	li $v0,0
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	
	jr $ra












