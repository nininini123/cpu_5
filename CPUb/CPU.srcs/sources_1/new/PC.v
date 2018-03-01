`timescale 1ns/1ps

module PC(
	in, en, clk, rst, 
	out
);
	
	input [31:0] in;
	input en, clk, rst;
	output reg [31:0] out;
	
	always@ ( posedge clk or posedge rst) begin
		if (rst) begin
			out = 0;
		end
		else begin
			if (en) begin
				out = in;
			end
		end
	end

endmodule