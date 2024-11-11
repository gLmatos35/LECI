#g6_3 _
	.eqv size,4
	#
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
# $t2 - &array[i][j]
# $t3 - i * 4
# $t4 - array[i][j]
main:	li $t0,0			# i = 0;
	
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
	
	la $t2,array		# $t2 = &array
	move $t3,$t0
	sll $t3,$t3,2		# i*4
	addu $t2,$t2,$t3		# local onde está guardado o endereço para array[i]
	
while:	lw $t3,0($t2)		# array[i]
	addu $t3,$t3,$t1		# &array[i][j]
	lb $t4,0($t3)		# array[i][0]
	beq $t4,$0,endw		# while(array[i][j] != '\0')
	
	move $a0,$t4	 
	li $v0,print_char
	syscall			# print_char(array[i][j]);
	li $a0,'-'
	li $v0,print_char
	syscall			# print_char('-');
	
	addi $t1,$t1,1		# j++;
	j while
endw:	
	addi $t0,$t0,1		# i++;
	j for
	
endf:	jr $ra














