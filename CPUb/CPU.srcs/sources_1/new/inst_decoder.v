`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/27 11:05:46
// Design Name: 
// Module Name: inst_decoder
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


module inst_decoder(in,Itype,jal,shift,syscall,OP,funct,W,A,B);
    input [31:0]in;
    input Itype,jal,shift,syscall;
    output [5:0]OP,funct;
    output [4:0]W,A,B;
    wire [4:0]m1out,m3out,m5out;
    mux2 #(5)m1(m1out,Itype,in[15:11],in[20:16]);
    mux2 #(5)m2(W,jal,m1out,5'd31);
    mux2 #(5)m3(m3out,shift,in[25:21],in[20:16]);
    mux2 #(5)m4(A,syscall,m3out,5'd2);
    mux2 #(5)m5(m5out,shift,in[20:16],in[25:21]);
    mux2 #(5)m6(B,syscall,m5out,5'd4);
    assign OP=in[31:26];
    assign funct=in[5:0];
    
endmodule
