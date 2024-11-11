# g7_2_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11

	.text
# void exchange(char *c1, char *c2)
exchange:
	lb $t0,0($a0)		# char* c1
	lb $t1,0($a1)		# char* c2
	move $t2,$t0		# aux = *c1
	sb $t1,0($a0)		# *c1 <- *c2
	sb $t2,0($a1)		# *c2 <- aux

	jr $ra
	
	
# char *strrev(char *str)
strrev:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s0,$a0		# char* p1
	move $s1,$a0		# char* p2
	move $s2,$a0		# &str
	
while:	lb $t0,0($s1)
	beq $t0,'\0',endw
	
	addiu $s1,$s1,1		# p2++
	
	j while
	
endw:	addiu $s1,$s1,-1		# p2--

while1:	bge $s0,$s1,endw1

	move $a0,$s0
	move $a1,$s1
	jal exchange
	addiu $s0,$s0,1		# p1++
	addiu $s1,$s1,-1		# p2--
	j while1
endw1:	
	move $v0,$s2		# return str
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	
	jr $ra
	

	
# main	
	.data
str:	.asciiz "raeniL arbeglA ama ailuJ A"
	
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	la $a0,str
	jal strrev
	move $a0,$v0
	li $v0,print_str
	syscall			# print(strrev(str));
	
	li $v0,0			# return 0;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
