# g8_3 _

	.eqv print_str,4
	.eqv read_int,5
	
	.eqv max_str_size,33

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
###################################################################################
	.text
trocar:	lb $t0,0($a0)			# exchange
	lb $t1,0($a1)
	sb $t1,0($a0)
	sb $t0,0($a1)
	jr $ra
###################################################################################
# char toascii(char v)
# $a0 = v		# endereço ou valor? -> valor foda se deve ser 
	.text
toascii:	addiu $sp,$sp,-4
	sw $ra,0($sp)

	addi $a0,$a0,'0'		# v += '0';
	li $t0,'9'

if:	ble $a0,$t0,endif
	
	addi $a0,$a0,7		# v += 7; // 'A' - '9' - 1
endif:	move $v0,$a0		# return v;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
###################################################################################
# char *itoa(unsigned int n, unsigned int b, char *s)
# $a0 = unsigned int n
# $a1 = unsigned int b
# $a2 = char *s

# $s3 = char *p
# $s4 = digit
	.text
itoa:	addiu $sp,$sp,-28
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	sw $s5,24($sp)
	
	move $s0,$a0		# unsigned int n
	move $s1,$a1		# unsigned int b
	move $s2,$a2		# char *s
	move $s3,$s2		# char *p = s; 
	
do:	remu $s4,$s0,$s1		# unsigned	# digit = n % b; 
	divu $s0,$s0,$s1		# n = n / b; 
	move $a0,$s4		# digit
	jal toascii
	#move $s5,$v0		# *p = toascii(digit)
	sb $v0,0($s3)		# *p = toascii(digit)
	addi $s3,$s3,1		# p++
	
while:	bgt $s0,$0,do		# do { ... } while( n > 0 );
	
	li $t9,'\0'
	sb $t9,0($s3)		# *p = '\0'
	
	move $a0,$s2		# s
	jal strrev		# strrev(s)
	
	move $v0,$s2		# return s
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $s4,20($sp)
	lw $s5,24($sp)
	addiu $sp,$sp,28
	jr $ra
###################################################################################
# void print_int_ac1(unsigned int val, unsigned int base) 
	.text
print_int_ac1:
	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	# $a0 = val
	# $a1 = base
	la $a2,buf
	jal itoa
	move $a0,$v0		# itoa(val, base, buf); 
	li $v0,print_str
	syscall			# print_string( itoa(val, base, buf) );
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
###################################################################################
	.data
buf:	.space 33		# static char buf[33]; 		# print_int_ac1
str1:	.asciiz "Input value: "
str2:	.asciiz "Input base: "
str3:	.asciiz "Result in base "
	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $a0,str1
	li $v0,print_str
	syscall
	li $v0,read_int
	syscall
	move $s0,$v0		# value
	
	la $a0,str2
	li $v0,print_str
	syscall
	li $v0,read_int
	syscall
	move $s1,$v0		# base
	
	la $a0,str3
	li $v0,print_str
	syscall
	move $a0,$s1
	li $v0,1
	syscall
	li $a0,':'
	li $v0,11
	syscall
	li $a0,' '
	li $v0,11
	syscall
	
	move $a0,$s0
	move $a1,$s1
	jal print_int_ac1
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra











