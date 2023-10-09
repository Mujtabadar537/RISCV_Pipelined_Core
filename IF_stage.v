`include "instruction_memory.v"
`include "multiplexer.v"
`include "program_counter.v"
`include "adder.v"

module IF_stage(

input clk,reset,
input [31:0]PCTargetE,
input PCSrcE,

output reg [31:0]InstrD,
output reg [31:0]pcD,
output reg [31:0]PCPlus4D


);

//interim wires
wire [31:0]pcF;
wire [31:0]pcnext;
wire [31:0]PCPlus4F;
wire [31:0]InstrF;


//components
instruction_memory IM(

.reset(reset),
.A(pcF),

.RD(InstrF)


);




program_counter PC(

.clk(clk),.reset(reset),
.pcnext(pcnext),

.pc(pcF)

);



multiplexer MUX_IF(

.in1(PCPlus4F),
.in2(PCTargetE),
.sel(PCSrcE),

.out(pcnext)

);



adder ADD4(

.in1(pcF),
.in2(32'h4),
.out(PCPlus4F)

);


//Instruction Fetch register
reg [31:0]pcD_reg;
reg [31:0]PCPlus4d_reg;
reg [31:0]InstrF_reg;


//logic for Instruction fetch register
always @(posedge clk , posedge reset) begin

if(reset) begin

pcD_reg <= 0;
PCPlus4d_reg <= 0;
InstrF_reg <= 0;

end


else begin

pcD_reg <= pcF;
PCPlus4d_reg <= PCPlus4F;
InstrF_reg <= InstrF;

end


assign InstrD = InstrF_reg;
assign pcD = pcD_reg;
assign PCPlus4D = PCPlus4d_reg;




end






endmodule
