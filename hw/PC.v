module PC (CP,clk,clr,EP,PC_out);
 input       CP,clk,clr,EP;
 output [3:0]PC_out;
 reg [3:0]temp;

 always@(posedge clk)
 begin
 if (clr)    temp<=4'b0;
 else if(CP) temp<=temp + 1'b1;
 else        temp<=temp;
 end
 
 assign PC_out= (EP)? temp:4'bz;
 endmodule
 
 //-----testbench-----
 module Sim_PC;
 reg       CP,clk,clr,EP;
 wire [3:0]PC_out;
   PC T(CP,clk,clr,EP,PC_out);
   initial
   begin
         clk=1'b0;  clr=1'b1; CP=1'b1; EP=1'b1;// clear
   #100             clr=1'b0; CP=1'b1; EP=1'b1; // count , En
   #100             clr=1'b0; CP=1'b1; EP=1'b0; //
   #100             clr=1'b0; CP=1'b0; EP=1'b1; //
   end
   always
   #50 clk=~clk;
   endmodule