`timescale 1ns/1ps

module registers( 
	W,clk, WE, rW, rA, rB, 
	outA,outB
);
	input [31:0] W;
	input clk, WE;
	input [4:0] rA, rB, rW;
	output  [31:0] outA,outB;
	
	reg [31:0] registers[0:31];
	integer i;
	initial begin
    
    for(i=0;i<32;i=i+1)
        registers[i]=0;
	end
		always@ ( posedge clk )
        begin
        if (WE) begin
            registers[rW] = W;
            end
        end
        assign outA = registers[rA];
        assign outB = registers[rB];
	
endmodule 
