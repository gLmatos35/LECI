# g11_1a

	.eqv print_float, 2
    	.eqv print_double,3
    	.eqv read_integer, 5
    	.eqv print_str, 4
    	.eqv read_float, 6
    	.eqv read_double, 7
    	.eqv print_chr, 11
    	.eqv print_char, 12
    	.eqv print_ui10, 36
    	
    	.eqv nMec,0
    	.eqv fname,4
    	.eqv lname,22
    	.eqv nota,40
    	
    	.data
	.align 2
stdnt:	.word 114252		# offset = 0; 	dimensao = 4
	.asciiz "Guwui "		# offset = 4;	dim = 18
	.space 11
	.asciiz "Jose"		# offset = 22	dim = 15
	.space 10		
	.align 2			# offset = 37 -> 40
	.float 7.0		# offset = 40	dim = 4
				# dimensao final = 44
		
	.data
str1:	.asciiz "\nN mec: "
str2:	.asciiz "\nNome: "
str3:	.asciiz "\nNota: "
str4:	.asciiz ", "
		
	.text
	.globl main
main:	la $a0,str1
	li $v0,print_str
	syscall
	la $t0,stdnt
	lw $a0,nMec($t0)	
	li $v0,print_ui10
	syscall			# n_mec
	
	la $a0,str2
	li $v0,print_str
	syscall
	la $t0,stdnt
	#lw $a0,lname($t0)
	addi $a0,$t0,lname
	li $v0,print_str
	syscall
	la $a0,str4
	li $v0,print_str
	syscall
	
	la $t0,stdnt
	#lw $a0,fname($t0)
	addi $a0,$t0,fname
	li $v0,print_str
	syscall
	
	la $a0,str3
	li $v0,print_str
	syscall
	la $t0,stdnt
	addi $t0,$t0,nota
	l.s $f12,0($t0)
	li $v0,print_float
	syscall
	
	li $v0,0
	
	jr $ra
	


	
	
	







