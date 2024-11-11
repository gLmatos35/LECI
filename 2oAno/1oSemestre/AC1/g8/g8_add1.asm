# g8_add1 _
# unsigned int div(unsigned int dividendo, unsigned int divisor)
	
# os operandos têm uma dimensao maxima de 16 bits
# $a0 = unsigned int dividendo
# $a1 = unsigned int divisor
	.text
divis:	addiu $sp,$sp,-4
	sw $ra,0($sp)
	
	sll $a0,$a0,16		# divisor = divisor << 16;
	andi $a1,$a1,0xffff	# dividendo = (dividendo & 0xFFFF);
	sll $a1,$a1,1		# dividendo = (dividendo & 0xFFFF) << 1;
	
	li $t0,0			# i = 0
for:	bge $t0,16,endf
	
	li $t1,0			# bit = 0
if:	blt $a1,$a0,endif
	
	subu $a1,$a1,$a0		# dividendo = dividendo - divisor; 
	li $t1,1			# bit = 1
	
endif:	sll $a1,$a1,1		# dividendo << 1
	or $a1,$a1,$t1		# dividendo = (dividendo << 1) | bit;
	
	addi $t0,$t0,1
	j for

endf:	srl $t2,$a1,1		# dividendo << 1
	#andi $t2,$t2,0xffff0000	# resto = (dividendo >> 1) & 0xFFFF0000;
	lui $t9,0xffff
	and $t2,$t2,$t9
	andi $t3,$a0,0xffff	# quociente = dividendo & 0xFFFF
	
	or $t4,$t2,$t3		# (resto | quociente); 
	move $v0,$t4		# return (resto | quociente); 
	
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
###################################################################################
	.data
str1:    .asciiz    "Introduza um dividendo: "
str2:    .asciiz    "Indroduza um divisor: "
str3:    .asciiz    "Resultado: "
str4:    .asciiz    "\nResto: "
	.text
	.globl main
#main:	addi $sp,$sp,-4
#	sw $ra,0($sp)
#	lw $ra,0($sp)
#	addi $sp,$sp,4
#	jr $ra
main:   addiu    $sp, $sp, -4
    	sw    $ra, 0($sp)
    	la    $a0, str1
    	li    $v0, 4
    	syscall
   	li    $v0, 5
    	syscall
   	 move    $t0, $v0
    	la    $a0, str2
    	li    $v0, 4
    	syscall
    	li    $v0,5
	syscall
	move    $a1, $v0
    	move    $a0, $t0
    	jal    divis
    	move    $t0, $v0
    	move    $t1, $v0
    	srl    $t0, $t0, 16
    	andi    $t1, $t1, 0xffff
    	la    $a0, str3
    	li    $v0, 4
    	syscall
    	move    $a0, $t1 
    	li    $v0, 1
    	syscall
    	la    $a0, str4
    	li    $v0, 4
   	syscall
    	move    $a0, $t0 
    	li    $v0, 1
    	syscall
    	lw    $ra, 0($sp)
    	addiu    $sp, $sp, 4
    	jr    $ra
    	
# nao, nao funciona, diverte te a corrigir :DDDDDDDDDd







