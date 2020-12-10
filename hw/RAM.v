module RAM (CE,clk,clr,RAM_add,RAM_out);
 input       CE,clk,clr;
 input  [3:0]RAM_add;
 output [7:0]RAM_out;
 reg    [7:0]Temp;
 reg [7:0]MEM[0:15];
 
 always@(posedge clk)
 if (clr) begin
          MEM[00]<=8'b0000_1111;//LDA Fh   5+3-1=7
          MEM[01]<=8'b0001_1110;//ADD EH 
		  MEM[02]<=8'b0010_1101;//SUB DH 
		  MEM[03]<=8'b1110_xxxx;//OUT
          MEM[04]<=8'b1111_xxxx;//HLT 
		  MEM[05]<=8'd5; 
		  MEM[06]<=8'd6; 
		  MEM[07]<=8'd7;
          MEM[08]<=8'b0; 
		  MEM[09]<=8'b0; 
		  MEM[10]<=8'b0; 
		  MEM[11]<=8'b0;
          MEM[12]<=8'b0; 
		  MEM[13]<=8'd1; 
		  MEM[14]<=8'd3; 
		  MEM[15]<=8'd5;
		  end
else 
          MEM[RAM_add]<=MEM[RAM_add];
		  
 assign RAM_out=(CE)?MEM[RAM_add]:8'bz; 
 endmodule
 
 //-----testbench-----
 module Sim_RAM;
 reg       CE,clk,clr;
 reg  [3:0]RAM_add;
 wire [7:0]RAM_out;
RAM K(CE,clk,clr,RAM_add,RAM_out);
   initial
   begin
      clk=1'b0; clr=1'b1; RAM_add=8'b0;// clear
#100            clr=1'b0; CE=1'b1;
   end
   always
   #50 clk=~clk;
   always
   #70 RAM_add=RAM_add+$random;
   endmodule