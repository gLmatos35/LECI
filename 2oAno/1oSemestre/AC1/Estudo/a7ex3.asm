	.eqv	print_int, 1
	.eqv	read_int, 5
	.eqv 	read_string, 8
	.eqv 	print_string, 4
	.eqv	print_chr, 11
	.eqv	SIZE, 30
	
	.text
	
strcpy:
	move	$v0, $a0
	
do:	lb	$t1, 0($a1)
	sb	$t1, 0($a0)
	addiu	$a1, $a1, 1
	addiu	$a0, $a0, 1
	bne	$t1, $0, do
edo:	jr	$ra

##########################################################################
	.text	
exchange:
	lb 	$t0, 0($a0)
	lb 	$t1, 0($a1)
	sb 	$t1, 0($a0)
	sb 	$t0, 0($a1)
	jr 	$ra
	
strrev:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$s0, 12($sp)
	
	move	$s0, $a0
	move	$s1, $a0
	move	$s2, $a0
	
while:	lb	$t0, 0($s2)
	beq	$t0, $0, ewhile
	addi	$s2, $s2, 1
	j	while
ewhile:	addi	$s2, $s2, -1

while2:	bge	$s1, $s2, ewhil2
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange
	addi	$s1, $s1, 1
	addi	$s2, $s2, -1
	j	while2
ewhil2:	move	$v0, $s0
	lw	$ra, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s0, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra	


##########################################################################
	.text
strlen:	move	$t0, $a0
	li	$t1, 0
whi:	lb	$t2, 0($t0)
	beq	$t2, $0, ewhi
	addi	$t1, $t1, 1
	addi	$t0, $t0, 1
	j	whi
ewhi:	move	$v0, $t1
	jr	$ra
	
	.data
	
str1:	.asciiz	"I serodatupmoC ed arutetiuqrA"
str2:	.space	31
str3:	.asciiz	"\n"
str4:	.asciiz	"String demasiado longa"
	.text
	.globl main

main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	li	$s0, 0
	li	$s1, SIZE
	la	$a0, str1
	jal	strlen
if:	bgt	$v0, $s1, else
	la	$a0, str2
	la	$a1, str1
	jal	strcpy
	move	$s2, $v0
	move	$a0, $v0
	li	$v0, print_string
	syscall
	la	$a0, str3
	li	$v0, print_string
	syscall
	move	$a0, $s2
	jal	strrev
	move	$a0, $v0
	li	$v0, print_string
	syscall
	li	$s0, 0
	j	end
	
else:	la	$a0, str4
	li	$v0, print_string
	syscall
	la	$a0, str1
	jal	strlen
	move	$a0, $v0
	li	$v0, print_int
	syscall
	li	$s0, -1
end:	
	lw	$ra, 0($sp)
	move	$v0, $s0
	jr	$ra
	












