# ���ڲ��� xor xori lbu �� BGTZ
# Ԥ�����: ffffffff -> ff -> fe -> fc -> f8 -> f0 -> e0 -> c0 -> 80 -> 00

# s1 = 0xffffffff

mfc0 $2,$1#���ж�

xori $s0,$zero,0x0
xori $s1,$zero,0x1
sub $s1, $s0,$s1
add $a0,$zero,$s1
addi   $v0,$zero,34 
syscall

# s1 = 0xff
sw $s1,0
lbu $s1,0
add $a0,$zero,$s1
addi   $v0,$zero,34 
syscall

addi $s0,$zero, 1
Loop:
xor $s1,$s1,$s0
add $a0,$zero,$s1
addi   $v0,$zero,34 
syscall
sll $s0, $s0,1
bgtz $s1,Loop  # s1 �Ĵ�����ֵ����0�����ѭ�� Ϊ0���������

#end
addi   $v0,$zero,10
syscall


##############################################################
#			����˵��
#
# �ó������Ƚ�0xffff_ffff�ɼĴ������ؽ��ڴ棬Ȼ��ʹ��LBUָ���Ͱ�λ�������Ĵ���S1������ 0xff.
# �ó���0x0ff���������Ƶ�1111 ������ �����Ƶ�
#		00000001��
#		00000010��
#		00000100��
#		00001000��
#		00010000��
#		00100000��
#		01000000��
#		10000000��
#		��򲢴�ӡ������
# ������ȷ��������Ӧ��
#		11111111,
#		11111110,
#		11111100,
#		11111000,
#		11110000,
#		11100000,
#		11000000,
#		10000000,
#		00000000
#	���������
#	���� ff,fe,fc,f8,f0,e0,c0,80,00��
# �ó��������������٣�����ʹ�õ�Ƶ(32Hz)ģ��,�Թ۲������
##############################################################


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

