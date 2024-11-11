# g5_1a _
# Mapa de Registos
# i: $t0 
# lista: $t1 
# lista + i: $t2 

	.eqv SIZE,5
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_int,1

	.data
lista:	.space 20		# static int lista[SIZE];
str1:	.asciiz "\nIntroduza um numero: "
str2:	.asciiz "Array: {"
virg:	.asciiz ", "
endstr:	.asciiz "}\n"

	.text
	.globl main
main:	li $t0,0			# i = 0;
	la $t1,lista		# $t1 = lista

for:	bge $t0,SIZE,endF	# for(i=0; i < SIZE; i++)

	la $a0,str1
	li $v0,print_str
	syscall			# print_string(str); 

	sll $t4,$t0,2		# $t4 = i*4
	addu $t2,$t1,$t4		# lista[i] = lista + 1
	li $v0,read_int
	syscall
	move $t5,$v0		# $t5 = read_int()
	sw $t5,0($t2)	

	addi $t0,$t0,1		# i++;
	j for
	
endF:	

	li $t0,0			# i = 0
	li $t9,SIZE
	addi $t9,$t9,-1
	
	la $a0,str2
	li $v0,print_str
	syscall
	
for2:	bge $t0,$t9,endF2		

	sll $t4,$t0,2
	addu $t2,$t1,$t4
	lw $t5,0($t2)
	
	move $a0,$t5
	li $v0,print_int
	syscall
	
	la $a0,virg
	li $v0,print_str
	syscall
	
	addi $t0,$t0,1
	j for2
	
endF2:	sll $t4,$t0,2
	addu $t2,$t1,$t4
	lw $t5,0($t2)
	move $a0,$t5
	li $v0,print_int
	syscall
	la $a0,endstr
	li $v0,print_str
	syscall
	jr $ra
	
	
	
	
	
	