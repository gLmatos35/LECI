# g7_1_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11

	.text
strlen:	move $t0,$a0		# char* str

	li $t1,0			# len = 0	
while:	lb $t2,0($t0)
	addi $t0,$t0,1		# *str++
	beq $t2,'\0',endw
if:	beq $t2,0x20,end
	beq $t2,'\n',end
	addi $t1,$t1,1		# len++
end:
	j while
endw:	move $v0,$t1

	jr $ra

	.data
str1:	.asciiz "\nComeram o ## do joao"
str3:	.asciiz "\nA ju odeia Algebra linear"
str2:	.asciiz "\nNº de caracteres: "

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	li $v0,print_str
	la $a0,str1
	syscall
	la $a0,str2
	syscall
	
	la $a0,str1
	jal strlen
	move $a0,$v0
	li $v0,print_int
	syscall
		
	li $v0,print_str
	la $a0,str3
	syscall
	la $a0,str2
	syscall
	
	la $a0,str3
	jal strlen
	move $a0,$v0
	li $v0,print_int
	syscall	
		
	li $v0,0			# return 0;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4	
	
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
