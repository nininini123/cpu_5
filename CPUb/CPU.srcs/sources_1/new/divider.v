`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 17:19:26
// Design Name: 
// Module Name: divider
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

module divider(clk, clk_N);
input clk;                      // ϵͳʱ��
output reg clk_N=0;                   // ��Ƶ���ʱ��
parameter N = 100_000_0;      // 1Hz��ʱ��,N=fclk/fclk_N
reg [31:0] counter=0;             /* ������������ͨ������ʵ�ַ�Ƶ��
                                   ����������0������(N/2-1)ʱ��
                                   ���ʱ�ӷ�ת������������ */
always @(posedge clk)  begin    // ʱ��������
    counter=counter+1;
    if(counter==(N/2-1))
        begin
        clk_N=~clk_N;
        counter=0;
        end
end                           
endmodule