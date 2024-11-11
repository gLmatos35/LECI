# g6_4_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.data
str1:	.asciiz "Nr de parametros: "
P:	.asciiz "\nP"
dp:	.asciiz ": "
	
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
for:	bge $t2,$t0,endf

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
	li $v0,print_str
	syscall
	
	addi $t2,$t2,1		# i++
	j for
endf:
	li $v0,0
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	