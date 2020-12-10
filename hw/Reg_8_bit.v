module Reg_8_bit (LR,clk,clr,Reg_8_bit_in,Reg_8_bit_out);
 input       LR,clk,clr;
 input  [7:0]Reg_8_bit_in;
 output [7:0]Reg_8_bit_out;
 reg [7:0]temp;
 
 always@(posedge clk)
 begin
 if (clr)    temp<=8'b0;
 else if(LR) temp<=Reg_8_bit_in;
 else        temp<=temp;
 end
 
 assign Reg_8_bit_out=temp;
 endmodule
 
 //-----testbench-----
 module Sim_Reg_8_bit;
 reg       LR,clk,clr;
 reg  [7:0]Reg_8_bit_in;
 wire [7:0]Reg_8_bit_out;
   Reg_8_bit H(LR,clk,clr,Reg_8_bit_in,Reg_8_bit_out);
   initial
   begin
         clk=1'b0; LR=1'b0; clr=1'b1; Reg_8_bit_in=8'h25;// clear
   #100            LR=1'b1; clr=1'b1; //
   #100            LR=1'b1; clr=1'b0; // load
   #100            LR=1'b1; clr=1'b0;  Reg_8_bit_in=8'hf7;//load
   #100            LR=1'b0; clr=1'b1;
   end
   always
   #50 clk=~clk;
   endmodule