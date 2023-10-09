module hazard_detection_unit(

input reset,RegWriteM,RegWriteW,
input [4:0]RdM,RdW,
input [4:0]Rs1E,Rs2E,


output [1:0]ForwardAE,ForwardBE


);



assign ForwardAE = (reset == 1) ? 2'b00 : 
		   ((RegWriteM == 1) & (RdM != 5'b00000) & (RdM == Rs1E)) ? 2'b10 :
		   ((RegWriteW == 1) & (RdM != 5'b00000) & (RdM == Rs1E)) ? 2'b01 : 2'b00 ;





assign ForwardBE = (reset == 1) ? 2'b00 : 
		   ((RegWriteM == 1) & (RdM != 5'b00000) & (RdM == Rs2E)) ? 2'b10 :
		   ((RegWriteW == 1) & (RdM != 5'b00000) & (RdM == Rs2E)) ? 2'b01 : 2'b00 ;






endmodule
