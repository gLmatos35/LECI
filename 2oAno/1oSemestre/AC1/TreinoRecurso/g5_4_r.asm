# g5_4_r
	.eqv print_int,1
	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.eqv size,5
	
	.data
lst:	.space 20	
	
str1:	.asciiz "\nArray Original: "
str2:	.asciiz "\nArray Organizado: "
virg:	.asciiz ", "
num:	.asciiz "Insert 5 numbers for the array:\n"
input:	.asciiz ">> "
	
	.text
	.globl main
main:	
# 5.1
	la $t0,lst		# &lista
	la $a0,num
	li $v0,print_str
	syscall
	
	li $t1,0			# i = 0
for1:	bge $t1,size,endf1	# for(i=0; i < SIZE; i++)

	sll $t2,$t1,2		# i*4
	addu $t3,$t0,$t2		# &lista + 4*i
	
	la $a0,input
	li $v0,print_str
	syscall			# "\nNumber? "
	
	li $v0,read_int
	syscall
	sw $v0,0($t3)		# lista[i] = read_int()

	addi $t1,$t1,1		# i++
	j for1
endf1:	

# 5.2
	la $a0,str1
	li $v0,print_str
	syscall

	la $t0,lst		# p = lst
	
	li $a0,'['
	li $v0,print_char
	syscall
	li $t1,size
	addi $t1,$t1,-1		# size = size-1
	sll $t1,$t1,2
	addu $t1,$t0,$t1		# lista + size
	
for2:	bge $t0,$t1,endf2
	
	lw $a0,0($t0)
	li $v0,print_int
	syscall
	la $a0,virg
	li $v0,print_str
	syscall
	
	addi $t0,$t0,4		# p++
	j for2

endf2:	lw $a0,0($t0)
	li $v0,print_int
	syscall
	li $a0,']'
	li $v0,print_char
	syscall

# 5.3 - bubbleSort
	
	la $t0,lst
	li $t1,size
	addi $t1,$t1,-1
	sll $t1,$t1,2		# (size-1)*4
	add $t1,$t0,$t1		# pUltimo = lista + (size-1)
	
do:	li $s0,0			# houveTroca = FALSE
	
	la $t0,lst		# p
for3:	bge $t0,$t1,endf3

if:	lw $t2,0($t0)		# *p
	lw $t3,4($t0)		# *(p+1)
	ble $t2,$t3,endif	
	
	move $t4,$t2		# aux = *p
	sw $t3,0($t0)		# *p = *(p+1)
	sw $t2,4($t0)		# *(p+1) = aux
	li $s0,1			# houveTroca = 1
endif:	
	addiu $t0,$t0,4		# p++
	j for3
endf3:

while: beq $s0,1,do
	
# 5.2
	la $a0,str2
	li $v0,print_str
	syscall

	la $t0,lst		# p = lst
	
	li $a0,'['
	li $v0,print_char
	syscall
	li $t1,size
	addi $t1,$t1,-1		# size = size-1
	sll $t1,$t1,2
	addu $t1,$t0,$t1		# lista + size
	
for4:	bge $t0,$t1,endf4
	
	lw $a0,0($t0)
	li $v0,print_int
	syscall
	la $a0,virg
	li $v0,print_str
	syscall
	
	addi $t0,$t0,4		# p++
	j for4

endf4:	lw $a0,0($t0)
	li $v0,print_int
	syscall
	li $a0,']'
	li $v0,print_char
	syscall
	
	jr $ra
	

