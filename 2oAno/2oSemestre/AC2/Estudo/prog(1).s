	.equ ADDR_BASE_HI,0xBF88 		# Base address: 16 MSbits
	.equ TRISE,0x6100 				# TRISE address is 0xBF886100
	.equ PORTE,0x6110 				# PORTE address is 0xBF886110
	.equ LATE,0x6120 				# LATE address is 0xBF886120
	.equ TRISB,0x6040
	.equ PORTB, 0x6050
	.equ LATB, 0x6060
	.equ READ_CORE_TIMER,11
	.equ RESET_CORE_TIMER,12
	
	
	.data
	.text
	.globl main
	
main:
	lui	$t0, ADDR_BASE_HI
	lw 	$t1,TRISE($t0) 		# $t0 must be previously initialized
	andi $t1,$t1,0xFFE1 		# Reset bits 4-1
	sw 	$t1,TRISE($t0) 		# Update TRISE register
	lw 	$t1,TRISB($t0) 		# Read TRISB register
	ori 	$t1,$t1,0x000e 		# Set bits 0000 0000 0000 1110
	sw 	$t1,TRISB($t0) 		# Update TRISB register
	
	li 	$t2,0 				#e.g. up counter (initial value is 0)
	li	$s0, 0				# variavel de controlo, se é inverso ou não
loop:

	lw	$t1, PORTB($t0)		# Verificar o valor de RD3
	srl	$s0, $s0, 3
	andi	$s0, $t1, 0x0001	
	
	lw $t1,LATE($t0) 			# Read LATE register
	andi $t1,$t1,0xFFE1 		# Reset bits 4-1
	sll $t3,$t2,1 				# Shift counter value to "position" 1
	or $t1,$t1,$t3 			# Merge counter w/ LATE value
	sw $t1,LATE($t0) 			# Update LATE register
	
	
	
	li 	$v0,RESET_CORE_TIMER
	syscall
wait:
	li 	$v0,READ_CORE_TIMER
	syscall
	
	blt 	$v0,4000000,wait 	# e.g. f=4.6Hz
	
	
if:		beq	$s0, 0, else
		addi	$t2, $t2, 1
		j	eif
else:
		addi $t2, $t2, -1
eif:
		andi $t2,	$t2,	0x000F 		# e.g. up counter MOD 16
		
		j	loop
	
	
eloop:
	jr 	$ra
	
	
