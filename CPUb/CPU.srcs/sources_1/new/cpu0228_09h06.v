`timescale 1ns/1ps

module cpu(rst,clk,butt_0,butt_1,butt_2,butt_3,butt_4,SEG,AN);
	input rst, clk;
	input butt_0,butt_1,butt_2,butt_3,butt_4;
	output [7:0]SEG,AN;

	wire zhuanyi, no_condi;	//成功转移  无条件分�?
	wire [31:0] PC_in,PC_out,PC_p4;
	wire halt;
	wire [31:0] instruction;
	wire [5:0]OP,funct; //decode
    wire [4:0]W,A,B;
	wire [31:0] RFin; //RFdatain

	wire [31:0] instr_ext; //extend

	//control
	wire [3:0] ALUop;
	wire WE, Itype,Memtoreg,jal,lbu,store,load,Imme,shift,syscall,branch,jump,jr,  sign,extend5,  beq,bne,blez;

	wire Equal;
	wire [31:0]RegOutA,RegOutB;//registers_out
	wire [31:0]Result;//ALU_out
	wire [31:0]mux_a_out,mux_b_out,mux_c_out;//mux_out
	wire [31:0]Reg_count_out;//Reg_count_out;
	wire [31:0]extend_a_out;//extend_a_out

	wire w_w1;
	wire [31:0] dout;
	wire [31:0] Syscallout;
	wire [15:0] all,if_y,if_n,if_r;
    divider #(3)d1(clk, clk_N);
	PC _PC(.in(PC_in) , .en(halt), .clk(clk_N), .rst(rst), .out(PC_out) );
	plus#(32) PLUS(PC_out, 32'd4,PC_p4);
	mem ROM(.read_data(instruction) ,.addr(PC_out[11:2]) );
	inst_decoder INST_DECODE(.in(instruction) ,.Itype(Itype) ,.jal(jal) ,.shift(shift) ,.syscall(syscall) ,.OP(OP) ,.funct(funct) ,.W(W) ,.A(A) ,.B(B) );
	NPC _npc(.index(instruction[25:0]) ,.PCadd4(PC_p4) ,.offset(instr_ext) ,.rs(RegOutA) ,.beq(beq) ,.equal(Equal) ,.bne(bne),.blez(blez) ,.less(RegOutA[31]) ,.jump(jump) ,.jr(jr) ,.zhuanyi(zhuanyi) ,.address(PC_in) );
	extend instr16_extend(.Extendout(instr_ext) ,.Extendin(instruction[15:0]) ,.sign(sign) ,.extend5(extend5) );
	control _control( .op(OP),.funct(funct),
	.ALUop(ALUop) ,	.WE(WE) , .Itype(Itype) ,.Memtoreg(Memtoreg) ,.jal(jal) ,.lbu(lbu) ,.store(store) ,.load(load) ,.Imme(Imme) ,.shift(shift) ,.syscall(syscall) ,.branch(branch) ,.jump(jump) ,.jr(jr) ,  .sign(sign) ,.extend5(extend5) ,  .beq(beq) ,.bne(bne) ,.blez(blez) );
	RFdatain _RFdatain(.RFin(RFin) ,.ALUresult(Result) ,.Memout(mux_c_out) ,.PC4(PC_p4) ,.MemtoReg(Memtoreg) ,.jal(jal) );

	assign no_condi = jump | jr | jal;

	Reg_1 regw_1 (.out(w_w1),.in(1),.clk(clk_N),.rst(rst),.en(syscall&Equal) );
	assign halt = ~w_w1 ;
	memory ramw_w (.address(Result[11:2]),.din(RegOutB),.str(store),.clk(clk_N),.ld(load),.clr(rst),.dout(dout));
	show_choice show_w (.SEG(SEG),.AN(AN),.in0(Syscallout),.in1(all),.in2(if_n),.in3(if_y),.in4(if_r),.clk(clk),.en(butt_0),.on1(butt_1),.on2(butt_2),.on3(butt_3),.on4(butt_4));/////////////////////////////not yet 
	inst_count inst_countw (.all(all),.if_y(if_y),.if_n(if_n),.if_r(if_r),.halt(halt),.in_if(branch),.in_noif(no_condi),.in_r(zhuanyi),.clk(clk_N),.rst(rst));

	registers REGISTER( .W(RFin),.clk(clk_N), .WE(WE), .rW(W), .rA(A), .rB(B), .outA(RegOutA),.outB(RegOutB));
    alu ALU(.X(RegOutA),.Y(mux_b_out),.S(ALUop),.result1(Result),.result2(),.OF(),.UOF(),.Equal(Equal));
    mux2 #(32)mux_a(.out(mux_a_out),.sel(Imme),.d0(RegOutB),.d1(instr_ext));
    mux2 #(32)mux_b(.out(mux_b_out),.sel(syscall),.d0(mux_a_out),.d1(32'd10));
    mux2 #(32)mux_c(.out(mux_c_out),.sel(lbu),.d0(dout),.d1(extend_a_out));
    Reg_32 Reg_count(.out(Syscallout),.in(RegOutB),.clk(clk_N),.rst(rst),.en(syscall));
    Extender_n #(8,32)extend_a(.out(extend_a_out),.in(dout[7:0]));

endmodule

module plus(a,b,sum);
	parameter width = 32;
	input[width-1:0] a,b;
	output reg[width-1:0] sum;
	always @(*) begin
		sum = a+b;
	end
endmodule