`include "Control_Unit.sv"
`include "Register_File.sv"
`include "Imm_Gen.sv"


module DECODE_STAGE(

input clk_i,
input reset_i,

input [31:0]instruction_DECODE,
input [31:0]pc_DECODE,

//signals from other stages
input [4:0]Write_Register,
input RegWrite,
input [31:0]Write_data,


output [31:0]pc_EXECUTE,
output [4:0]Write_Register_EXECUTE,
output [31:0]ReadData1_EXECUTE,
output [31:0]ReadData2_EXECUTE,
output [31:0]Immout_EXECUTE,
output [2:0]funct3_EXECUTE,
output funct7_bit5_EXECUTE,

//forwarding
output [4:0]Rs1_EXECUTE,
output [4:0]Rs2_EXECUTE,

output MemtoReg_EXECUTE,
output MemWrite_EXECUTE,
output MemRead_EXECUTE,
output ALUSrc_EXECUTE,
output RegWrite_EXECUTE,
output [1:0]ALUOp_EXECUTE,
output Branch_EXECUTE

);





//interim wires
wire MemtoReg_wire;
wire MemWrite_wire;
wire MemRead_wire;
wire ALUSrc_wire;
wire RegWrite_wire;
wire [1:0]ALUOp_wire;
wire Branch_wire;

wire [31:0]ReadData1_wire;
wire [31:0]ReadData2_wire;
wire [31:0]Immout_wire;





/** Module Instantiation **/
Control_Unit CU(


.opcode_i(instruction_DECODE[6:0]),


.MemtoReg_o(MemtoReg_wire),
.MemWrite_o(MemWrite_wire),
.MemRead_o(MemRead_wire),
.ALUSrc_o(ALUSrc_wire),
.RegWrite_o(RegWrite_wire),
.ALUOp_o(ALUOp_wire),
.Branch_o(Branch_wire)

);



//-------------------------------------------


Register_File RF(

.clk_i(clk_i),
.reset_i(reset_i),
.Read_Register1_i(instruction_DECODE[19:15]),
.Read_Register2_i(instruction_DECODE[24:20]),
.Write_Register_i(Write_Register),
.Write_data_i(Write_data),
.RegWrite_i(RegWrite_EXECUTE),


.Read_data1_o(ReadData1_wire),
.Read_data2_o(ReadData2_wire)


);



//-------------------------------------------


Imm_Gen Immediate_Generator(

.instruction_i(instruction_DECODE),

.Immediate_o(Immout_wire)

);





//Decode Register Logic

logic MemtoReg_reg;
logic MemWrite_reg;
logic MemRead_reg;
logic ALUSrc_reg;
logic RegWrite_reg;
logic [1:0]ALUOp_reg;
logic Branch_reg;

logic [31:0]pc_reg;
logic [4:0]Write_Register_reg;
logic [31:0]ReadData1_reg;
logic [31:0]ReadData2_reg;
logic [31:0]Immout_reg;
logic [2:0]funct3_reg;
logic funct7_bit5_reg;

//for forwarding unit
logic [4:0]Rs1_reg;
logic [4:0]Rs2_reg;


always_ff @(posedge clk_i) begin

if(reset_i) begin
	MemtoReg_reg <= 1'b0;
	MemWrite_reg <= 1'b0;
	MemRead_reg <= 1'b0;
	ALUSrc_reg <= 1'b0;
	RegWrite_reg <= 1'b0;
	ALUOp_reg <= 2'b00;
	Branch_reg <= 1'b0;
	pc_reg <= 32'h00000000;
	Write_Register_reg <= 5'b00000;
	ReadData1_reg <= 32'h00000000;
	ReadData2_reg <= 32'h00000000;
	Immout_reg <= 32'h00000000;
	funct3_reg <= 3'b000;
	funct7_bit5_reg <= 1'b0;
	Rs1_reg <= 5'b00000;
	Rs2_reg <= 5'b00000;
	 
end



else begin
	MemtoReg_reg <= MemtoReg_wire;
	MemWrite_reg <= MemWrite_wire;
	MemRead_reg <= MemRead_wire;
	ALUSrc_reg <= ALUSrc_wire;
	RegWrite_reg <= RegWrite_wire;
	ALUOp_reg <= ALUOp_wire;
	Branch_reg <= Branch_wire;
	pc_reg <= pc_DECODE;
	Write_Register_reg <= instruction_DECODE[11:7];
	ReadData1_reg <= ReadData1_wire;
	ReadData2_reg <= ReadData2_wire;
	Immout_reg <= Immout_wire;
	funct3_reg <= instruction_DECODE[14:12];
	funct7_bit5_reg <= instruction_DECODE[30];
	Rs1_reg <= instruction_DECODE[19:15];
	Rs2_reg <= instruction_DECODE[24:20]; 
end


end



assign MemtoReg_EXECUTE = MemtoReg_reg;
assign MemWrite_EXECUTE = MemWrite_reg;
assign MemRead_EXECUTE = MemRead_reg;
assign ALUSrc_EXECUTE = ALUSrc_reg;
assign RegWrite_EXECUTE = RegWrite_reg;
assign ALUOp_EXECUTE = ALUOp_reg;
assign Branch_EXECUTE = Branch_reg;


assign pc_EXECUTE = pc_reg;
assign Write_Register_EXECUTE = Write_Register_reg;
assign ReadData1_EXECUTE = ReadData1_reg;
assign ReadData2_EXECUTE = ReadData2_reg;
assign Immout_EXECUTE = Immout_reg;
assign funct3_EXECUTE = funct3_reg;
assign funct7_bit5_EXECUTE = funct7_bit5_reg;
assign Rs1_EXECUTE = Rs1_reg;
assign Rs2_EXECUTE = Rs2_reg;


wire _unused_ok = &{1'b0,
                    RegWrite,
                    1'b0};


endmodule


