# g4_2a	_
# Mapa de Registos:
# num: $t0 
# p: $t1 
# *p: $t2 
	
	.eqv SIZE,20
	.eqv SIZEmais1,21
	
	.eqv read_str,8
	.eqv print_int10,1
	.eqv print_str,4
	
	.data
str:	.space SIZEmais1		# static char str[SIZE+1];	
	
str1:	.asciiz "Input a word: "
str2:	.asciiz "\nNumber of digits: "

	.text
	.globl main
main:	li $t0,0			# int num = 0;
	
	la $a0,str1
	li $v0,print_str
	syscall			# print("Input a word: ")
	
	la $a0,str
	li $a1,SIZE
	li $v0,read_str
	syscall			# read_string(str, SIZE);

	la $t1,str		# p = str;
	
### while ###
while:	lb $t2,0($t1)		# *p		(primeiro char)
	# li $t9,'\0'		# $t9 = '\0'
	beq $t2,$0,endW		# while( *p != '\0' )
	
	blt $t2,'0',endif	#  
	bgt $t2,'9',endif	# if( (*p >= '0') && (*p <= '9') ) 
	addi $t0,$t0,1		# num++
		
endif:	addiu $t1,$t1,1		# p++

	j while	

endW:	la $a0,str2
	li $v0,print_str
	syscall			# print("\nNumber of digits: ")

	move $a0,$t0
	li $v0,print_int10
	syscall			# print_int10(num);
	jr $ra

		
	
	
	
	
	
	
	
	
	
	
	