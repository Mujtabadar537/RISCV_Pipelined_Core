`include "data_memory.v"

module MA_stage(

input clk,reset,
input RegWriteM,
input MemWriteM,
input [1:0]ResultSrcM,
input [31:0]ALUResultM,WriteDataM,
input [4:0]RdM,
input [31:0]PCPlus4M,



output RegWriteW,
output [1:0]ResultSrcW,
output [31:0]ALUResultW,
output [31:0]ReadDataW,
output [4:0]RdW,
output [31:0]PCPlus4W

);


wire [31:0]RDM;


data_memory DM(

.clk(clk),.reset(reset),.WE(MemWriteM),
.A(ALUResultM),.WD(WriteDataM),

.RD(RDM)

);




reg RegWrite_reg;
reg [1:0]ResultSrcW_reg;
reg [31:0]ALUResult_reg;
reg [31:0]ReadData_reg;
reg [4:0]Rd_reg;
reg [31:0]PCPlus4_reg;



always @(posedge clk , posedge reset) begin

if(reset) begin

RegWrite_reg <= 0;
ResultSrcW_reg <= 0;
ALUResult_reg <= 0;
ReadData_reg <= 0;
Rd_reg <= 0;
PCPlus4_reg <= 0;


end



else begin

RegWrite_reg <= RegWriteW;
ResultSrcW_reg <= ResultSrcW;
ALUResult_reg <= ALUResultW;
ReadData_reg <= ReadDataW;
Rd_reg <= RdM;
PCPlus4_reg <= PCPlus4W;


end




end



assign RegWriteW = RegWrite_reg;
assign ResultSrcW = ResultSrcW_reg;
assign ALUResultW = ALUResult_reg;
assign ReadDataW = ReadData_reg;
assign RdW = Rd_reg;
assign PCPlus4W = PCPlus4_reg;


wire _unused_ok = &{1'b0,
                    RegWriteM,
                    PCPlus4M,
                    ResultSrcM,
                    RDM, // To be fixed
                    1'b0};





endmodule
