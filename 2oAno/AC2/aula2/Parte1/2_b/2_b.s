## algo está errado, não sei o quê

	.equ putChar,3
	.equ printInt,7
	.equ readCoreTimer,11
	.equ resetCoreTimer,12

    .data

 	.text
	.globl main
main:
	addiu $sp,$sp,-8
	sw $ra,0($sp)
	sw $s0,4($sp)

	li $s0,0		# counter = 0

while:				
	li $a0,'\r'
	li $v0,putChar
	syscall			# putChar('\r')
	
	lui $a1,4
	ori $a1,10
	move $a0,$t0
	li $v0,printInt
	syscall	

	li $a0,10                       ## alteração
	jal delay		# delay(10)
    addi $s0,$s0,1	# counter++
    j while			# while(1)      ## ??

endw:	
	li $v0,0

	lw $ra,0($sp)
	lw $s0,4($sp)
	addiu $sp,$sp,8

	jr $ra			# return 0


###############################################


# void delay(unsigned int ms)
	.text
delay:
	move $t0,$a0	# ms

	li $v0,resetCoreTimer
	syscall			# resetCoreTimer()

while2:
	li $v0,readCoreTimer
	syscall
	mul $t1,$t0,20000	    # k * ms  (k = 20 000)
	blt $v0,$t1,while2

	jr $ra			# return