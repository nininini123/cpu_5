#############################################################
#�ж���ʾ���򣬼�����Ʋ��ԣ�����1�ż�������1ѭ����λ����
#�ж���ʾ���򣬼�����Ʋ��ԣ�����2�ż�������2ѭ����λ����
#���Ҳ���ʾ������ѭ������
#��ֻ���жϷ��������ʾ���򣬷����Ҽ���ж�Ƕ�ף�
#���ʱ��Ҫ���ǿ��жϣ����жϣ������ж���������������ָ��ʵ�֣���α����ֳ����ж���ָ����Ҫ��������
#############################################################
.text

mfc0 $2,$1#���ж�
addi $s6,$zero,3       #�жϺ�1,2,3   ��ͬ�жϺ���ʾֵ��һ��

addi $s4,$zero,6      #ѭ��������ʼֵ  
addi $s5,$zero,1       #�������ۼ�ֵ
###################################################################
#                �߼����ƣ�ÿ����λ4λ 
# ��ʾ����������ʾ0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 ����ѭ��6��
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
sub $s4,$s4,$s5      #ѭ�������ݼ�
bne $s4, $zero, IntLoop

addi   $v0,$zero,10         # system call for exit
syscall                  # we are out of here. 

#----------------------------------------------------

mfc0 $2,$0#���ж� 233

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

add $a0, $zero, $zero   #��ʾ00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #ѭ��8��
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

mfc0 $2,$1#���ж�
eret#�жϷ���

#�ж�2������������ʾ1������ƣ���00000000��Ϊ11111111
.text
mfc0 $2,$0#���ж�

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

add $a0, $zero, $zero   #��ʾ00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #ѭ��8��
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

mfc0 $2,$1#���ж�
eret#�жϷ���

#�ж�3������������ʾ1������ƣ���00000000��Ϊ11111111
.text
mfc0 $2,$0#���ж�

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

add $a0, $zero, $zero   #��ʾ00000000
addi $v0, $zero, 34
syscall

add $s0, $zero, $zero
addi $t0, $t0, 8  #ѭ��8��
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

mfc0 $2,$1#���ж�
eret#�жϷ���

