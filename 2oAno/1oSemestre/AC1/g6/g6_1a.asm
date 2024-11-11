#g6_1a _
	.eqv size,3		
	
	.eqv print_str,4
	.eqv print_char,11
	
	.data
str1:   .asciiz "Array" 
str2:   .asciiz "de" 
str3:   .asciiz "ponteiros"
array:  .word str1,str2,str3	# static char *array[SIZE]={"Array", "de", "ponteiros"}; 

#Mapa de Registos:
# $t0 - i
# $t1 - array
# $t2 - array[i]

	.text
	.globl main
main:	li $t0,0
	la $t1,array

for:	bge $t0,size,endf

	sll $t3,$t0,2		# $t3 = i * 4
	addu $t2,$t1,$t3	 	# &array[i] 
	lw $a0,0($t2)
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0,print_char
	syscall

	addi $t0,$t0,1		# i++
	j for
	
endf:	jr $ra