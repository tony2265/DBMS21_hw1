/***************************************************
Student Name: 翁堉豪、林栢瑋
Student ID: group1_0816160_0816152 
***************************************************/
   `timescale 1ns/1ps
   module Simple_Single_CPU(
       input clk_i,
       input rst_i
   );

   //Internal Signales
   //Control Signales
   wire RegWrite;
   wire Branch;
   wire Jump;
   wire WriteBack1;
   wire WriteBack0;
   wire MemRead;
   wire MemWrite;
   wire ALUSrcA;
   wire ALUSrcB;
   wire [2-1:0] ALUOp;
   wire PCSrc;
   //ALU Flag
   wire Zero;

   //Datapath
   wire [32-1:0] pc_i;
   wire [32-1:0] pc_o;
   wire [32-1:0] instr;
   wire [32-1:0] Imm_Gen_o;
   wire [32-1:0] Imm_4 = 4;
   wire [4-1:0] ALUControlOut;
   wire [4-1:0] ALUControlIn;
   assign ALUControlIn[3] = instr[30];
   assign ALUControlIn[2:0] = instr[14:12];
   assign PCSrc = (Branch & Zero) | Jump;

   //new
   wire [32-1:0] RegWriteData;
   wire [31:0] RSdata_o;
   wire [31:0] RTdata_o;
   wire [31:0] PCPlus4_o;
   wire [31:0] ALUSrcA_out;
   wire [31:0] PCReg_add;
   wire [31:0] b;
   wire [31:0] ALUresult;
   wire [31:0] wb0;
   wire [31:0] Read_data;

   ProgramCounter PC(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .pc_i(pc_i),
       .pc_o(pc_o)
   );

   Adder Adder_PCPlus4(
       .src1_i(pc_o),
       .src2_i(Imm_4),
       .sum_o(PCPlus4_o)
   );

   Instr_Memory IM(
       .addr_i(pc_o),
       .instr_o(instr)
   );

   Reg_File RF(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .RSaddr_i(instr[19:15]),
       .RTaddr_i(instr[24:20]),
       .RDaddr_i(instr[11:7]),
       .RDdata_i(RegWriteData),
       .RegWrite_i(RegWrite),
       .RSdata_o(RSdata_o),
       .RTdata_o(RTdata_o)
   );


   Decoder Decoder(
       .instr_i(instr[6:0]),
       .RegWrite(RegWrite),
       .Branch(Branch),
       .Jump(Jump),
       .WriteBack1(WriteBack1),
       .WriteBack0(WriteBack0),
       .MemRead(MemRead),
       .MemWrite(MemWrite),
       .ALUSrcA(ALUSrcA),
       .ALUSrcB(ALUSrcB),
       .ALUOp(ALUOp)
   );

   Imm_Gen ImmGen(
       .instr_i(instr),
       .Imm_Gen_o(Imm_Gen_o)
   );


   ALU_Ctrl ALU_Ctrl(
       .instr(ALUControlIn),
       .ALUOp(ALUOp),
       .ALU_Ctrl_o(ALUControlOut)
   );

   MUX_2to1 MUX_ALUSrcA(
       .data0_i(pc_o),
       .data1_i(RSdata_o),
       .select_i(ALUSrcA),
       .data_o(ALUSrcA_out)
   );

   Adder Adder_PCReg(
       .src1_i(ALUSrcA_out),
       .src2_i(Imm_Gen_o),
       .sum_o(PCReg_add)
   );

   MUX_2to1 MUX_PCSrc(
       .data0_i(PCPlus4_o),
       .data1_i(PCReg_add),
       .select_i(PCSrc),
       .data_o(pc_i)
   );

   MUX_2to1 MUX_ALUSrcB(
       .data0_i(RTdata_o),
       .data1_i(Imm_Gen_o),
       .select_i(ALUSrcB),
       .data_o(b)
   );

   alu alu(
       .rst_n(rst_i),
       .src1(RSdata_o),
       .src2(b),
       .ALU_control(ALUControlOut),
       .shamt(instr[24:20]),
       .Zero(Zero),
       .result(ALUresult)
   );

   Data_Memory Data_Memory(
       .clk_i(clk_i),
       .addr_i(ALUresult),
       .data_i(RTdata_o),
       .MemRead_i(MemRead),
       .MemWrite_i(MemWrite),
       .data_o(Read_data)
   );

   MUX_2to1 MUX_WriteBack0(
       .data0_i(ALUresult),
       .data1_i(Read_data),
       .select_i(WriteBack0),
       .data_o(wb0)
   );

   MUX_2to1 MUX_WriteBack1(
       .data0_i(wb0),
       .data1_i(PCPlus4_o),
       .select_i(WriteBack1),
       .data_o(RegWriteData)
   );

   endmodule
