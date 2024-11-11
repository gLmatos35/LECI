# g7_2 _

	.eqv print_str,4
	
	.text
trocar:	lb $t0,0($a0)
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
	
	.text
# $s0 = str = $a0
# $s1 = p1
# $s2 = p2
reversordecus:
	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	
	move $s0,$a0		# *str		ponteiro para a string
	move $s1,$a0		# p1
	move $s2,$a0		# p2
	
enquanto:
	lb $t0,0($s2)		# char *p2
	beq $t0,$0,endEnquanto	# while(*p2 != '\0')
	
	addiu $s2,$s2,1		# p2++
	j enquanto
endEnquanto:
	addi $s2,$s2,-1		# p2--
	
пока:	bge $s1,$s2,конец	# while( p1 < p2 ) 
	
	move $a0,$s1
	move $a1,$s2
	jal trocar		# exchange(p1, p2); 
	addiu $s1,$s1,1		# p1++;
	addiu $s2,$s2,-1		# p2--;
	j пока
конец:	
	move $v0,$s0		# ponteiro da strrev
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addiu $sp,$sp,16
	jr $ra

	.data
str:	.asciiz "oaoj od uc o maremoC"
str1:	.asciiz "String original: "
str2:	.asciiz "\nString invertida: "

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	la $a0,str1
	li $v0,print_str
	syscall
	la $a0,str
	li $v0,print_str
	syscall
	la $a0,str2
	li $v0,print_str
	syscall
	
	la $a0,str
	jal reversordecus		# strrev(str)
	
	move $a0,$v0
	li $v0,print_str
	syscall
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	
	
	
	
	
