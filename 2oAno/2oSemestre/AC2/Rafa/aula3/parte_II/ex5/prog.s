
		.equ 	READ_CORE_TIMER,11
	 	.equ 	RESET_CORE_TIMER,12
		.equ 	ADDR_BASE_HI, 0xBF88 		# Base address: 16 MSbits
		.equ 	TRISE, 0x6100  			# TRISE address is 0xBF886100
		.equ		TRISB, 0x6040
		.equ 	LATE, 0x6120 				# LATE address is 0xBF886120
		.equ		PORTB, 0x6050
		.equ		PORTE, 0x6120



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
		li	$s0, 0				# next bit
loop:		
	
	
		
		

		lw 	$t2, LATE($s1) 		# Read LATE register
		

		
		xori	$t4, $t2, 0x0010
		andi	$t4, $t4, 0x0010
		srl 	$t4, $t4, 3 			# Vai para o bit "inicial"
		sll	$t2, $t2, 1
		
		or 	$t2, $t2, $t4 			# merge
		sw 	$t2, LATE($s1) 		# Update LATE register
		
		
#		li	$a0, 50
#		jal	delay
		
		li 	$v0, RESET_CORE_TIMER
		syscall
wait: 	li 	$v0, READ_CORE_TIMER
		syscall
		blt 	$v0, 13333333, wait 		# e.g. f=1.5 Hz

		addi	$s3, $s3, 1
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
	 
