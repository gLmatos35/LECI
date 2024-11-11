# g3_2b.asm _
# Mapa de registos
# $t0 = i
# $t1 = bit
# $t2 = value

	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário e': "

	.text
	.globl main
	
main:	li $t0,0			# i = 0
	la $a0,str1
	li $v0,print_str
	syscall			# print("Introduza um numero: ");
	li $v0,read_int		
	syscall			# read_int()
	move $t2,$v0		# value = read_int();
	la $a0,str2
	li $v0,print_str
	syscall			# print("\nO valor em binário e': ");
	
for:	bge $t0,32,endf		# for(i=0; i < 32; i++)
	
	li $t3,4			# $t3 = 4
	rem $t3,$t0,$t3
	beq $t0,0,cont
	bne $t3,0,cont
	li $t3,' '
	or $a0,$0,$t3
	li $v0,print_char
	syscall
	
cont:
	li $t3,0x80000000
	and $t1,$t2,$t3		# bit = value & 0x80000000; // isola bit 31

	beq $t1,$0,else		#if
	li $a0,'1'
	li $v0,print_char
	syscall			# print_char('1');
	j endif
	
else:	li $a0,'0'
	li $v0,print_char
	syscall			# print_char('0');
	
endif:	sll $t2,$t2,1		# value = value << 1; 	// shift left de 1 bit
	addi $t0,$t0,1		# i++
	j for
	
endf:	
	jr $ra
