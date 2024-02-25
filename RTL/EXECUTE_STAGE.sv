`include "ALU.sv"
`include "ALU_Control.sv"


module EXECUTE_STAGE(

input clk_i,
input reset_i,

input MemtoReg_EXECUTE,
input MemWrite_EXECUTE,
input MemRead_EXECUTE,
input ALUSrc_EXECUTE,
input RegWrite_EXECUTE,
input [1:0]ALUOp_EXECUTE,
input Branch_EXECUTE,

input [31:0]pc_EXECUTE,
input [31:0]ReadData1_EXECUTE,
input [31:0]ReadData2_EXECUTE,
input [31:0]Immout_EXECUTE,
input [2:0]funct3_EXECUTE,
input funct7_bit5_EXECUTE,
input [4:0]Write_Register_EXECUTE,

//forwarding
/* verilator lint_off UNUSED */
input [31:0]ALUResult,
/* verilator lint_on UNUSED */
input [31:0]WriteData_WRITEBACK,
input [1:0]ForwardA,
input [1:0]ForwardB,



output [31:0]PCTarget_MEMORYACCESS,
output zero_MEMORYACCESS,
output [31:0]ALUResult_MEMORYACCESS,
output [31:0]ReadData2_MEMORYACCESS,
output [4:0]Write_Register_MEMORYACCESS,


output MemtoReg_MEMORYACCESS,
output MemWrite_MEMORYACCESS,
output MemRead_MEMORYACCESS,
output RegWrite_MEMORYACCESS,
output Branch_MEMORYACCESS


);


//interim wires
wire [3:0]ALUControl_wire;
wire zero_wire;
wire [31:0]ALUResult_wire;
wire [31:0]PCTarget_wire;
wire [31:0]ALU_operand1_wire;
/* verilator lint_off UNUSED */
wire [31:0]ALU_operand2_wire;
/* verilator lint_on UNUSED */
wire [31:0]Mux_wire;




/** Module Instantiation **/

Add SUM(

.in1_i(pc_EXECUTE),
.in2_i(Immout_EXECUTE),

.sum_o(PCTarget_wire)


);


//-------------------------------------

ALU Arithmetic_Logic_Unit(

.operand1_i(ALU_operand1_wire),
.operand2_i(ALU_operand1_wire),
.ALU_Control_i(ALUControl_wire),

.ALUResult_o(ALUResult_wire),
.zero_o(zero_wire)

);



//-------------------------------------




mux ALU_Operand2_mux(

.in1_i(Mux_wire),
.in2_i(Immout_EXECUTE),
.sel_i(ALUSrc_EXECUTE),

.out_o(ALU_operand2_wire)


);


//-------------------------------------



ALU_Control ALUControl(

.funct3_i(funct3_EXECUTE),
.funct7_bit5_i(funct7_bit5_EXECUTE),
.ALUOp_i(ALUOp_EXECUTE),


.control_line_o(ALUControl_wire)

);

//------------------------------------


Forwarding_Mux Forwarding_mux1(

.in1(ReadData1_EXECUTE),
.in2(ALUResult_MEMORYACCESS),
.in3(WriteData_WRITEBACK),

.sel(ForwardA),

.out(ALU_operand1_wire)

);


//------------------------------------


Forwarding_Mux Forwarding_mux2(

.in1(ReadData2_EXECUTE),
.in2(ALUResult_MEMORYACCESS),
.in3(WriteData_WRITEBACK),

.sel(ForwardB),

.out(Mux_wire)

);






//Execute Register Logic

logic MemtoReg_reg;
logic MemWrite_reg;
logic MemRead_reg;
logic RegWrite_reg;
logic Branch_reg;

logic [31:0]PCTarget_reg;
logic zero_reg;
logic [31:0]ALUResult_reg;
logic [31:0]ReadData2_reg;
logic [4:0]Write_Register_reg;


always_ff @(posedge clk_i) begin

if(reset_i) begin
	MemtoReg_reg <= 1'b0;
	MemWrite_reg <= 1'b0;
	MemRead_reg <= 1'b0;
	RegWrite_reg <= 1'b0;
	Branch_reg <= 1'b0;
	PCTarget_reg <= 32'h00000000;
	zero_reg <= 1'b0;
	ALUResult_reg <= 32'h00000000;
	ReadData2_reg <= 32'h00000000;
	Write_Register_reg <= 5'b00000;
	
end



else begin
	MemtoReg_reg <= MemtoReg_EXECUTE;
	MemWrite_reg <= MemWrite_EXECUTE;
	MemRead_reg <= MemRead_EXECUTE;
	RegWrite_reg <= RegWrite_EXECUTE;
	Branch_reg <= Branch_EXECUTE;
	zero_reg <= zero_wire;
	ALUResult_reg <= ALUResult_wire;
	ReadData2_reg <= ReadData2_EXECUTE;
	Write_Register_reg <= Write_Register_EXECUTE;
	PCTarget_reg <= PCTarget_wire;
end



end



assign PCTarget_MEMORYACCESS = PCTarget_reg;
assign zero_MEMORYACCESS = zero_reg;
assign ALUResult_MEMORYACCESS = ALUResult_reg;
assign ReadData2_MEMORYACCESS = ReadData2_reg;
assign Write_Register_MEMORYACCESS = Write_Register_reg;


assign MemtoReg_MEMORYACCESS = MemtoReg_reg;
assign MemWrite_MEMORYACCESS = MemWrite_reg;
assign MemRead_MEMORYACCESS = MemRead_reg;
assign RegWrite_MEMORYACCESS = RegWrite_reg;
assign Branch_MEMORYACCESS = Branch_reg;



wire _unused_ok = &{1'b0,
                    Write_Register_EXECUTE,
                    1'b0};




endmodule
