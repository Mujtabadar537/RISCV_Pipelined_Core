module FORWARDING_UNIT(
  input [4:0] Rs1,
  input [4:0] Rs2,
  input RegWrite_MEMORYACCESS,
  input RegWrite_WRITEBACK,
  input [4:0] WriteRegister_MEMORYACCESS,
  input [4:0] WriteRegister_WRITEBACK,
  
  
  output logic [1:0]ForwardA,
  output logic [1:0]ForwardB
);

  always_comb begin

    if (RegWrite_MEMORYACCESS) begin
      if (WriteRegister_MEMORYACCESS != 5'b00000) begin
        if (WriteRegister_MEMORYACCESS == Rs1) begin
          ForwardA = 2'b10;
        end else begin
          ForwardA = 2'b00;
        end
      end
      
      
    if (WriteRegister_MEMORYACCESS == Rs2) begin
        ForwardB = 2'b10;
      end else begin
        ForwardB = 2'b00;
      end
    end
    
    

    if (RegWrite_WRITEBACK) begin
      if (WriteRegister_WRITEBACK != 5'b00000) begin
        if (WriteRegister_WRITEBACK == Rs1) begin
          ForwardA = 2'b01;
        end else begin
          ForwardA = 2'b00;
        end
      end
      
      
      if (WriteRegister_WRITEBACK == Rs2) begin
        ForwardB = 2'b01;
      end 
      else begin
        ForwardB = 2'b00;
      end
    end
   end
  
  
endmodule
