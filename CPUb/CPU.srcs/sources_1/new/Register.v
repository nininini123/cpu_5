`timescale 1ns/1ps

module Reg_1(out,in,clk,rst,en);
	output  reg out;
	input in;
	input clk;
	input rst;
	input en;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			out = 0;
		end
		else if (en) begin
			out = in;
		end
	end
endmodule

module Reg_16(out,in,clk,rst,en);
	output  reg [15:0] out;
	input [15:0]in;
	input clk;
	input rst;
	input en;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			out = 0;
		end
		else if (en) begin
			out = in;
		end
	end
endmodule

module Reg_32(out,in,clk,rst,en);
	output  reg [31:0] out=0;
	input [31:0]in;
	input clk;
	input rst;
	input en;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			out = 0;
		end
		else if (en) begin
			out = in;
		end
	end
endmodule
