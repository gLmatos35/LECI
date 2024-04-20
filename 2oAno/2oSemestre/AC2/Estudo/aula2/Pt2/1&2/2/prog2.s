## traduçao do 1
        .equ inkey,1
        .equ putChar,3
        .equ printInt,6
        .equ readCoreTimer,11
        .equ resetCoreTimer,12

        .data

        .text
        .globl main
main:   addiu $sp,$sp,-20
        sw $s0,0($sp)
        sw $s1,4($sp)
        sw $s2,8($sp)
        sw $s3,12($sp)
        sw $s4,16($sp)

        li $s0,0                # cnt1 = 0;
        li $s1,0                # cnt5 = 0;
        li $s2,0                # cnt10 = 0;
        li $s4,1                # freq_mult = 1;



while:
        li $v0,inkey
        syscall
        move $s3,$v0            # inkey();

if3:    bne $s3,'a',if4
        mul $s4,$s4,2           # freq_mult *= 2;
        j next

if4:    bne $s3,'n',next
        li $s4,1                # freq_mult = 1;

next:
        bne $s3,'s',exit
stop:   li $v0,inkey
        syscall
        beq $v0,'r',exit

        j stop

exit:

        li $a0,'\r'
        li $v0,putChar
        syscall                 # putChar('\r');

        move $a0,$s0
        li $a1,10
        li $t0,5
        sll $t0,$t0,16
        or $a1,$a1,$t0          # 10 | 5 << 16
        li $v0,printInt
        syscall                 # printInt(cnt1,10 | 5 << 16);

        li $a0,'\t'
        li $v0,putChar
        syscall                 # putChar('\t');       


        move $a0,$s1
        li $a1,10
        li $t0,5
        sll $t0,$t0,16
        or $a1,$a1,$t0          # 10 | 5 << 16
        li $v0,printInt
        syscall                 # printInt(cnt5,10 | 5 << 16);

        li $a0,'\t'
        li $v0,putChar
        syscall                 # putChar('\t');

        move $a0,$s2
        li $a1,10
        li $t0,5
        sll $t0,$t0,16
        or $a1,$a1,$t0          # 10 | 5 << 16
        li $v0,printInt
        syscall                 # printInt(cnt10,10 | 5 << 16);

        li $a0,100
        div $a0,$a0,$s4         
        jal delay               # delay(100);

        addi $s2,$s2,1          # cnt10++;

if1:    rem $t0,$s2,2           # cnt10%2
        bne $t0,0,endifs
        addi $s1,$s1,1          # cnt5++;

if2:    rem $t0,$s2,10          # cnt10%10
        bne $t0,0,endifs
        addi $s0,$s0,1          # cnt1++;

endifs: 
        j while

        lw $s0,0($sp)
        lw $s1,4($sp)
        lw $s2,8($sp)
        lw $s3,12($sp)
        lw $s4,16($sp)
        addiu $sp,$sp,20

        li $v0,0                # return 0;

        jr $ra



####### delay
        .text
delay:  move $t0,$a0            # int ms;

        li $v0,resetCoreTimer
        syscall                 # resetCoreTimer();

whileD: li $v0,readCoreTimer
        syscall
        move $t1,$v0            # readCoreTimer();

        mul $t2,$t0,20000       # int ms * 20000

        bge $t1,$t2,endwd
        j whileD

endwd:  
        jr $ra


## talvez funcione idk
