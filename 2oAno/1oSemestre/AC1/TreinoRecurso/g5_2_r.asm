# g5_2_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv size,5
	
	.data
lst:	.word 8,-4,3,5,124
str1:	.asciiz "\nConteúdo do array:\n"
a_s:	.asciiz "Array = ["
virg:	.asciiz ", "
a_e:	.asciiz "]\n" 
	
	.text
	.globl main
# $t0 - p

main:	la $t0,lst		# p = lst
	
	la $a0,a_s
	li $v0,print_str
	syscall
	li $t1,size
	addi $t1,$t1,-1		# size = size-1
	sll $t1,$t1,2
	addu $t1,$t0,$t1		# lista + size
	
for:	bge $t0,$t1,endf
	
	lw $a0,0($t0)
	li $v0,print_int
	syscall
	la $a0,virg
	li $v0,print_str
	syscall
	
	addi $t0,$t0,4		# p++
	j for

endf:	lw $a0,0($t0)
	li $v0,print_int
	syscall
	la $a0,a_e
	li $v0,print_str
	syscall
	
	jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	

