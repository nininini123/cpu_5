# 用于测试 xor xori lbu 和 BGTZ
# 预期输出: ffffffff -> ff -> fe -> fc -> f8 -> f0 -> e0 -> c0 -> 80 -> 00

# s1 = 0xffffffff


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
bgtz $s1,Loop  # s1 寄存器的值大于0则继续循环 为0则结束程序

#end
addi   $v0,$zero,10
syscall


##############################################################
#			程序说明
#
# 该程序首先将0xffff_ffff由寄存器加载进内存，然后使用LBU指令将其低八位加载至寄存器S1，即是 0xff.
# 该程序将0x0ff，即二进制的1111 依次与 二进制的
#		00000001，
#		00000010，
#		00000100，
#		00001000，
#		00010000，
#		00100000，
#		01000000，
#		10000000，
#		异或并打印出来，
# 测试正确的输出结果应是
#		11111111,
#		11111110,
#		11111100,
#		11111000,
#		11110000,
#		11100000,
#		11000000,
#		10000000,
#		00000000
#	依次输出，
#	即是 ff,fe,fc,f8,f0,e0,c0,80,00。
# 该程序总周期数较少，建议使用低频(32Hz)模拟,以观察输出。
##############################################################

