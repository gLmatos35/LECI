# g6_4 _
# $t0 - int argc		# n de elementos
# $t1 - char *argv[]	# ponteiro para o conteudo
# $t2 - i
# $t3 - argv[i]
	.eqv print_int,1
	.eqv print_str,4
	
	.data
str1:	.asciiz "N. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "

	.text
	.globl main
main:	move $t0,$a0
	move $t1,$a1
	
	li $t2,0			# i = 0
	la $a0,str1
	li $v0,print_str
	syscall			# print_string("Nr. de parametros: ");
	move $a0,$t0
	li $v0,print_int
	syscall			# print_int10(argc); 
	
for:	bge $t2,$t0,endf
	
	la $a0,str2
	li $v0,print_str
	syscall			# print_string("\nP");
	move $a0,$t2
	li $v0,print_int
	syscall			# print_int(i);
	la $a0,str3
	li $v0,print_str
	syscall			# print_string(": "); 
	
	move $t3,$t2
	sll $t3,$t3,2		# i*4
	addu $t3,$t1,$t3		# argv[i] = argv + i*4
	lw $a0,0($t3)
	li $v0,print_str
	syscall
	
	addi $t2,$t2,1		# i++
	j for
	
endf:	









	
