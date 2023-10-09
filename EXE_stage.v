//`include "multiplexer_3x1.v"
//`include "multiplexer.v"
`include "arithmetic_logic_unit.v"
//`include "adder.v"

module EXE_stage(

input clk,reset,
input MemWriteE,ALUSrcE,RegWriteE,
input [1:0]ResultSrcE,
input [2:0]ALUControlE,
input [31:0]RD1E,RD2E,
input [31:0]PCE,
input [4:0]RdE,
input [31:0]ImmExtE,
input [31:0]PCPlus4E,
input [1:0]ForwardAE,ForwardBE,
//input [31:0]ResultW,
input BranchE,
input [31:0]ResultW,


output PCSrcE,
output [31:0]PCTargetE,
output RegWriteM,MemWriteM,
output [1:0]ResultSrcM,
output [31:0]ALUResultM,WriteDataM,
output [4:0]RdM,
output [31:0]PCPlus4M

);



wire [31:0]SrcAE;
wire [31:0]SrcBE;
wire [31:0]WriteDataE;
wire zeroE;
wire [31:0]ALUResultE;


multiplexer_3x1 ForwardA_mux(

.in1(RD1E),.in2(ResultW),.in3(ALUResultM),
.sel(ForwardAE),

.out(SrcAE)

);



multiplexer_3x1 ForwardB_mux(

.in1(RD2E),.in2(ResultW),.in3(ALUResultM),
.sel(ForwardBE),

.out(WriteDataE)

);




multiplexer MUX2(

.in1(WriteDataE),.in2(ImmExtE),
.sel(ALUSrcE),

.out(SrcBE)


);





arithmetic_logic_unit ALU(

.in1(SrcAE),.in2(SrcBE),
.ALUControl(ALUControlE),

.ALUResult(ALUResultE),
.zero(zeroE)

);



adder ADD(

.in1(PCE),.in2(ImmExtE),
.out(PCTargetE)

);




reg RegWrite_reg,MemWrite_reg;
reg [1:0]ResultSrc_reg;
reg [31:0]ALUResult_reg,WriteData_reg;
reg [4:0]Rd_reg;
reg [31:0]PCPlus4_reg;


always @(posedge clk , posedge reset) begin


if(reset) begin

RegWrite_reg <= 0;
MemWrite_reg <= 0;
ResultSrc_reg <= 0;
ALUResult_reg <= 0;
WriteData_reg <= 0;
Rd_reg <= 0;
PCPlus4_reg <= 0;


end


else begin

RegWrite_reg <= RegWriteE;
MemWrite_reg <= MemWriteE;
ResultSrc_reg <= ResultSrcE;
ALUResult_reg <= ALUResultE;
WriteData_reg <= WriteDataE;
Rd_reg <= RdE;
PCPlus4_reg <= PCPlus4E;


end



end




assign PCSrcE = zeroE & BranchE; 
assign RegWriteM = RegWrite_reg;
assign MemWriteM = MemWrite_reg;
assign ResultSrcM = ResultSrc_reg;
assign ALUResultM = ALUResult_reg;
assign WriteDataM = WriteData_reg;
assign RdM = Rd_reg;
assign PCPlus4M = PCPlus4_reg;
















endmodule
