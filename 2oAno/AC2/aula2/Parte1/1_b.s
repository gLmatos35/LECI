	.equ putChar,3
	.equ printInt,7
	.equ readCoreTimer,11
	.equ resetCoreTimer,12

 	.text
	.globl main

main:	li $t0,0		# counter = 0

while:				
	li $a0,'\r'
	li $v0,putChar
	syscall			# putChar('\r')
	
	lui $a1,4
	ori $a1,10
	move $a0,$t0
	li $v0,printInt
	syscall	

	li $v0,resetCoreTimer
	syscall			# resetCoreTimer()

while1:	li $v0,readCoreTimer
	syscall
	blt $v0,200000,while1
	addi $t0,$t0,1		# counter++
	j while
endw1:
	

endw:	li $v0,0
	jr $ra			# return 0
	

	