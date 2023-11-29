module data_memory(

input clk,reset,WE,
input [31:0]A,WD,

output [31:0]RD

);


reg [31:0] memory [1023:0];


always @(posedge clk) begin

if(WE) begin
memory[A] <= WD;
end


end


assign RD = (reset) ? 32'h00000000 : memory[A];


wire _unused_ok = &{1'b0,
                    A[31:10],
                    
                    1'b0};

endmodule
