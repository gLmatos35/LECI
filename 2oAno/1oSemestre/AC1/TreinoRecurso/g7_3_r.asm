# g7_3_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11

###	
	.text
# char *strcpy(char *dst, char *src)
strcpy:	move $t0,$a0
	move $t1,$a1

	li $t2,0			# i = 0
	
do4:	
	addu $t3,$t0,$t2		# &dst[i]
	addu $t4,$t1,$t2		# &src[i]
	
	lb $t5,0($t4)		# src [i]
	sb $t5,0($t3)		# dst [i] = src[i]
	
	addi $t2,$t2,1		# i++
	
while4:	bne $t5,'\0',do4

	move $v0,$t0		# return dst
	
	jr $ra	
###







	
		
###	
	.text	
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
###





###
	.text
strlen:	move $t0,$a0		# char* str

	li $t1,0			# len = 0	
while5:	lb $t2,0($t0)
	addi $t0,$t0,1		# *str++
	beq $t2,'\0',endw5
if5:	beq $t2,0x20,end5
	beq $t2,'\n',end5
	addi $t1,$t1,1		# len++
end5:
	j while5
endw5:	move $v0,$t1

	jr $ra
###


####
	.text
exchange:
	lb $t0,0($a0)			# exchange
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
####



# main
	.eqv max_size,30
	
	.data
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "String too long: "

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	la $a0,str1		# &str1
	jal strlen
	move $t0,$v0		# strlen(&str1)

if7:	bgt $t0,max_size,else8

	la $a0,str2
	la $a1,str1
	jal strcpy
	
	move $a0,$v0
	li $v0,print_str
	syscall

	li $a0,'\n'
	li $v0,print_char
	syscall
	
	la $a0,str2
	jal strrev
	move $a0,$v0
	li $v0,print_str
	syscall
	
	li $t1,0		# exit_value = -1
	
	j end7


else8:	la $a0,str3
	li $v0,print_str
	syscall
	la $a0,str3
	jal strlen
	move $a0,$v0
	li $v0,print_int
	syscall
	
	li $t1,-1	# exit_value = -1

end7:	move $v0,$t1

	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra






