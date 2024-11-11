# g7_1
	.eqv print_int,1
	.eqv print_str,4
	
	.data
str1:	.asciiz "Lenght of the word: "
str2:	.asciiz "Joao"
# strlen
# $t0 = len
# $t1 = $a0 = ponteiro para inicio da str
#strlen(char *s)		# ponteiro para o inicio da string
# = $a0
	.text
strlen:	li $t0,0		# len = 0
	
	move $t1,$a0
	
while:	lb $t2,0($t1)	# *s (char)
	addiu $t1,$t1,1	# s++
	
	beq $t2,$0,endw
	
	addi $t0,$t0,1	# len++
	
	j while
endw:	move $v0,$t0	# return len
	jr $ra		# jump return
	
	.text
	.globl main
main:	addiu $sp,$sp,-4
       	sw $ra,0($sp)
       	
	la $a0,str1
	li $v0,print_str
	syscall			# print_str("Lenght of the word: ");
	
	la $a0,str2
	jal strlen
	
	move $a0,$v0
	li $v0,print_int
	syscall			# print_int(len);
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	










