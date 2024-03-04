		.equ 	ADDR_BASE_HI, 0xBF88 		# Base address: 16 MSbits
		.equ 	TRISE, 0x6100  			# TRISE address is 0xBF886100
		.equ		TRISB, 0x6040
		.equ 	LATE, 0x6120 				# LATE address is 0xBF886120
		.equ		PORTB, 0x6050
		.equ		print_int, 6
		
		
		.data
		.text
		.globl main
		
main:

		lui 	$t1, ADDR_BASE_HI 		# $t1=0xBF880000
		lw 	$t2, TRISE($t1) 		# READ (Mem_addr = 0xBF880000 + 0x6100)
		andi	$t2, $t2, 0xfffe
		sw 	$t2, TRISE($t1) 		# WRITE (Write TRISE register)
		
		
		lw	$t3, TRISB($t1)
		ori	$t3, $t3, 0x0001
		sw	$t2, TRISB($t1)
		
loop:	lw	$t2, LATE($t1)
		lw	$t3, PORTB($t1)
		
		andi	$t2, $t2, 0xfffe
		andi	$t3, $t3, 0x0001
		
		or	$t2, $t2, $t3
		sw	$t2, LATE($t1)
		j	loop
		
eloop:
		jr	$ra
		
		
