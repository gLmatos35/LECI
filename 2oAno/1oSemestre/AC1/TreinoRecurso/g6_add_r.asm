# g6_add_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.data
str1:	.asciiz "Nr de parametros: "
P:	.asciiz "\nP"
dp:	.asciiz ": "
chars:	.asciiz " caracteres;\n"
minusc:	.asciiz " letras minusculas; "
maiusc:	.asciiz " letras maiusc;\n"
winner:	.asciiz "Maior string:\n"
lol:	.asciiz ">> "
	
# n de chars em cada arg		/ done
# n de letras minusc e maiusc	/ done
# maior string			/ 

	.text
	.globl main
main:	move $t0,$a0		# argc - nr de argumentos passados
	move $t1,$a1		# argv - array de ponteiros
	
	la $a0,str1
	li $v0,print_str
	syscall
	move $a0,$t0
	li $v0,print_int
	syscall
	
	li $t2,0			# i = 0
	
	li $s7,0			# Wstring_chars	
for1:	bge $t2,$t0,endf1

	la $a0,P
	li $v0,print_str
	syscall
	move $a0,$t2
	li $v0,print_int
	syscall
	la $a0,dp
	li $v0,print_str
	syscall
		
	move $t4,$t1
	sll $t3,$t2,2		# i*4
	addu $t4,$t4,$t3
	lw $a0,0($t4)		# argv[i]
# add 	
	li $s0,0			# j = 0
	li $s4,0			# n_chars
	li $s5,0			# n_minusc
	li $s6,0			# n_maiusc
	move $s1,$a0
for2:	addu $s2,$s1,$s0		# argv[i][j]
	lb $s3,0($s2)
	beq $s3,'\0',endf2
	
	addi $s4,$s4,1		## n_chars++
	
if:	blt $s3,0x41,elif	# if(char >= 0x41 and char <= 0x5a): maiusc
	bgt $s3,0x5a,elif
	addi $s6,$s6,1		## n_maiusc++
	j end

elif:	blt $s3,0x61,end		# else if (char >= 0x61 and char <= 0x7a): minusc 
	bgt $s3,0x7a,end
	addi $s5,$s5,1		## n_minusc++

end:	
	addi $s0,$s0,1		# j++
	j for2
endf2:

ifW:	ble $s4,$s7,endW		# if(n_chars > Wstring) {Wstring = argv[i] - $s1
	move $s7,$s4		# Wstring_chars
	move $t9,$s1		# Wstring address	
endW:
	# imprimir merdas
	
	#
# add ^	
	move $a0,$s1		# argv[i]
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	move $a0,$s4
	li $v0,print_int
	syscall
	la $a0,chars
	li $v0,print_str
	syscall
	move $a0,$s5
	li $v0,print_int
	syscall
	la $a0,minusc
	li $v0,print_str
	syscall
	move $a0,$s6
	li $v0,print_int
	syscall
	la $a0,maiusc
	li $v0,print_str
	syscall
	
	addi $t2,$t2,1		# i++
	j for1
endf1:	
	li $a0,'\n'
	li $v0,print_char
	syscall		
	la $a0,winner
	li $v0,print_str
	syscall
	la $a0,lol
	syscall
	move $a0,$t9
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
	move $a0,$s7
	li $v0,print_int
	syscall
	la $a0,chars
	li $v0,print_str
	syscall
	
	li $v0,0
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
