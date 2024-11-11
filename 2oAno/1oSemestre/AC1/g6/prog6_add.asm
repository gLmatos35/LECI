# g6_4 _
# Mapa de Registos:
# $t0 - int argc		# n de elementos
# $t1 - char *argv[]	# ponteiro para o conteudo
# $t2 - i
# $t3 - i*4
# $t4 - argv[i]
# $t5 - idk
# $t6 - argv[i][j] ?
# $t7 - n_chars
# $t8 - n_maiusc
# $t9 - n_minusc
# $s0 - max_chars
# $s1 - strMax_chars
	.eqv print_int,1
	.eqv print_str,4
	.eqv print_char,11
	
	.data
str1:	.asciiz "Argumento "
str2:	.asciiz ":\n"
chars:	.asciiz "Numero de caracteres: "
upper:	.asciiz "Numero de maiusculas: "
lower:	.asciiz "Numero de minusculas: "
max_str:	.asciiz "Palavra c/ maior n_chars: "

	.text
	.globl main
main:	move $t0,$a0
	move $t1,$a1
	
	li $t2,0
	li $s0,0			# max_chars inicial
	
for:	bge $t2,$t0,endf

	la $a0,str1
	li $v0,print_str
	syscall 			# print_str("Argumento ")
	move $a0,$t2
	li $v0,print_int		# print_int(i)
	syscall
	la $a0,str2
	li $v0,print_str		# print_str(":\n")
	syscall
	
	move $t3,$t2		# $t3 = i
	sll $t3,$t3,2		# i*4
	addu $t4,$t1,$t3		# argv[i]
	lw $t5,0($t4)		# endereço de argv[i] ??
	
	li $t7,0
	li $t8,0
	li $t9,0
	
for2:	#lw $t5,0($t4)		# endereço de argv[i] ??
	lb $t6,0($t5)		# argv[i][j]
	beq $t6,$0,endf2
	
	addi $t7,$t7,1		# n_chars++;
## A - 0x41	Z - 0x5a		a - 0x61		z - 0x7a

# if (char >= 0x41 && char <= 0x5a) { add maiusc }
if:	blt $t6,0x41,endif
	bgt $t6,0x5a,endif
	addi $t8,$t8,1		# n_maiusc ++;
	#j endif2			# ?
endif:
# if (char >= 0x61 && char <= 0x7a) { add minusc }
if2:	blt $t6,0x61,endif2
	bgt $t6,0x7a,endif2
	addi $t9,$t9,1
endif2:
	addiu $t5,$t5,1		# prox char? yes
	j for2
endf2:	
	la $a0,chars
	li $v0,print_str
	syscall
	move $a0,$t7
	li $v0,print_int
	syscall			# n_chars
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	la $a0,upper
	li $v0,print_str
	syscall
	move $a0,$t8
	li $v0,print_int
	syscall			# n_maiusc
	li $a0,'\n'
	li $v0,print_char
	syscall
	
	la $a0,lower
	li $v0,print_str
	syscall
	move $a0,$t9
	li $v0,print_int
	syscall			# n_minusc
	li $a0,'\n'
	li $v0,print_char
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall
###	if (max_chars < n_chars) { update max and save word address )
if3:	bge $s0,$t7,endif3
	move $s0,$t7		# update max_chars
	lw $s1,0($t4)		# palavra max_chars
endif3:	
	
	addi $t2,$t2,1
	j for

endf:	
	la $a0,max_str
	li $v0,print_str
	syscall			# print("Palavra c/ maior n_chars: ")
	move $a0,$s1
	li $v0,print_str
	syscall			# palavra
	
	jr $ra	
	
	
	
	
	
	
	
	
	
	
	
	
	
	