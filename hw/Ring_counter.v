module Ring_counter (clk,clr,State);
 input       clk,clr;
 output reg[5:0]State;
 //reg [3:0]temp;
 
 always@(negedge clk)
 begin
 if (clr)    State<=6'b00_0001; //
 else        State<={State[4:0],State[5]};
 end

 endmodule
 
 //-----testbench-----
 module Sim_Ring_counter;
 reg        clk,clr;
 wire [5:0] State;
 Ring_counter G(clk,clr,State);   
 initial
   begin
         clk=1'b0;  clr=1'b1;// clear
   #100             clr=1'b0; //
   #1500            clr=1'b1;
   end
   always
   #50 clk=~clk;
   endmodule