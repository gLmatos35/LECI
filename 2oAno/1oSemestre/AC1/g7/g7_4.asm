# g7_4
	.eqv print_str,4
	.eqv print_char,11
# char *strcat(char *dst, char *src)
# $s0 = char *dst = p 	= $a0
# $s1 = char *src	= $a1
# $s2 = *p 
	.text
strcat:	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)#
	sw $s1,8($sp)#
	sw $s2,12($sp)#

	move $s0,$a0		# &dst
	move $s1,$a1		# &src
	lb $s2,0($a0)		# *p[0]
	
	move $s3,$s0
	
while:	beq $s2,$0,endw		# while(*p != '\0')
	
	addiu $s3,$s3,1		# p++
	lb $s2,0($s3)		# *p[i]
	j while
	
endw:	move $a0,$s3		# p
	move $a1,$s1		# src
	jal strcpy		# strcpy(p, src); 

	move $v0,$s0		# return dst
	
	lw $s0,4($sp)#
	lw $s1,8($sp)#
	lw $s2,12($sp)#
	lw $ra,0($sp)
	addiu $sp,$sp,16
	jr $ra
###################################################################################
	.text	
strcpy:				# strcpy
	# $a0 = char *dst
	# $a1 = char *src
	move $t0,$a0		# dst[i]
	move $t1,$a1		# src[i]
	li $t2,0			# i = 0		
	lb $t3,0($t1)		# *src[i]
do:	
	sb $t3,0($t0)		# store new char
	addu $t0,$a0,$t2	# dst[i++]
	addu $t1,$a1,$t2	# src[i++]
	addi $t2,$t2,1		# i++
	lb $t3,0($t1)		# *src[i++]
	bne $t3,$0,do
	
	jr $ra
#################################################################################
	.data
str1:	.asciiz "Vou tao "
str2:	.space 50
str3:	.asciiz "chumbar."
	.text
	.globl main
main:	addiu $sp,$sp,4
	sw $ra,0($sp)
	
	#la $s0,str1		# str1
	
	la $a0,str2		# str2
	la $a1,str1		# str1
	jal strcpy		# strcpy(str2, str1);
	
	la $a0,str2
	li $v0,print_str
	syscall			# print_string(str2);
	
	li $a0,'\n'
	li $v0,print_char
	syscall			# print_char("\n")
	
	la $a0,str2
	la $a1,str3
	jal strcat
	
	move $a0,$v0
	li $v0,print_str
	syscall			# print_string( strcat(str2, "Computadores I") );
	
	move $v0,$0		# return 0
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	