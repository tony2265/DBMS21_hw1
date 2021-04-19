/***************************************************
Student Name: 翁堉豪
Student ID: 0816160
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input signed [32-1:0]	src1,          // 32 bits source 1          (input)
	input signed [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
reg signed [31:0] a,b,c;

integer i,co;

always @(*) begin
	if(rst_n)begin
		a = src1;
		b = src2;		
	end
	case (ALU_control)
		4'b0000: //and
		begin
			result = a & b;
			zero = |result ? 0 : 1;
			cout = 0;
			overflow = 0;
		end
		4'b0001: //or
		begin
			result = a | b;
			zero = |result ? 0 : 1;
			cout = 0;
			overflow = 0;
		end
		4'b0010: //add
		begin
			c = a + b;
			zero = |c ? 0 : 1;
			if(a>=0&&b>0&&c<=0) overflow = 1;
			else if(a<=0&&b<0&&c>=0) overflow = 1;
			else overflow = 0;
			result = c;
			co = 0;
			for(i=0;i<32;i++) begin
				co = (((a[i] ^ b[i]) & co) | (a[i] & b[i]));

			end
			cout = co;

		end
		4'b0110: //sub
		begin
			c = a - b;
			zero = |c ? 0 : 1;
			if(a>=0&&b<0&&c<=0) overflow = 1;
			else if(a<=0&&b>0&&c>=0) overflow = 1;
			else overflow = 0;
			result = c;
			
			co = 1;
			b = ~b;
			for(i=0;i<32;i++) begin
				co = (((a[i] ^ b[i]) & co) | (a[i] & b[i]));
			end
			cout = co;

		end
		4'b0111: //slt
		begin
			result = (a < b) ? 32'b1 : 32'b0;
			zero = |result ? 0 : 1;
			if(a>=0&&b<0&&c<=0) overflow = 1;
			else if(a<=0&&b>0&&c>=0) overflow = 1;
			else overflow = 0;
			cout = overflow; 
		end
		4'b1100: //nor
		begin
			result = ~(a | b);
			zero = |result ? 0 : 1;
			overflow = 0;
			cout = 0;
		end
		4'b1101: //nand
		begin
			result = ~(a & b);
			zero = |result ? 0 : 1;
			overflow = 0;
			cout = 0;
		end
		4'b0011: //xor
		begin
			result = a ^ b;
			zero = |result ? 0 : 1;
			overflow = 0;
			cout = 0;
		end
		4'b0100: //sll
		begin
			result = a << b;
			zero = |result ? 0 : 1;
			overflow = 0;
			cout = 0;
		end
		4'b0101: //sra
		begin
			result = a >>> b;
			zero = |result ? 0 : 1;
			overflow = 0;
			cout = 0;
		end
		default: ;
	endcase
end

endmodule
