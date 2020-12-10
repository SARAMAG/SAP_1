module MAR (LM,clk,clr,MAR_in,MAR_out);
 input       LM,clk,clr;
 input  [3:0]MAR_in;
 output [3:0]MAR_out;
 reg [3:0]temp;
 
 always@(posedge clk)
 begin
 if (clr)    temp<=4'b0;
 else if(LM) temp<=MAR_in;
 else        temp<=temp;
 end
 
 assign MAR_out=temp;
 endmodule
 
 //-----testbench-----
 module Sim_MAR;
 reg       LM,clk,clr;
 reg  [3:0]MAR_in;
 wire [3:0]MAR_out;
   MAR H(LM,clk,clr,MAR_in,MAR_out);
   initial
   begin
         clk=1'b0; LM=1'b0; clr=1'b1; MAR_in=4'd5;// clear
   #100            LM=1'b1; clr=1'b1; //
   #100            LM=1'b1; clr=1'b0; // load
   #100            LM=1'b1; clr=1'b0;  MAR_in=4'd15;//load
   #100            LM=1'b0; clr=1'b1;
   end
   always
   #50 clk=~clk;
   endmodule