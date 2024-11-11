# g6_3_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.eqv size,3
	
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
array:	.word str1, str2, str3

string:	.asciiz "\nString #"
dp:	.asciiz ": "

	.text
	.globl main
main:	li $t0,0			# i = 0
	la $s0,array
	
for:	bge $t0,size,endf

	la $a0,string
	li $v0,print_str
	syscall
	move $a0,$t0
	li $v0,print_int
	syscall
	la $a0,dp
	li $v0,print_str
	syscall
	
	li $t1,0			# j = 0
	sll $t2,$t0,2
	addu $t3,$s0,$t2		# array[i]
	lw $t3,0($t3)	
while:	addu $t4,$t3,$t1		# array[i][j]
	lb $a0,0($t4)
	beq $a0,'\0',endw
	li $v0,print_char
	syscall
	li $a0,'-'
	syscall
		
	addi $t1,$t1,1		# j++	
	j while
endw:
	
	addi $t0,$t0,1
	j for
endf:


