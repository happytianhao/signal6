######## Prepare Memory ########
lui $s0,0x1000
ori $s0,$s0,0x1008
sw $s0,0($0)
lui $s0,0x1000
ori $s0,$s0,0x1002
sw $s0,4($0)
lui $s0,0x8000
ori $s0,$s0,0x1001
sw $s0,8($0)
lui $s0,0x1000
ori $s0,$s0,0x1005
sw $s0,12($0)
lui $s0,0x8000
ori $s0,$s0,0x1000
sw $s0,16($0)
######## Selection Sort ########
addi $t0,$0,16
LOOP1:
add $t1,$t0,$0
add $t2,$t0,$0
lw $s2,0($t2)
LOOP2:
addi $t1,$t1,-4
lw $s1,0($t1)
slt $s0,$s2,$s1
beq $s0,$0,LABEL
add $s2,$s1,$0
add $t2,$t1,$0
LABEL:
bne $t1,$0,LOOP2
lw $s1,0($t0)
sw $s2,0($t0)
sw $s1,0($t2)
addi $t0,$t0,-4
bne $t0,$0,LOOP1