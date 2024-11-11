# g7_3
	.eqv maxSize,30
	.eqv maxSizeMais1,31
	
	.eqv print_int,1
	.eqv print_str,4
	.eqv print_char,11
### funções anteriores ############################################################
	.text
tamanhoDaMinhaP:				# strlen
	li $t0,0		# len = 0
	
	move $t1,$a0
	
uaile:	lb $t2,0($t1)	# *s (char)
	addiu $t1,$t1,1	# s++
	
	beq $t2,$0,enduai
	
	addi $t0,$t0,1	# len++
	
	j uaile
enduai:	move $v0,$t0	# return len
	jr $ra		# jump return
###################################################################################
	.text
reversordecus:			# strrev
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
###################################################################################
	.text
trocar:	lb $t0,0($a0)			# exchange
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
###################################################################################
	.text	
sharingan:				# strcpy
	# $a0 = char *dst
	# $a1 = char *src
	move $t0,$a0		# dst[i]
	move $t1,$a1		# src[i]
	li $t2,0			# i = 0		
	lb $t3,0($t1)		# *src[i]
justDoIt:	
	sb $t3,0($t0)		# store new char
	addu $t0,$a0,$t2	# dst[i++]
	addu $t1,$a1,$t2	# src[i++]
	addi $t2,$t2,1		# i++
	lb $t3,0($t1)		# *src[i++]
	bne $t3,$0,justDoIt
	
	jr $ra
##################################################################################	
	.data
str1:	.asciiz "oaoj od uc o maremoC"	# static char str1[]="oaoj od uc o maremoC";
str2:	.space maxSizeMais1		# static char str2[STR_MAX_SIZE + 1]; 
str3:	.asciiz "String too long: "
	
	.text
	.globl main
# $s0 = strlen(str1)
# $s1 = exit_value
main:	addi $sp,$sp,-8
	sw $ra,0($sp)

	la $a0,str1
	jal tamanhoDaMinhaP
	move $s0,$v0		# strlen(str1)
	sw $s0,4($sp)		# store

if:	bgt $s0,maxSize,else
	la $a0,str2
	la $a1,str1
	jal sharingan		# strcpy(str2,str1)
	la $a0,str2
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall			# print_char("\n");
	
	la $a0,str2
	jal reversordecus
	move $a0,$v0		# ponteiro para strrev(str2)
	li $v0,print_str
	syscall			# print_string(strrev(str2));
	li $s1,0			# exit_value = 0;
	j endif
	
else:	la $a0,str3
	li $v0,print_str
	syscall			# print_string("String too long: ");
	lw $s0,4($sp)		# garantir que ta safe
	move $a0,$s0
	li $v0,print_int
	syscall			# print_int10(strlen(str1));
	li $s1,-1		# exit_value = -1; 
	
endif:	
	move $v0,$s1		# return exit_value;
	lw $ra,0($sp)
	addi $sp,$sp,8


	




