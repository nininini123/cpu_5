`timescale 1ns/1ps
module mem(read_data,addr);
input [9:0] addr;
output [31:0] read_data;
reg [31:0] read_data;
reg [31:0] mem[0:1023];
initial 
begin
	$readmemh("D:\\CPU\\benchmark.txt",mem);
	end
always@(addr)
	read_data<=mem[addr];
endmodule