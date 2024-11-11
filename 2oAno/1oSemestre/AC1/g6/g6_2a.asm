#g6_2a _
	.eqv size,3
	#
	.eqv print_str,4
	.eqv print_char,11

	.data
w1:	.asciiz "Array"
w2:	.asciiz "de"
w3:	.asciiz "ponteiros"
array:	.word w1,w2,w3

	.text
	.globl main
#Mapa de Registos:
# $t0 - p
# $t1 - pultimo
main:	la $t0,array		# p = array
	li $t1,size
	sll $t1,$t1,2		# $t1 = size*4
	addu $t1,$t0,$t1	# pultimo = array + SIZE;
	
for:	bge $t0,$t1,endf		# for(; p < pultimo; p++)
	
	lw $a0,0($t0)		# *p
	li $v0,print_str
	syscall			# print_string(*p);
	li $a0,'\n'
	li $v0,print_char
	syscall			# print_char('\n');
	
	addiu $t0,$t0,4		# p++;
	j for

endf:	jr $ra
	
	
	
	
	
	
	
	
	
	
	