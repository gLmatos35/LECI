	.equ putChar,3
	.equ printInt,7
	.equ readCoreTimer,11
	.equ resetCoreTimer,12

     .data

 	.text
	.globl main
main:
	addiu $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)		# cnt10
	sw $s1, 8($sp)      # cnt5
	sw $s2, 12($sp)     # cnt1

	li $s0,0		# counter = 0

while:
	 li	$a0, '\r'
	 li	$v0, putChar
	 syscall
	 move    $a0, $s0         
      lui $a1, 4
      ori $a1, 10
      li	$v0, print_int
      syscall
      li  $a0, '\t'
      li  $v0, putChar
      syscall
	 move    $a0, $s1         
      lui $a1, 4
      ori $a1, 10
      li	$v0, print_int
      syscall
      li  $a0, '\t'
      li  $v0, putChar
      syscall
	 move    $a0, $s2         
      lui $a1, 4
      ori $a1, 10
      li	$v0, print_int
      syscall
      
      li	$a0, 10
      jal delay
	 addiu $s0, $s0, 1
	 
	 rem $t0, $s0, 2
	 bnez $t0, endz5
	 addi $s1, $s1, 1
	 
endz5: rem $t0, $s0, 10
	


	 addiu $s0, $s0, 1
if1:  rem	  $t0, $s0, 2
	 bnez
	 
	 j while
	 
	 lw $ra, 0($sp)
	 lw $s0, 4($sp)
	 lw $s1, 8($sp)      # cnt5
	 lw $s2, 12($sp)     # cnt1
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
	 
