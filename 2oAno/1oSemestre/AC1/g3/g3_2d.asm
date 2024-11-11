# g3_2d.asm _
# Mapa de registos
# $t0 = i
# $t1 = bit
# $t2 = value
# $t3 = flag

	.eqv print_str,4
	.eqv read_int,5
	.eqv print_char,11
	
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário e': "

	.text
	.globl main
main:	la $a0,str1
	li $v0,print_str
	syscall			# print("Introduza um numero: "); 
	
	li $v0,read_int
	syscall		
	move $t2,$v0		# value = read_int
	
	la $a0,str2
	li $v0,print_str
	syscall			# print("\nO valor em binário e': ");
	
### for ###	
	li $t0,0			# i = 0
	li $t3,0			# flag = 0
for:	bge $t0,32,endf
				
	srl $t1,$t2,31		# bit = value >> 31;
	
	### if ###
	bne $t3,1,checkB		# if(flag != 1) goto checkB
	j if2			# if(flag == 1)	goto if2	
					 				 
checkB:	beq $t1,$0,else		# if(bit != 0) goto else
#just in case.. :')
	j if2			# if(bit == 0) goto if2
		### if2 ###
if2:	li $t3,1

	rem $t9,$t0,1		# $t9 = i%4
	bne $t9,0,noSpc		# if((i % 4) != 0) goto noSpc
	li $a0,' '		# if((i % 4) == 0) 
	li $v0,print_char
	syscall			# print(' ')	

noSpc:	
	addi $t8,$t1,0x30	# print_char(0x30 + bit);
	move $a0,$t8
	li $v0,print_char
	syscall

else:
	sll $t2,$t2,1		# value = value << 1; 
				# // shift left de 1 bit 
	addi $t0,$t0,1		# i++
	j for			# jump to for
	
endf:	jr $ra			# end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
