.data
file_path: .asciiz "/home/sreeja/aaa_stuff/q1_input.txt"
.align 2
histogram: .space 44 #44 bytes for the 11 elements, each automatically initialized to 0 in spim
msg: .asciiz "Histogram:\n"
char: .space 1
.text
.globl main

main:
    la $s1, histogram #$s1 now stores address of histogram

    li $v0, 13
    la $a0, file_path
    li $a1, 0
    li $a2, 0
    syscall

    # the registers are set for opening file present in file_path, then syscall called
    #now $a0 contains file descriptor, we shall use this to read from the file

    move $s0, $v0 # s0 now contains file descriptor

    add $t0, $0, $0

    create_hist:
        li $v0, 14
        add $a0, $0, $s0
        la $a1, char
        li $a2, 1
        syscall 

        blez $v0, exit_loop1
        lb $t1, char
        li $t2, 10
        beq $t1, $t2, update_hist
        addi $t2, $t1, -48
        mul $t0, $t0, 10
        add $t0, $t0, $t2
        j create_hist

        update_hist: 
            beq $t0, $0, exit_loop1
            slti $t1, $t0, 101
            bne $t1, $0, else
            lw $t2, 40($s1)
            addi $t2, $t2, 1
            sw $t2, 40($s1)
            j end_update
        
        else:
            li $t1, 10
            addi $t0, $t0, -1
            div $t2, $t0, $t1
            mflo $t1
            sll $t1, $t1, 2
            add $t3, $t1, $s1
            lw $t4, 0($t3)
            addi $t4, $t4, 1
            sw $t4, 0($t3)
        
        end_update: 
            add $t0, $0, $0
            j create_hist


    exit_loop1:
            li $v0 4
            la $a0 msg
            syscall

            add $t0, $0, $0

            print:
                slti $t1, $t0, 10
                beq $t1, $0, exit_print
                #t2=10i+1
                mul $t2, $t0, 10
                addi $t2, $t2, 1
                #t3=10(i+1)
                addi $t3, $t0, 1
                mul $t3, $t3, 10

                #print [

                li $v0, 11
                li $a0, 91
                syscall

                #print t2
                li $v0, 1 
                move $a0, $t2
                syscall

                #print , 
                li $v0, 11
                li $a0, 44
                syscall


                #print t3
                li $v0, 1 
                move $a0, $t3
                syscall

                #print ]
                li $v0, 11
                li $a0, 93
                syscall


                #print :
                li $v0, 11
                li $a0, 58
                syscall

                #print hist[i]
                sll $t2, $t0, 2
                add $t2, $t2, $s1
                lw $t2, 0($t2)
                li $v0, 1 
                move $a0, $t2
                syscall

                #print \n
                li $v0, 11
                li $a0, 10
                syscall

                addi $t0, $t0, 1
                j print


    exit_print:

        #print >
        li $v0, 11
        li $a0, 62
        syscall

        #print 100
        li $v0, 1
        li $a0, 100
        syscall

        #print :
        li $v0, 11
        li $a0, 58
        syscall

        #print hist[10]
        addi $t2, $s1, 40
        lw $t2, 0($t2)
        li $v0, 1 
        move $a0, $t2
        syscall


        li $v0, 16
        move $a0, $s0
        syscall

        li $v0, 10
        syscall

