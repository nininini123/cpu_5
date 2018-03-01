`timescale 1ns/1ns  
module memory(address,din,str,clk,ld,clr,dout);
        input clk;
        input str;
        input ld;
        input clr;
        input [31:0] din;
        input [9:0] address;
        output [31:0] dout; 

        reg [31:0] RAM [511:0];
        reg [9:0] raddr_reg=0;
        initial 
        begin
            RAM[0]=0;
            RAM[1]=0;
            RAM[2]=0;
            RAM[3]=0;
            RAM[4]=0;
            RAM[5]=0;
        end
        always @ (posedge clk)
        begin
            if(str) 
                begin
                RAM[address] <= din;
            end
        end

        always @ (posedge clk)
        begin
            if(ld)
                begin
                raddr_reg <= address;
                end
        end

        assign dout = RAM[address];
    endmodule