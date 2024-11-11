# g5_1_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv size,5

	.data	
lista:	.space 20		# static int lista[size]
str1:	.asciiz "\nNumber? "
a:	.asciiz "Array = ["
virg:	.asciiz ", "
c:	.asciiz "]\n" 
 
	.text	
	.globl main
main:	la $t0,lista		# &lista
	
	li $t1,0			# i = 0
for:	bge $t1,size,endf	# for(i=0; i < SIZE; i++)

	sll $t2,$t1,2		# i*4
	addu $t3,$t0,$t2		# &lista + 4*i
	
	la $a0,str1
	li $v0,print_str
	syscall			# "\nNumber? "
	
	li $v0,read_int
	syscall
	sw $v0,0($t3)		# lista[i] = read_int()

	addi $t1,$t1,1		# i++
	j for
endf:	

	li $t1,0			# i = 0
	
	la $a0,a
	li $v0,print_str
	syscall			
	
	li $t4,size
	addi $t4,$t4,-1		# size - 1 
	
forA:	bge $t1,$t4,endfA	# for(i = 0; i < size; i++)
	
	sll $t2,$t1,2		# i*4
	addu $t3,$t0,$t2		# &lista + i*4
	
	lw $a0,0($t3)		# lista[i]
	li $v0,print_int
	syscall
	
	la $a0,virg
	li $v0,print_str
	syscall
	
	addi $t1,$t1,1		# i++
	j forA
endfA:	
	sll $t2,$t1,2
	addu $t3,$t0,$t2
	
	lw $a0,0($t3)		# lista[i]
	li $v0,print_int
	syscall
	
	la $a0,c
	li $v0,print_str
	syscall
	
	jr $ra













