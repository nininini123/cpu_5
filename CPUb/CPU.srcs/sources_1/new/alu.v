`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 15:09:31
// Design Name: 
// Module Name: alu
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


module alu(X,Y,S,result1,result2,OF,UOF,Equal);
    input signed [31:0] X,Y;
    input [3:0] S;
    output reg [31:0] result1,result2;
    output reg OF,UOF;
    output Equal;
    always@(X,Y,S)begin
    case(S)
        5'd0: begin result1=X<<Y[4:0];  result2=0;  OF=0;   UOF=0;end   //逻辑左
        5'd1: begin result1=X>>>Y[4:0]; result2=0;  OF=0;   UOF=0;end   //算数右
        5'd2: begin result1=X>>Y[4:0];  result2=0   ;OF=0;  UOF=0;end   //逻辑右
        5'd3: begin {result2,result1}=X*Y;  OF=0;   UOF=0;end   //乘法
        5'd4: begin result1=X/Y;  result2=X%Y;  OF=0;   UOF=0;end   //除法
        5'd5: begin {UOF,result1}={X[31],X}+{Y[31],Y};  result2=0;  OF=(X[31]&Y[31]&!result1[31])|(!X[31]&!Y[31]&result1[31]);   end   //加法
        5'd6: begin result1=X-Y;  result2=0;  OF=(X[31]&Y[31]&!result1[31])|(!X[31]&!Y[31]&result1[31]);   UOF=result1[31];end   //减法
        5'd7: begin result1=X&Y;  result2=0;  OF=0;   UOF=0;end   //按位与
        5'd8: begin result1=X|Y;  result2=0;  OF=0;   UOF=0;end   //按位或
        5'd9: begin result1=X^Y;  result2=0;  OF=0;   UOF=0;end   //按位异或
        5'd10: begin result1=~(X|Y);  result2=0;  OF=0;   UOF=0;end  //按位或非
        5'd11: begin result1=(X<Y)?1:0;  result2=0;  OF=0;   UOF=0;end  //符号比较
        5'd12: begin result1=($unsigned(X)<$unsigned(Y))?1:0;  result2=0;  OF=0;   UOF=0;end  //无符号比较
        default: begin result1=0;  result2=0;  OF=0;   UOF=0;end
    endcase
    end
    assign Equal=(X==Y)?1'b1:1'b0;
endmodule
