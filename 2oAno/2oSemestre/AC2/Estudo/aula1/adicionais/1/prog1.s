        .equ UP,1
        .equ DOWN,0
        .equ inkey,1
        .equ putChar,3
        .equ printInt,6
        
        .data

        .text
        .globl main
main:   addiu $sp,$sp,-12
        sw $s0,0($sp)
        sw $s1,4($sp)
        sw $s2,8($sp)

        li $s0,0                # int state = 0;
        li $s1,0                # int cnt = 0;

do:     li $a0,'\r'
        li $v0,putChar
        syscall                 # putChar('\r');

        move $a0,$s1
        li $a1,10
        li $t0,3
        sll $t0,$t0,16          # 3 << 16
        or $a1,$a1,$t0          # 10 | 3 << 16
        li $v0,printInt
        syscall                 # printInt(value, 10 | 3 << 16);

        li $a0,'\t'
        li $v0,putChar
        syscall                 # putChar('\t');

        move $a0,$s1
        li $a1,2
        li $t0,8
        sll $t0,$t0,16          # 8 << 16
        or $a1,$a1,$t0          # 2 | 8 << 16
        li $v0,printInt
        syscall                 # printInt(10 | 3 << 16);

        li $a0,5
        jal wait                # wait(5);

        li $v0,inkey
        syscall                 # inkey();
        move $s2,$v0

state:
if:     bne $s2,'+',if2
        li $s0,UP               # state = UP;
        j endstate

if2:    bne $s2,'-',endstate
        li $s0,DOWN
        j endstate

# if4:    bne $s2,'s',if5


endstate:

if3:    bne $s0,UP,else3
        addi $s1,$s1,1          # cnt += 1;
        andi $s1,$s1,0xFF       # cnt = (cnt + 1) & 0xFF;
        j endif3

else3:  addi $s1,$s1,-1         # cnt -= 1;
        andi $s1,$s1,0xFF       # cnt = (cnt -1 1) & 0xFF;

endif3: 
while:  bne $s2,'q',do          # while (c != 'q');

        li $v0,0                # return 0;

        lw $s0,0($sp)
        lw $s1,4($sp)
        lw $s2,8($sp)
        addiu $sp,$sp,12

        jr $ra


################################################
# void wait(int ts)
        .text
wait:   addiu $sp,$sp,-4
        sw $s0,0($sp)

        move $s0,$a0            # int ts;

        li $t0,0                # i = 0;
        mul $t1,$s0,515000      # 515000 * ts;
for:    bge $t0,$t1,endf
        addi $t0,$t0,1          # i++;
        j for

endf:   
        jr $ra
  
        lw $s0,0($sp)
        addiu $sp,$sp,4
       

## nao terminei o b), caguei, existe algum erro com o input nao sei
