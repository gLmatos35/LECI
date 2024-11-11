# g4_1a _
# Mapa de registos 
# num: $t0 
# i: $t1 
# str: $t2 
# str+i: $t3 
# str[i]: $t4 

	.eqv print_int10,1
	.eqv print_str,4
	.eqv read_str,8
	
	.eqv SIZE,20
	.eqv SIZEmais1,21
	
	.data
str:	.space SIZEmais1		# str [SIZE+1]

str1:	.asciiz "Input a word: "
str2:	.asciiz "\nNumber of digits: "

	.text
	.globl main

main:	li $t0,0			# num = 0
	li $t1,0			# i = 0
	
	la $a0,str1
	li $v0,print_str
	syscall
	la $a0,str
	li $a1,SIZE
	li $v0,read_str
	syscall
	la $t2,str
	
### while ###	
while:	addu $t3,$t2,$t1		# str + 1 = &str[i]
	lb $t4,0($t3)
	beq $t4,$0,endw		# while( str[i] != '\0')

	### if ###
	blt $t4,'0',endif
	bgt $t4,'9',endif	# if( (str[i] >= '0') && (str[i] <= '9') )
	addi $t0,$t0,1		# num++

endif:	addi $t1,$t1,1		# i++
	j while
	
endw:	la $a0,str2
	li $v0,print_str
	syscall
	or $a0,$0,$t0
	li $v0,print_int10
	syscall			# print_int10(num); 
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
