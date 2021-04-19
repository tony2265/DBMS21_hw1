/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[9-1:0]		Ctrl_o;

reg as,rw,b;
reg [1:0] ao;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];
assign Ctrl_o = {instr_i[30],instr_i[14:12],instr_i[6:2]};
assign ALUSrc = as;
assign RegWrite = rw;
assign Branch = b;
assign ALUOp = ao;

always @(*) begin
	case (opcode)
		7'b0110011:begin//R type
			as <= 0;
			rw <= 1;
			b <= 0;
			ao <= 2'b10;
		end
		7'b0000011:begin//ld
			if(funct3==3'b011) begin
				as <= 1;
				rw <= 1;
				b <= 0;
				ao <= 2'b00;
			end
		end
		7'b0100011:begin//sd
			if(funct3==3'b011) begin
				as <= 1;
				rw <= 0;
				b <= 0;
				ao <= 2'b00;
			end
		end
		7'b1100011:begin//beq
			if(funct3==3'b000) begin
				as <= 0;
				rw <= 0;
				b <= 1;
				ao <= 2'b01;
			end
		end
		default: ;
	endcase

end


endmodule