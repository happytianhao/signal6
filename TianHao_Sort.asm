######## Prepare Memory ########
lui $1,0x1000
ori $1,$1,0x1008
sw $1,0($0)
lui $1,0x1000
ori $1,$1,0x1002
sw $1,4($0)
lui $1,0x8000
ori $1,$1,0x1001
sw $1,8($0)
lui $1,0x1000
ori $1,$1,0x1005
sw $1,12($0)
lui $1,0x8000
ori $1,$1,0x1000
sw $1,16($0)
######## TianHao Sort ########
addi $t0,$0,16
LOOP1:
add $t1,$t0,$0
lw $s0,0($t0)
LOOP2:
addi $t1,$t1,-4
lw $s1,0($t1)
slt $1,$s0,$s1
beq $1,$0,LABEL
sw $s0,0($t1)
add $s0,$s1,$0
LABEL:
bne $t1,$0,LOOP2
sw $s0,0($t0)
addi $t0,$t0,-4
bne $t0,$0,LOOP1