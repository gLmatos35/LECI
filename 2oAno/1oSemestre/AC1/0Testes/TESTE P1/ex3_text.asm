## i = $t0
## v = $t1
## val = $t2 address
	
	.data
	.eqv SIZE 8
val:    .word 8,4,15,-1987,327,-9,27,16
str1:	.asciiz "Result is: \n"
	.text
	.globl main
	
main:	or $t0,$0,$0

do:	la $t2,val ## address
	sll $t3,$t0,2 ## i*4
	add $t4,$t3,$t2 ## address + i*4	
	lw $t1,0($t4) ## v = val[i]; (numero)
	
	addi $t5,$0,SIZE ## +SIZE
	sra $t5,$t5,1 ## SIZE / 2
	add $t5,$t5,$t0 ## i+SIZE/2]
	sll $t5,$t5,2 ## i+SIZE/2]*4
	add $t5,$t2,$t5 ## (i+SIZE/2)*4 + address	
	lw $t6,0($t5) ## (i+SIZE/2)*4 + address (numero)
	
	sw $t6,0($t4) ## val[i] = val[i+SIZE/2]; 
	sw $t1,0($t5) ## val[i+SIZE/2] = v; 

	addi $t7,$0,SIZE ## +SIZE
	srl $t7,$t7,1 ## SIZE / 2
	addi $t0,$t0,1
	
	blt $t0,$t7,do ##  while(++i < SIZE / 2);
	
	ori $v0,$0,4
	la $a0,str1
	syscall
	
	or $t0,$0,$0 ## i = 0
	ori $t4,$0,SIZE ## size
	
do2:	sll $t1,$t0,2 ## i*4
	add $t3,$t2,$t1 ## address + i*4
	
	ori $v0,$0,1
	lw $a0,0($t3) ## print num
	syscall
	addi $t0,$t0,1
			
	li $a0,','
	ori $v0,$0,11 ## print ","
	syscall
	blt $t0,$t4,do2
	
	
	
		