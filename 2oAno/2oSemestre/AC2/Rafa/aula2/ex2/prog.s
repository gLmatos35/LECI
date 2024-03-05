
	 .equ putChar, 3
	 .equ print_int, 6
	 .equ READ_CORE_TIMER,11
	 .equ RESET_CORE_TIMER,12


	.data
	.text
	.globl main
	
	
main: addiu $sp, $sp, -8
	 sw $ra, 0($sp)
	 sw $s0, 4($sp)
	 li $s0, 0
	 
while:
	 li	$a0, '\r'
	 li	$v0, putChar
	 syscall
	 move    $a0, $s0         
      lui $a1, 4
      ori $a1, 10
      li	$v0, print_int
      syscall
      
      li	$a0, 10
      jal 	delay
      
#	 li $v0,RESET_CORE_TIMER           isto é o que estava anteriormente
#	 syscall
#whi: li $v0, READ_CORE_TIMER
#	 syscall
#	 blt $v0, 200000, whi


ewhi: addiu $s0, $s0, 1
	 j while
	 
	 lw $ra, 0($sp)
	 lw $s0, 4($sp)
	 addiu $sp, $sp, 8
	 li $v0, 0
	 jr $ra
	 
# ----------------------------------------------------------------------------------------
	.text
delay: 
	 li $v0,RESET_CORE_TIMER 
	 syscall
	 mul $t0, $a0, 20000
whil: li $v0, READ_CORE_TIMER
	 syscall
	 blt $v0, $t0, whil
	 
	 jr	$ra
	 
	 	 
	 	 
	 	 
#########

#Contador             | T(s)          | f(Hz)
#20 000 000		  | 1		   |1
#2 000 000		  | 0.1		   |10
#200 000			  | 0.001		   |100
#20 000			  | 0.0001(1 ms)  |1000

#(2**32 - 1) - 1 / 20 000 = 214748 ms de atraso
#					= 214.748 s de atraso
#					= 3.58 minutos de atraso
