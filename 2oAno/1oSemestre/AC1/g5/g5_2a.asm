# g5_2a	_
# Mapa de registos 
# p: $t0 
# *p: $t1 
# lista + SIZE: $t2

	.eqv SIZE,10
	.eqv print_int,1
	.eqv print_str,4	
	
	.data
lista:	.word 8,-4,3,5,124,-15,87,9,27,15
arrayI:	.asciiz "lista: {"
virg:	.asciiz ", "
arrayF:	.asciiz	"}\n"

	.text
	.globl main
main:	li $t9,SIZE
	sll $t9,$t9,2		# $t9 = SIZE * 4
	addi $t9,$t9,-4		# $t9 = SIZE*4 -4 (antes da ultima pos)
	
	la $t0,lista		# p = lista
	
	addu $t2,$t0,$t9		# $t2 = lista + SIZE
	
	la $a0,arrayI
	li $v0,print_str
	syscall			# print_str("lista: {"
	
for:	bge $t0,$t2,endF
	
	lw $t1,0($t0)
	move $a0,$t1
	li $v0,print_int
	syscall			# print_int( *p );
	
	la $a0,virg
	li $v0,print_str
	syscall			# print_str("; ");
	
	addiu $t0,$t0,4		# p++
	j for
	
endF:	lw $t1,0($t0)
	move $a0,$t1
	li $v0,print_int
	syscall			# print_int( *p );
	
	la $a0,arrayF
	li $v0,print_str
	syscall			# print_str("}\n"};

	jr $ra
	








