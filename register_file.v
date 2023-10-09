module register_file(

input clk,reset,WE3,
input [4:0]A1,A2,A3,
input [31:0]WD3,

output [31:0]RD1,RD2


);


reg [31:0] register [31:0];


always @(reset) begin

if(reset == 1) begin

register[0] <= 32'h0;
register[1] <= 32'h1;
register[2] <= 32'h2;
register[3] <= 32'h3;
register[4] <= 32'h4;
register[5] <= 32'h5;
register[6] <= 32'h6;
register[7] <= 32'h7;
register[8] <= 32'h8;
register[9] <= 32'h9;
register[10] <= 32'h10;
register[11] <= 32'h11;
register[12] <= 32'h12;
register[13] <= 32'h13;
register[14] <= 32'h14;
register[15] <= 32'h15;
register[16] <= 32'h16;
register[17] <= 32'h17;
register[18] <= 32'h18;
register[19] <= 32'h19;
register[20] <= 32'h20;
register[21] <= 32'h21;
register[22] <= 32'h22;
register[23] <= 32'h23;
register[24] <= 32'h24;
register[25] <= 32'h25;
register[26] <= 32'h26;
register[27] <= 32'h27;
register[28] <= 32'h28;
register[29] <= 32'h29;
register[30] <= 32'h30;
register[31] <= 32'h31;


end




end



always @(posedge clk) begin

if(WE3) begin
register[A3] <= WD3;
end


end


assign RD1 = (reset) ? 32'h00000000 : register[A1];
assign RD2 = (reset) ? 32'h00000000 : register[A2];




endmodule
