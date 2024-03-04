
		.equ 	READ_CORE_TIMER,11
	 	.equ 	RESET_CORE_TIMER,12
		.equ 	ADDR_BASE_HI, 0xBF88 		# Base address: 16 MSbits
		.equ 	TRISE, 0x6100  			# TRISE address is 0xBF886100
		.equ		TRISB, 0x6040
		.equ 	LATE, 0x6120 				# LATE address is 0xBF886120
		.equ		PORTB, 0x6050



		.data
		.text
		.globl main
		
main:	
		addiu	$sp, $sp, -16
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s3, 12($sp)
		
		
		
		lui 	$s1, ADDR_BASE_HI 		# $t1=0xBF880000
		lw	$t2, TRISE($s1)
		andi	$t2, $t2, 0xffe1
		sw	$t2, TRISE($s1)
		lw 	$t2, TRISB($s1) 		# Read TRISB register
		ori	$t2, $t2, 0x000e
		sw	$t2, TRISB($s1)
	
		li	$s3, 0				# e.g. up counter (initial value is 0)
		li	$s0, 0				# variavel de controlo, se é inverso ou não
loop:		
	
	
		lw	$t2, PORTB($s1)		# Verificar o valor de RB1
		srl	$s0, $s0, 1			# No exercício anterior, o srl era de 3, mas aparentemente
		andi	$s0, $t2, 0x0001		# o resultado é o mesmo que srl de 1		


		lw 	$t2, LATE($s1) 		# Read LATE register
		andi	$t2, $t2, 0xFFE1 		# Reset bits 4-1
		sll 	$t4, $s3, 1 			# Shift counter value to "position" 1
		or 	$t2, $t2, $t4 			# Merge counter w/ LATE value
		sw 	$t2, LATE($s1) 		# Update LATE register
		
		
#		li	$a0, 50
#		jal	delay
		
		li 	$v0, RESET_CORE_TIMER
		syscall
wait: 	li 	$v0, READ_CORE_TIMER
		syscall
		blt 	$v0, 6666667, wait 		# e.g. f=3Hz
		
if:		beq	$s0, 0, else
		sll	$s3, $s3, 1
		j	eif
else:
		srl $s3, $s3, 1
eif:
		andi $s3,	$s3,	0x000F 		# e.g. up counter MOD 16
		
		j	loop
eloop:	
		
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s3, 12($sp)
		addiu	$sp, $sp, -16
	
		jr	$ra
# ----------------------------------------------------------------------------------------
		.text
delay: 
		li $v0,RESET_CORE_TIMER 
	 	syscall
	 	mul $t0, $a0, 200000
whil: 	li $v0, READ_CORE_TIMER
	 	syscall
	 	blt $v0, $t0, whil
	 	
	 	jr	$ra
	 
