`timescale 1ns/1ps

module control( 
	op,funct,
	ALUop,	WE, Itype,Memtoreg,jal,lbu,store,load,Imme,shift,syscall,branch,jump,jr,  sign,extend5,  beq,bne,blez
);
	input [5:0] op,funct;
	output [3:0] ALUop;
	output WE, Itype,Memtoreg,jal,lbu,store,load,Imme,shift,syscall,branch,jump,jr,  sign,extend5,  beq,bne,blez;
	
	wire sel;
	wire[5:0] temp_mux_out;
	
	mux2#(6) mux2_6bit( temp_mux_out, sel, op,funct);
	equal_6 e6(op,8'b00_0000,sel);
	op_we OP_WE( .funct(sel), .i5(temp_mux_out[5]), .i4(temp_mux_out[4]), .i3(temp_mux_out[3]), .i2(temp_mux_out[2]), .i1(temp_mux_out[1]), .i0(temp_mux_out[0]),  .o3(ALUop[3]),.o2(ALUop[2]),.o1(ALUop[1]),.o0(ALUop[0]),.WE(WE) );
	ctrl_sgn CTRL_SGN( .funct(sel), .i5(temp_mux_out[5]), .i4(temp_mux_out[4]), .i3(temp_mux_out[3]), .i2(temp_mux_out[2]), .i1(temp_mux_out[1]), .i0(temp_mux_out[0]), .Itype(Itype)  ,.Memtoreg(Memtoreg) ,.jal(jal) , .lbu(lbu) ,.store(store) ,.load(load) ,.Imme(Imme) ,.shift(shift) ,.syscall(syscall) ,.branch(branch) ,.jump(jump) , .jr(jr) );
	ext_sgn EXT_SGN( .funct(sel), .i5(temp_mux_out[5]), .i4(temp_mux_out[4]), .i3(temp_mux_out[3]), .i2(temp_mux_out[2]), .i1(temp_mux_out[1]), .i0(temp_mux_out[0]), .sign(sign), .extend5(extend5) );
	branch BRCH( .funct(sel), .i5(temp_mux_out[5]), .i4(temp_mux_out[4]), .i3(temp_mux_out[3]), .i2(temp_mux_out[2]), .i1(temp_mux_out[1]), .i0(temp_mux_out[0]), .beq(beq),.bne(bne),.blez(blez) );
	
endmodule 

module op_we( 
	funct,i5,i4,i3,i2,i1,i0,
	o3,o2,o1,o0,WE
 );
	input funct,i5,i4,i3,i2,i1,i0;
	output o3,o2,o1,o0,WE;
	assign o3 = (  ~funct  & ~i3 & ~i2 & ~i1 ) | (  ~funct & ~i5 & i1 ) | (  i2 & ~i1 & i0 ) | (  i5 & i2 & i1 ) | (  funct & i3 & ~i2 ) ;
	assign o2 = (  ~funct & ~i1 & ~i0 ) | (  i3 & ~i1 & ~i0 ) | (  i3 & ~i2 & i0 ) | (  i5 & ~i3 & ~i2 ) | (  i5 & ~i3 & ~i0) ;
	assign o1 = (  i1 & ~i0 ) | (  i3 & i2 & ~i0 ) | (  i5 & i2 & i1 ) | (  funct & i5 & i2 & ~i0) ;
	assign WE = (  ~i5 & ~i2 & i0 ) | (  ~funct & ~i5 & i3 ) | (  i5 & ~i3 ) | (  funct & ~i3 ) | (  funct & i1) ;
	assign o0 = (  ~funct & ~i2 ) | (  ~funct & ~i0 ) | (  ~i5 & ~i3 & i0 ) | (  ~i3 & ~i2 & i0 ) | (  i3 & ~i2 & ~i0 ) | (  i5 & ~i1 & ~i0) ;
endmodule

module ctrl_sgn(
	funct,i5,i4,i3,i2,i1,i0,
	Itype ,Memtoreg,jal, lbu,store,load,Imme,shift,syscall,branch,jump, jr
);
	input funct,i5,i4,i3,i2,i1,i0;
	output Itype ,Memtoreg,jal, lbu,store,load,Imme,shift,syscall,branch,jump, jr;
	assign Itype = (  ~funct &~i5 &i3 ) | (  ~funct &i5& ~i3) ;
	assign Memtoreg = (  ~funct &i5& ~i3) ;
	assign jal = (  ~funct &~i5 &i1 &i0) ;
	assign lbu = (  ~funct& i5 &~i1 ) ;
	assign store = (  ~funct& i5 &i3 ) ;
	assign load = (  ~funct &i5 &~i3 ) ;
	assign Imme = (  ~funct& i3 ) | (  ~funct& i5 ) | (  funct& ~i5& ~i3 &~i2) ;
	assign shift = (  funct& ~i5 &~i3) ;
	assign syscall = (  funct& i3& i2) ;
	assign branch = (  ~funct& ~i5 &~i3& i2) ;
	assign jump = (  ~funct &~i5 &~i3 &~i2) ;
	assign jr = (  funct &i3 &~i2& ~i1) ;
endmodule

module ext_sgn(
	funct,i5,i4,i3,i2,i1,i0,
	sign,extend5
);
	input	funct,i5,i4,i3,i2,i1,i0;
	output sign,extend5;
	assign sign = (  ~funct &i3 &~i2& ~i0 ) ;
	assign extend5 = (  funct &~i5 &~i3 &~i2 ) ;
endmodule

module branch(
	funct,i5,i4,i3,i2,i1,i0,
	beq,bne,blez
);
	input funct,i5,i4,i3,i2,i1,i0;
	output beq,bne,blez;
	assign beq = (  ~funct& ~i5& ~i3& ~i1 &~i0 ) ;
	assign bne = (  ~funct& ~i3& ~i1 &i0 ) ;
	assign blez = (  i2 &i1 &~i0 ) ;
endmodule



module equal_6( a,b ,out);
	input [5:0] a,b;
	output out;
	wire [5:0] temp;
	assign temp = a ^ b;
	assign out = ~ (temp[0] | temp[1] | temp[2] | temp[3] | temp[4] | temp[5]  ) ;
endmodule

module equal_12( a,b ,out);
	input [11:0] a,b;
	output out;
	wire [11:0] temp;
	assign temp = a ^ b;
	assign out = ~ (temp[0] | temp[1] | temp[2] | temp[3] | temp[4] | temp[5] | temp[6] | temp[7] | temp[8] | temp[9] | temp[10] | temp[11]   ) ;
endmodule

module equal_13( a,b ,out);
	input [12:0] a,b;
	output out;
	wire [12:0] temp;
	assign temp = a ^ b;
	assign out = ~ (temp[0] | temp[1] | temp[2] | temp[3] | temp[4] | temp[5] | temp[6] | temp[7] | temp[8] | temp[9] | temp[10] | temp[11] | temp[12]   ) ;
endmodule