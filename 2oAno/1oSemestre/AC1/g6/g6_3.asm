#g6_3a _
	.eqv size,4
	
	.eqv print_int,1
	.eqv print_str,4
	.eqv print_char,11

	.data
w1:	.asciiz "Outra"
w2:	.asciiz "vez"
w3:	.asciiz "arroz"
w4:	.asciiz "?"
array:	.word w1,w2,w3,w4
str1:	.asciiz "\nString: #"
str2:	.asciiz ": "

	.text
	.globl main
# Mapa de Registos
# $t0 - i
# $t1 - j
# $t2 - i * 4
# $t3 - array
# $t4 - array[i]
# $t5 - array[i][j]
# $t6 - *(array[i][j])
main:	li $t0,0			# i = 0;
### for ###	
for:	bge $t0,size,endf	# for(i=0; i < SIZE; i++)
	
	la $a0,str1
	li $v0,print_str
	syscall			# print_string( "\nString #" );
	move $a0,$t0
	li $v0,print_int
	syscall			# print_int10( i );
	la $a0,str2
	li $v0,print_str	
	syscall			# print_string( ": " ); 
	li $t1,0			# j = 0;
### while ###	
	move $t2,$t0
	sll $t2,$t2,2		# i*4
	la $t3,array		# array
	addu $t4,$t3,$t2		# array[i]
	
while:	lw $t5,0($t4)		# ponteiro inicial para array[i][j] ?
	addu $t5,$t5,$t1		# array[i][j]
	lb $t6,0($t5)		# *(array[i][j])		?
	beq $t6,$0,endw		# while(array[i][j] != '\0') 
	
	move $a0,$t6
	li $v0,print_char
	syscall			# print_char(array[i][j]); 
	
	li $a0,'-'
	li $v0,print_char
	syscall			#  print_char('-'); 

	addi $t1,$t1,1		# j++
	j while
endw:
	
	
	
	addi $t0,$t0,1		# i++;
	j for
	
endf:	jr $ra
	
	
	
	
	
	
	
	