	## $t0 = a 
	## $t1 = b
	## $t2 = i
	## $t3 = j
	## $t4 = address de str1
	.data
	.eqv size,10
str1:	.space 10
str2:	.space 10
	.text
	.globl main
	
main:	
	li $v0,8
	la $a0,str1
	li $a1,size
	addi $a1,$a1,1 
	syscall ## read_string(str1, 25); 

	li $v0,5
	syscall
	add $t0,$v0,$0 ## a = read_int(); 
	li $v0,5
	syscall
	add $t1,$v0,$0 ## b = read_int(); 

	la $t4,str1 ## $t4 = address de str1
	li $t5,'\0'
	sb $t5,0($t4) ##  str2[0]='\0'; 
	add $t2,$0,$0 ##  i = 0;
	add $t3,$0,$0 ## j = 0; 
	
if:	ble $t1,$t0,endif
	
while1:
	add $t5,$t4,$t2 ## str1[i] address
	lb $t5,0($t5) ## str1[i] word (byte)
	li $t6,'\0' ## $t6 = char \0 
	
	bge $t2,$t0,endw1	
	beq $t5,$6,endw1
		
	addi $t2,$t2,1 ## i++; 
	j while1
endw1:	
while2:	
	add $t5,$t4,$t2 ## str1[i] address
	lb $t5,0($t5) ## str1[i] word (byte)
	li $t6,'\0' ## $t6 = char \0 
	
	bgt $t2,$t1,endw2
	beq $t5,$t6,endw2
	
	la $t7,str2 
	add $t7,$t7,$t3 ## str2[j++] address
	sb $t5,0($t7) ## str2[j++] = str1[i++]; 
	
	addi $t2,$t2,1 # i++
	addi $t3,$t3,1 # j++
	
	j while2
endw2:	
	la $t7,str2 
	add $t7,$t7,$t3 ## str2[j] address
	li $a0,'\0'
	sb $a0,0($t7)
endif:
	la $a0,str2 
	li $v0,4
	syscall