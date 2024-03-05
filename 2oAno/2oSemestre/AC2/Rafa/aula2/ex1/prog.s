
	 .equ putChar, 3
	 .equ print_int, 6
	 .equ READ_CORE_TIMER,11
	 .equ RESET_CORE_TIMER,12


	.data
	.text
	.globl main
	
	
main: li $t0, 0
	
while:
	 bne $t0, $t0 , ewhile
	 li	$a0, '\r'
	 li	$v0, putChar
	 syscall
	 move    $a0, $t0         
      lui         $a1, 4
      ori         $a1, 10
      li	$v0, print_int
      syscall
      
	 li $v0,RESET_CORE_TIMER 
	 syscall
whi:  li $v0, READ_CORE_TIMER
	 syscall
	 blt $v0, 200000, whi
	 
ewhi: addiu $t0, $t0, 1
	 j while
	 
ewhile:
	 jr $ra
	
