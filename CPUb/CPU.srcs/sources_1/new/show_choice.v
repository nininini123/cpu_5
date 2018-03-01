`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/27 15:38:41
// Design Name: 
// Module Name: show_choice
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module show_choice (SEG,AN,in0,in1,in2,in3,in4,clk,en,on1,on2,on3,on4);
	output [7:0] SEG,AN;
	input en;
	input clk;
	input [31:0] in0;//Syscallout
	input [15:0] in1;//总周期数
	input [15:0] in2;//无条件分支指令数
	input [15:0] in3;//有条件分支指令数
	input [15:0] in4;//有条件分支成功跳�?
	input on1,on2,on3,on4;

	wire [31:0]in1_32,in2_32,in3_32,in4_32;
	reg [31:0] in;

	Extender_y #(16,32) ext1 (in1_32,in1);
	Extender_y #(16,32) ext2 (in2_32,in2);
	Extender_y #(16,32) ext3 (in3_32,in3);
	Extender_y #(16,32) ext4 (in4_32,in4);
	divider #(50000)d5w(clk, clk_N);
	display dis (in,clk_N,en,on1|on2|on3|on4,SEG,AN);


	always @(*) begin
		if (on1) begin
			in=in1_32;
		end
		else if (on2) begin
			in=in2_32;
		end
		else if (on3) begin
			in=in3_32;
		end
		else if (on4) begin
			in=in4_32;
		end
		else begin
			in=in0;
		end
	end
	

endmodule