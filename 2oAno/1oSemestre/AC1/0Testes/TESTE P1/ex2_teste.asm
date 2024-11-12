## n_even = $t0
## n_odd = $t1
## p1 =$t2
## p2 = $t3	
	
	.data
	.eqv size,3 ##N
a:	.space 12
b:	.space 12
	.text
	.globl main

main:	or $t0,$0,$0
	or $t1,$0,$0
	
	la $t2,a
	addi $t4,$t4,size
	sll $t4,$t4,2
	add $t4,$t4,$t2##  address a + N
	
for1:	bge $t2,$t4,endf1 ## p2 = b; p1 < (a + N)
	
	or $v0,$0,$0
	addi $v0,$v0,5 ## read_int
	
	syscall
	sw  $v0,0($t2) ##*p1=read_int(); 

	addi $t2,$t2,4 ## p1++ 
	j for1

endf1:	la $t2,a ## p1 = a
	la $t3,b ## p2 = b;
	
for2:	bge $t2,$t4,endf2 ## p1 < (a + N);

	lw $t5,0($t2)
	rem $t6,$t5,2 ## (*p1 % 2)
	
if1:	beq $t6,$0,else1 ## *p1 % 2) != 0 
	addi $t1,$t1,1 ## n_odd++; 
	sw $t5,0($t3) ## *p2++ = *p1; 
	addi $t3,$t3,4 ## *p2++ = *p1; 
	j endif1
	
else1:	addi $t0,$t0,1 ## else  n_evn++; 
	j endif1
	
endif1:	addi $t2,$t2,4 ## p1++ 
	j for2
	
endf2:	la $t3,b ## p2 = b
	la $t4,b
	or $t5,$0,$t1
	sll $t5,$t5,2
	add $t4,$t4,$t5 ## (b + n_odd)
for3:	bge $t3,$t4,endf3 ## p2 < (b + n_odd)

	lw $t6,0($t3)
	or $a0,$0,$t6
	li $v0,1
	syscall ##print_int10( *p2 ); 
	
	addi $t3,$t3,4	 ##  p2++ )
	j for3
	
endf3:	
	ori $v0,$0,$t0
	jr $ra


