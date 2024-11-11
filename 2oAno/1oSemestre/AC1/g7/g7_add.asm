# g7_add _
	.eqv print_int,1
	.eqv print_str,4
	.eqv print_char,11
	.eqv read_int,5

# int insert(int *array, int value, int pos, int size) 
# $a0 = int *array
# $a1 = int value
# $a2 = int pos
# $a3 = int size

# $t0 = i
# $t1 = size - 1
	.text
insert:	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)		# quero guardar o endereço que está em $a0 aqui porque
				# posso.
	move $s0,$a0
	move $t1,$a3
	addi $t1,$t1,-1		# size - 1

if:	ble $a2,$a3,else		# if(pos > size) 
	li $t9,1
	move $v0,$t9		# return 1
	j endif

else:	move $t0,$t1		# i = size - 1
	# $a0 = int *array = &array[0]
	# $a1 = int value
	# $a2 int pos
	sll $t4,$a2,2		# pos*4		# para somar ig

	sll $t9,$t0,2		# size - 1) * 4	
	addu $a0,$a0,$t9		# &array + size - 1 -> ultima pos	##
	addiu $t8,$a0,4		# novo ultimo?				##
	
	
for:	blt $t0,$a2,endf		# for(i = size-1; i >= pos; i--) 
	
	## load anterior no endereço à frente para arrastar a lista para a
	## frente e siga viagem
	lw $t7,0($a0)
	sw $t7,0($t8)
	addiu $a0,$a0,-4	
	addiu $t8,$t8,-4
	
	addi $t0,$t0,-1		# i--
	j for
	
endf:	#addu $a0,$s0,$t4	# array[pos]
	sw $a1,0($t8)
	
	move $v0,$0		# return 0;
endif:	
	lw $s0,4($sp)	
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra
#########################################################################################	
# void print_array(int *a, int n)
# $a0 = int *a
# $a1 = int n
# sendo *a o endereço do array a imprimir e n o número de elementos inteiros a imprimir (?)

# $t0 = int *p
	.text
print_array:
	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)
	
	move $s0,$a0		# int *a
	
	move $t1,$a1
	sll $t1,$t1,2		# n*4
	addu $t0,$s0,$t1		# int *p = a + n;

for1:	bge $s0,$t0,endf1
	
	lw $a0,0($s0)		# *a
	li $v0,print_int
	syscall			# print_int( *a );
	li $a0,','
	li $v0,print_char
	syscall
	li $a0,' '
	li $v0,print_char
	syscall			# print_str(", ");	# mais ou menos lmfao
	
	addiu $s0,$s0,4		# a++
	j for1
endf1:	
	lw $s0,4($sp)
	lw $ra,0($sp)
	addiu $sp,$sp,8
	jr $ra
########################################################################################
	.data
array:	.space 50		# static int array[50];
str1:	.asciiz "Size of array: "
str2:	.asciiz "\narray["
str3:	.asciiz "] = "
str4:	.asciiz "\nEnter the value to be inserted: "
str5:	.asciiz "\nEnter the position: "
str6:	.asciiz "\nOriginal array: "
str7:	.asciiz "\nModified array: "

# registos usados na main:
# $s0 - array_size
# $s1 - i
# $s2 - valores a inserir no array
# $s3 - valor novo a ser inserido
# $s4 - posição a inserir o novo valor
# $s5 - &array		# sim, mais um, nao vou refazer foda se

# $t0 - &array[i]
# $t1 - i*4					# se der merda, meter estes
						# registos em $sn

	.text
	.globl main
main:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	la $t0,array		# &array
	la $s5,array		# foda se	
	
	la $a0,str1
	li $v0,print_str
	syscall			# print_string("Size of array : ");
	li $v0,read_int
	syscall
	move $s0,$v0		# $s0 = array_size
	li $s1,0			# $s1 = i
	
for2:	bge $s1,$s0,endf2	# for(i=0; i < array_size; i++) 
	
	la $a0,str2
	li $v0,print_str
	syscall			# print_string("array["); 
	move $a0,$s1
	li $v0,print_int	
	syscall			# print_int10(i); 
	la $a0,str3
	li $v0,print_str
	syscall			# print_string("] = "); 
	
	li $v0,read_int
	syscall			# read_int()
	move $s2,$v0		# $s2 = valores para inserir no array

	#move $t1,$s1		# i
	#sll $t1,$t1,2		# i*4
	#addu $t0,$t0,$t1
	sw $s2,0($t0)		# array[i] = read_int();
	addiu $t0,$t0,4
	
	addi $s1,$s1,1		# i++
	j for2
	
endf2:	la $a0,str4
	li $v0,print_str
	syscall			# print_string("Enter the value to be inserted: "); 
	li $v0,read_int
	syscall			# read_int()
	move $s3,$v0		# insert_value = read_int()
	
	la $a0,str5
	li $v0,print_str
	syscall			# print_string("Enter the position: "); 
	li $v0,read_int
	syscall			# read_int()
	move $s4,$v0		# insert_pos = read_int()
	
	la $a0,str6
	li $v0,print_str
	syscall			# print_string("\nOriginal array: "); 
####### OH FUCK OH FUCK HERE WE GO #######
	move $a0,$s5		# array	
	move $a1,$s0		# array_size
	jal print_array		# print_array(array, array_size);
	
	move $a0,$s5		# array
	move $a1,$s3		# insert_value
	move $a2,$s4		# insert_pos
	move $a3,$s0		# array_size
	jal insert		# insert(array, insert_value, insert_pos, array_size);
	
	la $a0,str7
	li $v0,print_str
	syscall			# print_string("\nModified array: ");
	
	move $a0,$s5		# array
	addi $t2,$s0,1		# array_size + 1
	move $a1,$t2
	jal print_array
	
	move $v0,$0		# return 0;
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
	
	
	
