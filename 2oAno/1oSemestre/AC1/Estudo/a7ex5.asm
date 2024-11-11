	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	
	.text
	
insert:	ble	$a2, $a3, else
	li	$v0, 1
	jr	$ra
else:	move	$t0, $a3
	sll	$t0, $t0, 2
	move	$t2, $a0
	addi	$t0, $t0, -4
	sll	$t3, $a2, 2
	addu	$t2, $t2, $t0
for:	blt	$t0, $t3, efor
	lw	$t1, 0($t2)
	sw	$t1, 4($t2)
	addi	$t2, $t2, -4
	addi	$t0, $t0, -4
	j	for
efor:	sw	$a1, 4($t2)
	
	li	$v0, 0
	jr	$ra
	
##################################################################
# Mapa de registos

# $t3 = *a

print:	sll	$t0, $a1, 2
	move	$t3, $a0			
	addu	$t1, $t3, $t0
	
for2:	bge	$t3, $t1, efor2
	lw	$a0, 0($t3)
	li	$v0, print_int
	syscall
	li	$a0, ','
	li	$v0, print_chr
	syscall
	addi	$t3, $t3, 4
	j	for2
efor2:	jr	$ra


###################################################################
#Mapa de registos

# $t0 = array
# $t1 = size
# $t2 = i



	.data
	
array:	.space	40
str1:	.asciiz	"\nSize of array: "
str2:	.asciiz "array["
str3:	.asciiz "] = "
str4:	.asciiz "Enter the value to be inserted: "
str5:	.asciiz "Enter the position: "
str6:	.asciiz "\nOriginal array: "
str7: 	.asciiz "\nModified array: "
	.text
	.globl main
	
main:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	la	$t0, array
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$t1, $v0
	move	$s1, $v0
	sll	$t8, $t1, 2
	li	$t2, 0
loop:	
	sll	$t9, $t2, 2
	bge	$t9, $t8, eloop
	la	$a0, str2
	li	$v0, print_string
	syscall
	move	$a0, $t2
	li	$v0, print_int
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	sw	$v0, 0($t0)
	addi	$t0, $t0, 4
	addi	$t2, $t2, 1
	j	loop
	
eloop:	la	$a0, str4
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$t5, $v0
	la	$a0, str5
	li	$v0, print_string
	syscall
	li	$v0, read_int
	syscall
	move	$t6, $v0
	la	$a0, str6
	li	$v0, print_string
	syscall
	la	$a0, array
	move	$a1, $t1
	move	$s1, $t1
	jal	print
	move	$t1, $s1
	la	$a0, array
	move	$a3, $t1
	move	$a1, $t5
	move	$a2, $t6
	jal	insert
	la	$a0, str7
	li	$v0, print_string
	syscall
	la	$a0, array
	move	$t1, $s1
	addi	$a1, $t1, 1
	jal	print
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 16
	jr	$ra
	
	
	
















	
	

	