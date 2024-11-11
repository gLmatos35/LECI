# g8_1_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.text
# char *itoa(unsigned int n, unsigned int b, char *s)
itoa:	addiu $sp,$sp,-24
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	
	move $s0,$a0		# n
	move $s1,$a1		# b
	move $s2,$a2		# &s
	move $s3,$s2		# char *p = s
	
do12:	remu $s4,$s0,$s1		# digit = n % b
	divu $s0,$s0,$s1
	
	move $a0,$s4
	jal toascii
	sb $v0,0($s3)		# *p = toascii(digit)
	addi $s3,$s3,1		# *p++
	
while12:	bgt $s0,$0,do12

end12:	li $t0,'\0'
	sb $t0,0($s3)
	move $a0,$s2
	jal strrev
	
	# $v0 ja tem s
	
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,4
	
	jr $ra
###
	.text
strrev:				# strrev
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

###		
	
	.text
trocar:	lb $t0,0($a0)			# exchange
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
###

# char toascii(char v)
toascii:	
	move $t0,$a0	# char v
	li $t1,'0'
	addu $t0,$t0,$t1
	
se:	ble $t0,'9',endse
	
	addi $t0,$t0,7
	
endse:	move $v0,$t0	# return v

	jr $ra
##
	.eqv max_size,33
	
###################################################################################
	.data
str:	.space max_size		# static char str[MAX_STR_SIZE];
str1:	.asciiz "Input a number: "
str2:	.asciiz "Binary: "
str3:	.asciiz "\nOctal: "
str4:	.asciiz "\nHexadecimal: "
kys:	.asciiz "\nkys."
	.text
	.globl main
# $s0 = val
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str1
	li $v0,print_str
	syscall	
	li $v0,read_int
	syscall			
	move $s0,$v0		# val = read_int();
	
do1:	la $a0,str2
	li $v0,print_str
	syscall	
	move $a0,$s0
	li $a1,2
	la $a2,str
	jal itoa
	move $a0,$v0
	li $v0,print_str
	syscall			# print_string( itoa(val, 2, str) );
	
	la $a0,str3
	li $v0,print_str
	syscall	
	move $a0,$s0
	li $a1,8
	la $a2,str
	jal itoa
	move $a0,$v0
	li $v0,print_str
	syscall			# print_string( itoa(val, 8, str) );
	
	la $a0,str4
	li $v0,print_str
	syscall	
	move $a0,$s0
	li $a1,16
	la $a2,str
	jal itoa
	move $a0,$v0
	li $v0,print_str
	syscall			# print_string( itoa(val, 16, str) );
	
	li $a0,'\n'
	li $v0,11
	syscall
	la $a0,str1
	li $v0,print_str
	syscall	
	li $v0,read_int
	syscall			
	move $s0,$v0		# val = read_int();

while1:	bne $s0,$0,do1		# do { ... } while(val != 0);

	la $a0,kys
	li $v0,print_str
	syscall

	move $v0,$0		# return 0;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra

	
	
	
	
	