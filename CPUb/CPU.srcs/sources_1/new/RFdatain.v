`timescale 1ns/1ps

module RFdatain(RFin,ALUresult,Memout,PC4,MemtoReg,jal);
	output [31:0] RFin;
	input [31:0] ALUresult;
	input [31:0] Memout;
	input [31:0] PC4;
	input MemtoReg;
	input jal;
	
	wire [31:0] w1;

	mux2 #(32) mux2_1 (w1,MemtoReg,ALUresult,Memout);
	mux2 #(32) mux2_2 (RFin,jal,w1,PC4);

endmodule