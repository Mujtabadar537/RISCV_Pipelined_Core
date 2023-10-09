`include "control_unit.v"
`include "register_file.v"
`include "sign_extend.v"

module ID_stage(

input clk,reset,
input [31:0]InstrD,
input [31:0]PCD,
input RegWriteW,
input [4:0]RdW,
input [31:0]PCPlus4D,
input [31:0]ResultW,



output MemWriteE,ALUSrcE,RegWriteE,
output [1:0]ResultSrcE,
output [2:0]ALUControlE,
output [31:0]PCE,PCPlus4E,
output [4:0]Rs1E,Rs2E,RdE,
output [31:0]ImmExtE,
output [31:0]RD1E,RD2E,
output BranchE

);


wire MemWriteD,ALUSrcD,RegWriteD,BranchD;
wire [1:0]ResultSrcD;
wire [1:0]ImmSrcD;
wire [2:0]ALUControlD;

wire [31:0]RD1_wire,RD2_wire,ImmExt_wire;



control_unit CU(

.op(InstrD[6:0]),
.funct3(InstrD[14:12]),
.funct7(InstrD[30]),
//.zero(),

.ResultSrc(ResultSrcD),.MemWrite(MemWriteD),.ALUSrc(ALUSrcD),.RegWrite(RegWriteD),.Branch(BranchD),
.ImmSrc(ImmSrcD),
.ALUControl(ALUControlD)


);




register_file RF(

.clk(clk),.reset(reset),.WE3(RegWriteW),
.A1(InstrD[19:15]),.A2(InstrD[24:20]),.A3(RdW),
.WD3(ResultW),

.RD1(RD1_wire),.RD2(RD2_wire)

);



sign_extend SE(

.ImmSrc(ImmSrcD),
.In(InstrD),

.ImmExt(ImmExt_wire)

);


reg MemWrite_reg,ALUSrc_reg,RegWrite_reg,Branch_reg;
reg [1:0]ResultSrc_reg;
reg [2:0]ALUControl_reg;
reg [31:0]RD1_reg,RD2_reg;
reg [31:0]ImmExt_reg;
reg [31:0]PCPlus4_reg;
reg [31:0]PC_reg;
reg [4:0]Rs1D_reg,Rs2D_reg,RdD_reg;



always @(posedge clk , posedge reset) begin

if(reset == 1) begin

//PCSrc_reg <= 0;
ResultSrc_reg <= 0;
MemWrite_reg <= 0;
ALUSrc_reg <= 0;
RegWrite_reg <= 0;
Branch_reg <= 0;
ALUControl_reg <= 0;
RD1_reg <= 0;
RD2_reg <= 0;
ImmExt_reg <= 0;
PCPlus4_reg <= 0;
PC_reg <= 0;
Rs1D_reg <= 0;
Rs2D_reg <= 0;
RdD_reg <= 0;


end


else begin

//PCSrc_reg <= PCSrcD;
ResultSrc_reg <= ResultSrcD;
MemWrite_reg <= MemWriteD;
ALUSrc_reg <= ALUSrcD;
RegWrite_reg <= RegWriteD;
Branch_reg <= BranchD;
ALUControl_reg <= ALUControlD;
RD1_reg <= RD1_wire;
RD2_reg <= RD2_wire;
ImmExt_reg <= ImmExt_wire;
PCPlus4_reg <= PCPlus4D;
PC_reg <= PCD;
Rs1D_reg <= InstrD[19:15];
Rs2D_reg <= InstrD[24:20];
RdD_reg <= InstrD[11:7];



end



end


//assign PCSrcE = PCSrc_reg;
assign ResultSrcE = ResultSrc_reg;
assign MemWriteE = MemWrite_reg;
assign ALUSrcE = ALUSrc_reg;
assign RegWriteE = RegWrite_reg;
assign ALUControlE = ALUControl_reg;
assign PCE = PC_reg;
assign PCPlus4E = PCPlus4_reg;
assign Rs1E = Rs1D_reg;
assign Rs2E = Rs2D_reg;
assign RdE = RdD_reg;
assign ImmExtE = ImmExt_reg;
assign RD1E = RD1_reg;
assign RD2E = RD2_reg;
assign BranchE = Branch_reg;


endmodule
