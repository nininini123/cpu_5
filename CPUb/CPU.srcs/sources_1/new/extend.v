`timescale 1ns/1ps

module extend(Extendout,Extendin,sign,extend5);
	output [31:0]Extendout;
	input [15:0]Extendin;
	input extend5;
	input sign;

	wire [31:0]w1,w2,w3,w4;


	Extender_n #(16,32) Ext1(w1,Extendin);
	Extender_y #(16,32) Ext2(w2,Extendin);
	Extender_n #(5,32) Ext3(w3,Extendin[10:6]);

	mux2 #(32) mux2_1(w4,sign,w1,w2);
	mux2 #(32) mux2_2(Extendout,extend5,w4,w3);

endmodule
