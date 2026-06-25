.data
msg1: .asciiz "Solution: "
msg2: .asciiz "\nNumber of calls: "

.text
.globl main

main:
    li.s $f13, 0.0 #constant 0 like $0
    li $t0, 0x37000000
    mtc1 $t0, $f30   #2^-17

    li.s $f1, 0.0 #x0
    li.s $f2, 1.0 #x1

    add $s0, $0, $0 #calls

    loop:
        addi $s0, $s0, 1
        add.s $f12, $f1, $f2
        li.s $f14, 2.0
        div.s $f12, $f12, $f14
        jal f #argument x2 in $f12, return value in $f0

        abs.s $f4, $f0
        c.le.s 0, $f4, $f30 
        bc1t 0, exit_loop

        c.lt.s 1, $f0, $f13
        bc1f 1, else
        add.s $f1, $f12, $f13
        j end_loop

        else: 
            add.s $f2, $f12, $f13
            j end_loop
        
        end_loop: 
            j loop
        
    exit_loop:
        li $v0, 4
        la $a0, msg1
        syscall

        li $v0, 2
        syscall

        li $v0, 4
        la $a0, msg2
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 10
        syscall





f:
li.s $f0, 0.0
add.s $f0, $f0, $f12
mul.s $f6, $f12, $f12
add.s $f0,$f0, $f6
mul.s $f6, $f6, $f12
add.s $f0, $f0, $f6
li.s $f6, -1.5
add.s $f0, $f0, $f6
jr $ra

