`timescale 1ns/1ps

module mux2(out,sel,d0,d1);
	parameter width=2; //数据位宽,参数修改
	output  reg [width-1:0] out;
	input	[width-1:0] d0,d1;
	input	sel;
always @(*)
	begin
		case(sel)
		1'b0: out=d0;
		1'b1: out=d1;
		endcase
	end
endmodule

module mux4(out,sel,d0,d1,d2,d3);
	parameter width=2;
	output  reg [width-1:0] out;
	input	[width-1:0] d0,d1,d2,d3;
	input	sel;
always @(*)
	begin
		case(sel)
		2'b00: out=d0;
		2'b01: out=d1;
		2'b10: out=d2;
		2'b11: out=d3;
		endcase
	end
endmodule
