#############################################################
#中断演示程序，简单走马灯测试，按下1号键用数字1循环移位测试
#中断演示程序，简单走马灯测试，按下2号键用数字2循环移位测试
#最右侧显示数据是循环计数
#这只是中断服务程序演示程序，方便大家检查中断嵌套，
#设计时需要考虑开中断，关中断，设置中断屏蔽字如何用软件指令实现，如何保护现场，中断隐指令需要多少周期
#############################################################
.text

mfc0 $2,$1#开中断
addi $s6,$zero,3       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值
###################################################################
#                逻辑左移，每次移位4位 
# 显示区域依次显示0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 依次循环6次
###################################################################
IntLoop:
add $s0,$zero,$s6   

IntLeftShift:       


sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, IntLeftShift
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, IntLoop

addi   $v0,$zero,10         # system call for exit
syscall                  # we are out of here. 

#----------------------------------------------------

mfc0 $2,$0#关中断 233

addi $sp,$0,0x01000

addiu $sp,$sp,-4
sw $a0 ,0($sp)
addiu $sp,$sp,-4
sw $v0 ,0($sp)
addiu $sp,$sp,-4
sw $s0 ,0($sp)
addiu $sp,$sp,-4
sw $t0 ,0($sp)
addiu $sp,$sp,-4
sw $t1 ,0($sp)

add $a0, $zero, $zero   #显示00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #循环8次
addi $t1, $zero, 1

zhongduan1:
sll $s0, $s0, 4
ori $s0, $s0, 1
addu $a0, $zero, $s0  # display $s3
syscall          # display 

sub $t0, $t0, $t1
bne $t0, $zero, zhongduan1

lw $t1 ,0($sp)
addiu $sp,$sp,4
lw $t0 ,0($sp)
addiu $sp,$sp,4
lw $s0 ,0($sp)
addiu $sp,$sp,4
lw $v0 ,0($sp)
addiu $sp,$sp,4
lw $a0 ,0($sp)
addiu $sp,$sp,4

mfc0 $2,$1#开中断
eret#中断返回

#中断2：从右往左显示1的走马灯，从00000000变为11111111
.text
mfc0 $2,$0#关中断

addi $sp,$0,0x01000

addiu $sp,$sp,-4
sw $a0 ,0($sp)
addiu $sp,$sp,-4
sw $v0 ,0($sp)
addiu $sp,$sp,-4
sw $s0 ,0($sp)
addiu $sp,$sp,-4
sw $t0 ,0($sp)
addiu $sp,$sp,-4
sw $t1 ,0($sp)

add $a0, $zero, $zero   #显示00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #循环8次
addi $t1, $zero, 1

zhongduan2:
sll $s0, $s0, 4
ori $s0, $s0, 2
addu $a0, $zero, $s0  # display $s3
syscall          # display 

sub $t0, $t0, $t1
bne $t0, $zero, zhongduan2

lw $t1 ,0($sp)
addiu $sp,$sp,4
lw $t0 ,0($sp)
addiu $sp,$sp,4
lw $s0 ,0($sp)
addiu $sp,$sp,4
lw $v0 ,0($sp)
addiu $sp,$sp,4
lw $a0 ,0($sp)
addiu $sp,$sp,4

mfc0 $2,$1#开中断
eret#中断返回

#中断3：从右往左显示1的走马灯，从00000000变为11111111
.text
mfc0 $2,$0#关中断

addi $sp,$0,0x01000

addiu $sp,$sp,-4
sw $a0 ,0($sp)
addiu $sp,$sp,-4
sw $v0 ,0($sp)
addiu $sp,$sp,-4
sw $s0 ,0($sp)
addiu $sp,$sp,-4
sw $t0 ,0($sp)
addiu $sp,$sp,-4
sw $t1 ,0($sp)

add $a0, $zero, $zero   #显示00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #循环8次
addi $t1, $zero, 1

zhongduan3:
sll $s0, $s0, 4
ori $s0, $s0, 3
addu $a0, $zero, $s0  # display $s3
syscall          # display 

sub $t0, $t0, $t1
bne $t0, $zero, zhongduan3

lw $t1 ,0($sp)
addiu $sp,$sp,4
lw $t0 ,0($sp)
addiu $sp,$sp,4
lw $s0 ,0($sp)
addiu $sp,$sp,4
lw $v0 ,0($sp)
addiu $sp,$sp,4
lw $a0 ,0($sp)
addiu $sp,$sp,4

mfc0 $2,$1#开中断
eret#中断返回

