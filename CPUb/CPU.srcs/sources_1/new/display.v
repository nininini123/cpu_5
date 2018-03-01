`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/27 08:53:28
// Design Name: 
// Module Name: display
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


module display(in,clk,en,sel,SEG,AN);
    input [31:0] in;
    input en,sel;
    input clk;
    output [7:0] AN,SEG;
    wire [3:0] ge,shi,bai,qian,wan,shiwan,baiwan,qianwan,mul_out,H,G,F,E,D,C,B,A,out8,out7,out6,out5,out4,out3,out2,out1;
    wire [2:0] counterout;
    changeto8421 change1(in,qianwan,baiwan,shiwan,wan,qian,bai,shi,ge);
    changetohex changehex(in,H,G,F,E,D,C,B,A);
    counter counter1(clk,counterout);
    mul_sel #(4)mul1(counterout,out1,out2,out3,out4,out5,out6,out7,out8,mul_out);
    pattern p1(mul_out,en,SEG);
    decoder3_8 d1(counterout,AN);
    mux2 #(4)m1(out1,sel,A,ge);
    mux2 #(4)m2(out2,sel,B,shi);
    mux2 #(4)m3(out3,sel,C,bai);
    mux2 #(4)m4(out4,sel,D,qian);
    mux2 #(4)m5(out5,sel,E,wan);
    mux2 #(4)m6(out6,sel,F,shiwan);
    mux2 #(4)m7(out7,sel,G,baiwan);
    mux2 #(4)m8(out8,sel,H,qianwan);
endmodule

module changeto8421(num,qianwan,baiwan,shiwan,wan,qian,bai,shi,ge);
input [31:0] num;       
output reg [3:0] ge,shi,bai,qian,wan,shiwan,baiwan,qianwan;       
always@(num) begin
    qianwan=(num/10000000)%10;
    baiwan=(num/1000000)%10;
    shiwan=(num/100000)%10;
    wan=(num/10000)%10;
    qian=(num/1000)%10;
    bai=(num/100)%10;
	shi=(num/10)%10;
	ge=num%10;
end                       
endmodule

module changetohex(num,qianwan,baiwan,shiwan,wan,qian,bai,shi,ge);
input [31:0] num;       
output reg [3:0] ge,shi,bai,qian,wan,shiwan,baiwan,qianwan;       
always@(num) begin
    qianwan=num[31:28];
    baiwan=num[27:24];
    shiwan=num[23:20];
    wan=num[19:16];
    qian=num[15:12];
    bai=num[11:8];
	shi=num[7:4];
	ge=num[3:0];
end                       
endmodule

module pattern(code,en, patt);
input [3: 0] code;       // 16进制数字的4位二进制编码
input en;
output reg [7:0] patt;       // 7段数码管驱动，低电平有效
always@(code) begin
    if(en)
    case(code)
        4'b0000  :patt=8'b11000000;
        4'b0001  :patt=8'b11111001;
        4'b0010  :patt=8'b10100100;
        4'b0011  :patt=8'b10110000;
        4'b0100  :patt=8'b10011001;
        4'b0101  :patt=8'b10010010;
        4'b0110  :patt=8'b10000010;
        4'b0111  :patt=8'b11111000;
        4'b1000  :patt=8'b10000000;
        4'b1001  :patt=8'b10011000;
        4'b1010  :patt=8'b10001000;
        4'b1011  :patt=8'b10000011;
        4'b1100  :patt=8'b11000110;
        4'b1101  :patt=8'b10100001;
        4'b1110  :patt=8'b10000110;
        4'b1111  :patt=8'b10001110;
        endcase
    else patt=8'b11111111;
end                       // 功能实现
endmodule

module counter(clk,out);//模8计数
    input clk;                    // 计数时
    output reg [2:0] out;             // 计数值
    always @(posedge clk)  begin  // 在时钟上升沿计数器加1
            out=out+1;
    end                           
endmodule

module mul_sel(sel,a,b,c,d,e,f,g,h,out);//8选1
    parameter N=4;
    input [2:0]sel;
    input [N-1:0] a,b,c,d,e,f,g,h;
    output reg [N-1:0] out;
    always@(a,b,c,d,e,f,g,h,sel)
        begin
            case(sel)
                3'd0:out=a;
                3'd1:out=b;
                3'd2:out=c;
                3'd3:out=d;
                3'd4:out=e;
                3'd5:out=f;
                3'd6:out=g;
                default:out=h; 
            endcase
        end
endmodule

module decoder3_8(num, sel);
input [2:0] num;       // 数码管编号：0~7
output reg [7:0] sel;       // 7段数码管片选信号，低电平有效
always@(num) begin
    case(num)
        3'b000  :sel=8'b11111110;
        3'b001  :sel=8'b11111101;
        3'b010  :sel=8'b11111011;
        3'b011  :sel=8'b11110111;
        3'b100  :sel=8'b11101111;
        3'b101  :sel=8'b11011111;
        3'b110  :sel=8'b10111111;
        3'b111  :sel=8'b01111111;
        endcase
end
endmodule