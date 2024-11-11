# g8_1
#
# unsigned int atoi(char *s) 
# $t0 = res
# $a0 = char *s		-> ponteiro para a string
# t1 = *s
# t2 = digit
	
	.eqv print_int,1
	
	.text
atoi:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	li $t0,0			# res = 0

while:	lb $t1,0($a0)		# *s
	blt $t1,'0',endw
	bgt $t1,'9',endw

	li $t9,'0'
	subu $t2,$t1,$t9		# digit		# sub / subu ?
	mul $t0,$t0,10		# res*10
	addu $t0,$t0,$t2	# res = 10*res + digit
	
	addiu $a0,$a0,1		# s++
	j while
	
endw:	move $v0,$t0
	
	sw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
####################################################################################	
	.data
str1:	.asciiz "2020 e 2024 sao anos bissextos"	

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str1
	jal atoi
	move $a0,$v0		# atoi(str)
	li $v0,print_int
	syscall			# print_int(atoi(str));
	
	move $v0,$0		# return 0;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra













