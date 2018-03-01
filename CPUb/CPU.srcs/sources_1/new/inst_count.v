module inst_count(all,if_y,if_n,if_r,halt,in_if,in_noif,in_r,clk,rst);//指令计数模块
	output  [15:0] all;//总周期数
	output  [15:0] if_y;//有条件分支指令数
	output  [15:0] if_n;//无条件分支指令数
	output  [15:0] if_r;//有条件分支成功跳�?
	input halt;
	input in_if;//条件分支
	input in_noif;//无条件分�?
	input in_r;//成功转移
	input clk;
	input rst;
	Reg_16 reg1 (all,all+16'd1,clk,rst,halt);//总周期数
	Reg_16 reg2 (if_y,if_y+16'd1,clk,rst,in_if&halt);//有条件分支指令数
	Reg_16 reg3 (if_n,if_n+16'd1,clk,rst,in_noif&halt);//无条件分支指令数
	Reg_16 reg4 (if_r,if_r+16'd1,clk,rst,in_r&halt);//有条件分支成功跳�?

endmodule