#g5_4a _
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

# Mapa de Registos:
# $t0 - i
# $t1 - lista
# $t2 - lista + i
# $t3 - houve_troca
# $t4 - p
# $t5 - pUltimo
# $t6 - *p
# $t7 - *(p+1)
# $t8 - aux
#### leitura e preenchimento, g5_1a ####

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
############## inicio do exercicio ##############
	li $t5,SIZE
	sll $t5,$t5,2			# SIZE * 4
	addi $t5,$t5,-4			# SIZE * 4 - 4
	addu $t5,$t1,$t5			# pUltimo = lista + (SIZE - 1);
### do while ###
do:	li $t3,0				# houveTroca = FALSE;
	move $t4,$t1			# p = lista
### for ###
for2:	bge $t4,$t5,endF2		# for (p = lista; p < pUltimo; p++) 
	
### if ###	
	lw $t6,0($t4)			# *p
	lw $t7,4($t4)			# *(p+1)
	ble $t6,$t7,endif		# if (*p > *(p+1))
### HALL OF SHAME ###	
	#move $t8,$t6			# aux = *p;
	#move $t6,$t7			# *p = *(p+1);
	#move $t7,$t8			# *(p+1) = aux
#####################
	sw $t7,0($t4)
	sw $t6,4($t4)	
	li $t3,1				# houveTroca = TRUE;
	
endif:
	addiu $t4,$t4,4			# p++
	j for2	
endF2:	
	beq $t3,1,do			# while (houveTroca==TRUE);


#### impressão do conteúdo do array, g5_1a ####
	li $t0,0				# i = 0
	li $t9,SIZE
	addi $t9,$t9,-1
	
	la $a0,str2
	li $v0,print_str
	syscall
	
for3:	bge $t0,$t9,endF3		

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
	j for3
	
endF3:	sll $t4,$t0,2
	addu $t2,$t1,$t4
	lw $t5,0($t2)
	move $a0,$t5
	li $v0,print_int
	syscall
	la $a0,endstr
	li $v0,print_str
	syscall
	jr $ra