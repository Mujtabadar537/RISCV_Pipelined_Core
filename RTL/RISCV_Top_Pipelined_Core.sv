`include "FETCH_STAGE.sv"
`include "DECODE_STAGE.sv"
`include "EXECUTE_STAGE.sv"
`include "MEMORY_ACCESS_STAGE.sv"
`include "WRITE_BACK_STAGE.sv"



module RISCV_Top_Pipelined_Core(

input clk_i,
input reset_i

);

wire [2:0]funct3;
wire funct7_bit5;
wire zero;
wire [31:0]ReadData_DataMemory;
wire [31:0]Address_DataMemory;
wire [31:0]ALUResult;
wire [31:0]PCTarget;
wire [31:0]ReadData1;
wire [31:0]ReadData2;
wire [31:0]Immediate;
wire [31:0]WriteData;
wire PCSrc;
wire [31:0]pc_DECODE;
wire [31:0]pc_EXECUTE;
wire [31:0]instruction;
wire [4:0]WriteRegister_EXECUTE;
wire [4:0]WriteRegister_MEMORYACCESS;

wire MemtoReg_EXECUTE;
wire MemtoReg_MEMORYACCESS;
wire MemtoReg_WRITEBACK;

wire MemWrite_EXECUTE;
wire MemWrite_MEMORYACCESS;
wire MemRead_EXECUTE;
wire MemRead_MEMORYACCESS;

wire ALUSrc;

wire RegWrite_EXECUTE;
wire RegWrite_MEMORYACCESS;
wire RegWrite_WRITEBACK;

wire [1:0]ALUOp;

wire Branch_EXECUTE;
wire Branch_MEMORYACCESS;








FETCH_STAGE Instruction_Fetch(

.clk_i(clk_i),
.reset_i(reset_i),

.PCSrc(PCSrc),
.PCTarget_MEMORYACCESS(PCTarget),


.pc_DECODE(pc_DECODE),
.instruction_DECODE(instruction)


);



//-------------------------------------------



DECODE_STAGE Instruction_Decode(

.clk_i(clk_i),
.reset_i(reset_i),

.instruction_DECODE(instruction),
.pc_DECODE(pc_DECODE),

//signals from other stages
.Write_Register(WriteRegister_MEMORYACCESS),
.RegWrite(RegWrite_WRITEBACK),
.Write_data(WriteData),


.pc_EXECUTE(pc_EXECUTE),
.Write_Register_EXECUTE(WriteRegister_EXECUTE),
.ReadData1_EXECUTE(ReadData1),
.ReadData2_EXECUTE(ReadData2),
.Immout_EXECUTE(Immediate),
.funct3_EXECUTE(funct3),
.funct7_bit5_EXECUTE(funct7_bit5),

.MemtoReg_EXECUTE(MemtoReg_EXECUTE),
.MemWrite_EXECUTE(MemWrite_EXECUTE),
.MemRead_EXECUTE(MemRead_EXECUTE),
.ALUSrc_EXECUTE(ALUSrc),
.RegWrite_EXECUTE(RegWrite_EXECUTE),
.ALUOp_EXECUTE(ALUOp),
.Branch_EXECUTE(Branch_EXECUTE)


);


//-------------------------------------------


EXECUTE_STAGE Instruction_Execute(


.clk_i(clk_i),
.reset_i(reset_i),

.MemtoReg_EXECUTE(MemtoReg_EXECUTE),
.MemWrite_EXECUTE(MemWrite_EXECUTE),
.MemRead_EXECUTE(MemRead_EXECUTE),
.ALUSrc_EXECUTE(ALUSrc),
.RegWrite_EXECUTE(RegWrite_EXECUTE),
.ALUOp_EXECUTE(ALUOp),
.Branch_EXECUTE(Branch_EXECUTE),

.pc_EXECUTE(pc_EXECUTE),
.ReadData1_EXECUTE(ReadData1),
.ReadData2_EXECUTE(ReadData2),
.Immout_EXECUTE(Immediate),
.funct3_EXECUTE(funct3),
.funct7_bit5_EXECUTE(funct7_bit5),
.Write_Register_EXECUTE(WriteRegister_EXECUTE),



.PCTarget_MEMORYACCESS(PCTarget),
.zero_MEMORYACCESS(zero),
.ALUResult_MEMORYACCESS(ALUResult),
.ReadData2_MEMORYACCESS(ReadData2),
.Write_Register_MEMORYACCESS(WriteRegister_MEMORYACCESS),


.MemtoReg_MEMORYACCESS(MemtoReg_MEMORYACCESS),
.MemWrite_MEMORYACCESS(MemWrite_MEMORYACCESS),
.MemRead_MEMORYACCESS(MemRead_MEMORYACCESS),
.RegWrite_MEMORYACCESS(RegWrite_MEMORYACCESS),
.Branch_MEMORYACCESS(Branch_MEMORYACCESS)



);


//-------------------------------------------


MEMORY_ACCESS_STAGE Memory_Access(

.clk_i(clk_i),
.reset_i(reset_i),

.MemtoReg_MEMORYACCESS(MemtoReg_MEMORYACCESS),
.MemWrite_MEMORYACCESS(MemWrite_MEMORYACCESS),
.MemRead_MEMORYACCESS(MemRead_MEMORYACCESS),
.RegWrite_MEMORYACCESS(RegWrite_MEMORYACCESS),
.Branch_MEMORYACCESS(Branch_MEMORYACCESS),

.Write_Register_MEMORYACCESS(WriteRegister_MEMORYACCESS),
.Address_MEMORYACCESS(ALUResult),
.WriteData_DataMemory_MEMORYACCESS(ReadData2),
.zero_MEMORYACCESS(zero),



.PCSrc(PCSrc),
.RegWrite_WRITEBACK(RegWrite_WRITEBACK),
.MemtoReg_WRITEBACK(MemtoReg_WRITEBACK),
.ReadData_WRITEBACK(ReadData_DataMemory),
.Address_WRITEBACK(Address_DataMemory)


);


//-------------------------------------------


WRITE_BACK_STAGE Write_Back(

.MemtoReg_WRITEBACK(MemtoReg_WRITEBACK),
.ReadData_WRITEBACK(ReadData_DataMemory),
.Address_WRITEBACK(Address_DataMemory),

.RegWrite(RegWrite_WRITEBACK),
.WriteData(WriteData)

);





endmodule





