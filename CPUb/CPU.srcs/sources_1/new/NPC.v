`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/27 10:22:56
// Design Name: 
// Module Name: NPC
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


module NPC(index,PCadd4,offset,rs,beq,equal,bne,blez,less,jump,jr,zhuanyi,address);
    input [25:0] index;
    input [31:0] PCadd4,offset,rs;
    input beq,equal,bne,blez,less,jump,jr;
    output [31:0] address;
    output zhuanyi;
    wire w1=(beq&equal)|(bne&~equal)|((equal|less)&blez);
    wire [31:0]w2={PCadd4[31:28],index<<2,2'b0}>>2;
    wire [31:0]m1a=PCadd4;
    wire [31:0]m1b=PCadd4+(offset<<2);
    wire [31:0]m1out,m2out;
    mux2 #(32)m1(m1out,w1,m1a,m1b);
    mux2 #(32)m2(m2out,jump,m1out,w2);
    mux2 #(32)m3(address,jr,m2out,rs);
    assign zhuanyi=(beq&equal)|(bne&~equal)|((equal|less)&blez);
endmodule
