`timescale 1ns / 1ps

module register_tb() ;
	reg clk,rst,butt_0,butt_1,butt_2,butt_3,butt_4;
wire [7:0]SEG,AN;
	cpu CPU(rst,clk,butt_0,butt_1,butt_2,butt_3,butt_4,SEG,AN);

    initial begin
        butt_0=1;butt_1=0;butt_2=0;butt_3=0;butt_4=0;
        clk = 0;
        rst = 1;
        #5 
        rst = 0;
    end

	always  begin
		#10
        clk = 0;
        #10 
        clk = 1;
	end

endmodule