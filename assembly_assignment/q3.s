.data


.text
.globl main

main:
li.s $f30, 0.0 #$0
li $s0, 10 #change for lower or higher precision
li $v0, 6
syscall #now x loaded in f0

add.s $f12, $f0, $f30 #moved x to f12

li.s $f6, 180.0
div.s $f12, $f12, $f6
li $t0, 0x40490fdb
mtc1 $t0, $f6
mul.s $f12, $f12, $f6

jal sin #return value in $f0
jal cos #return value in $f1

div.s $f12, $f0, $f1 #tan=sin/cos

li $v0, 2
syscall

li $v0, 11
li $a0, 10
syscall

li $v0, 10
syscall



sin:
add.s $f0, $f12, $f30
li.s $f7, 1.0 #factorial in f7
add.s $f8, $f12, $f30 #powx in f8

addi $t0, $0, 1 #i in t0

sinloop:
slt $t1, $t0, $s0
beq $t1, $0, exit_sin

#powx=powx*x*x
mul.s $f8, $f8, $f12
mul.s $f8, $f8, $f12

#fact=fact*2i*2i+1
mtc1 $t0, $f9
cvt.s.w $f9, $f9
li.s $f6, 2.0
mul.s $f9, $f9, $f6 #2i
mul.s $f7, $f7, $f9
li.s $f6, 1.0
add.s $f9, $f9, $f6 #2i+1
mul.s $f7, $f7, $f9

div.s $f9, $f8, $f7 #powx/fact

addi $t1, $0, 2
div $t0, $t1
mfhi $t1
beq $t1, $0, even
sub.s $f0, $f0, $f9

addi $t0, $t0, 1
j sinloop

even: 
add.s $f0, $f0, $f9

addi $t0, $t0, 1
j sinloop

exit_sin:
jr $ra

cos:
li.s $f1, 1.0
li.s $f7, 1.0 #factorial in f7
li.s $f8, 1.0

addi $t0, $0, 1 #i in t0

cosloop:
slt $t1, $t0, $s0
beq $t1, $0, exit_cos

#powx=powx*x*x
mul.s $f8, $f8, $f12
mul.s $f8, $f8, $f12

#fact=fact*2i*2i+1
mtc1 $t0, $f9
cvt.s.w $f9, $f9
li.s $f6, 2.0
mul.s $f9, $f9, $f6 #2i
mul.s $f7, $f7, $f9
li.s $f6, 1.0
sub.s $f9, $f9, $f6 #2i-1
mul.s $f7, $f7, $f9

div.s $f9, $f8, $f7 #powx/fact

addi $t1, $0, 2
div $t0, $t1
mfhi $t1
beq $t1, $0, even2
sub.s $f1, $f1, $f9

addi $t0, $t0, 1
j cosloop

even2: 
add.s $f1, $f1, $f9

addi $t0, $t0, 1
j cosloop

exit_cos:
jr $ra

