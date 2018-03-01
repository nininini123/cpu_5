`timescale 1ns/1ps

module Extender_n(out,in);//将一个a位数无符号扩展成b�?
    output wire [b-1:0]out;
    input wire [a-1:0]in;
    parameter a = 0;
    parameter b = 0;
    assign out [b-1:0] ={{b-a{1'b0}},in[a-1:0]};
endmodule

module Extender_y(out,in);//将一个a位数有符号扩展成b�?
    output wire [b-1:0]out;
    input wire [a-1:0]in;
    parameter a = 0;
    parameter b = 0;
    assign out [b-1:0] ={{b-a{in[a-1]}},in[a-1:0]};
endmodule

