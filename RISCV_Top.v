`include "IF_stage.v"
`include "ID_stage.v"
`include "EXE_stage.v"
`include "MA_stage.v"
`include "WB_stage.v"
`include "hazard_detection_unit.v"


module RISCV_Top(

input clk,reset

);


wire PCSrcE_wire;
wire [31:0]PCTargetE_wire;
wire [31:0]pc_wire;
wire [31:0]instruction_wire;
wire [31:0]PCPlus4D_wire;
wire [31:0]PCPlus4E_wire;
wire [31:0]PCPlus4M_wire;
wire [31:0]PCPlus4W_wire;
wire RegWriteE_wire;
//wire RegWriteW_wire;
wire RegWriteM_wire;
wire [1:0]ResultSrcE_wire;
wire [1:0]ResultSrcM_wire;
wire [1:0]ResultSrcW_wire;
wire MemWriteE_wire;
wire MemWriteM_wire;
wire Branch_wire;
wire [2:0]ALUControl_wire;
wire ALUSrc_wire;
wire [4:0]Rd_wire;
wire [31:0]ImmExt_wire;
wire [31:0]Result_wire;
wire [31:0]RD1_wire,RD2_wire;
wire [31:0]ALUResultM_wire;
wire [31:0]ALUResultW_wire;
wire [31:0]WriteData_wire;
wire [31:0]ReadData_wire;
wire [31:0]pcE_wire;
wire [4:0]RdM_wire;

wire [4:0]RdW_HDU;
wire RegWriteW_HDU;
wire [1:0]ForwardAE,ForwardBE;
wire [4:0]Rs1_HDU,Rs2_HDU;



IF_stage instruction_fetch(

.clk(clk),.reset(reset),
.PCTargetE(PCTargetE_wire),
.PCSrcE(PCSrcE_wire),

.InstrD(instruction_wire),
.pcD(pc_wire),
.PCPlus4D(PCPlus4D_wire)


);





ID_stage instruction_decode(

.clk(clk),.reset(reset),
.InstrD(instruction_wire),
.PCD(pc_wire),
.RegWriteW(RegWriteW_HDU),
.RdW(RdW_HDU),
.PCPlus4D(PCPlus4D_wire),
.ResultW(Result_wire),




//.PCSrcE(PCSrcE_wire),
.MemWriteE(MemWriteE_wire),.ALUSrcE(ALUSrc_wire),.RegWriteE(RegWriteE_wire),
.ResultSrcE(ResultSrcE_wire),
.ALUControlE(ALUControl_wire),
.PCE(pcE_wire),.PCPlus4E(PCPlus4E_wire),
.Rs1E(Rs1_HDU),.Rs2E(Rs2_HDU),.RdE(Rd_wire),
.ImmExtE(ImmExt_wire),
.RD1E(RD1_wire),.RD2E(RD2_wire),
.BranchE(Branch_wire)


);




EXE_stage execute_stage(

.clk(clk),.reset(reset),
.MemWriteE(MemWriteE_wire),.ALUSrcE(ALUSrc_wire),.RegWriteE(RegWriteE_wire),
.ResultSrcE(ResultSrcE_wire),
.ALUControlE(ALUControl_wire),
.RD1E(RD1_wire),.RD2E(RD2_wire),
.PCE(pcE_wire),
.RdE(Rd_wire),
.ImmExtE(ImmExt_wire),
.PCPlus4E(PCPlus4E_wire),
.ForwardAE(ForwardAE),.ForwardBE(ForwardBE),
//.ResultW(),
.BranchE(Branch_wire),
.ResultW(Result_wire),


.PCSrcE(PCSrcE_wire),
.PCTargetE(PCTargetE_wire),
.RegWriteM(RegWriteM_wire),.MemWriteM(MemWriteM_wire),
.ResultSrcM(ResultSrcM_wire),
.ALUResultM(ALUResultM_wire),.WriteDataM(WriteData_wire),
.RdM(RdM_wire),
.PCPlus4M(PCPlus4M_wire)


);




MA_stage memory_access_stage(

.clk(clk),.reset(reset),
.RegWriteM(RegWriteM_wire),.MemWriteM(MemWriteM_wire),
.ResultSrcM(ResultSrcM_wire),
.ALUResultM(ALUResultM_wire),.WriteDataM(WriteData_wire),
.RdM(RdM_wire),
.PCPlus4M(PCPlus4M_wire),



.RegWriteW(RegWriteW_HDU),.ResultSrcW(ResultSrcW_wire),
.ALUResultW(ALUResultW_wire),
.ReadDataW(ReadData_wire),
.RdW(RdW_HDU),
.PCPlus4W(PCPlus4W_wire)

);



WB_stage write_back_stage(

.ALUResultW(ALUResultW_wire),
.ReadDataW(ReadData_wire),
.PCPlus4W(PCPlus4W_wire),
.ResultSrcW(ResultSrcW_wire),

.ResultW(Result_wire)



);




hazard_detection_unit HDU(

.reset(reset),.RegWriteM(RegWriteM_wire),.RegWriteW(RegWriteW_HDU),
.RdM(RdM_wire),.RdW(RdW_HDU),
.Rs1E(Rs1_HDU),.Rs2E(Rs2_HDU),


.ForwardAE(ForwardAE),.ForwardBE(ForwardBE)


);


endmodule
