# g3_1a.asm
# Mapa de registos:
# $t0 - soma
# $t1 - value
# $t2 - i
	.eqv print_int10,1
	.eqv print_str,4
	.eqv read_int,5
	
	.data
str1:	.asciiz "Introduz um numero: "
str2:	.asciiz "Valor ignorado.\n"
str3:	.asciiz "A soma dos positivos e': "

	.text
	.globl main
main:	li $t0,0			# soma = 0
	li $t2,0			# i = 0
	
for:	bge $t2,5,endf		# for(i=0, soma=0; i < 5; i++)
	la $a0,str1
	li $v0,print_str
	syscall			# print("Introduza um numero: ");
	li $v0,read_int
	syscall			# read_int();
	move $t1,$v0		# value = read_int();
	
	ble $t1,$0,else		# if(value > 0) {
	add $t0,$t0,$t1
	j endif
	
else:	la $a0,str2
	li $v0,print_str
	syscall			# print("Valor ignorado\n");
	
endif:	addi $t2,$t2,1		# i++;
	j for
	
endf:	la $a0,str3
	li $v0,print_str
	syscall
	or $a0,$0,$t0
	li $v0,print_int10
	syscall
	jr $ra
	
	
	