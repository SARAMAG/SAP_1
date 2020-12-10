module IR (LI,EI,clk,clr,IR_in,IR_Add,IR_Op_code);
 input       LI,EI,clk,clr;
 input  [7:0]IR_in;
 output [3:0]IR_Add,IR_Op_code;
 reg [7:0]temp;
 
 always@(posedge clk)
 begin
 if (clr)      temp<=8'b0;
 else if(LI) temp<=IR_in;
 else          temp<=temp;
 end
 
 assign IR_Add=(EI)?temp[3:0]:4'bz;
 assign IR_Op_code =     temp[7:4];
 
 endmodule
 
 //-----testbench-----
 module Sim_IR;
 reg       LI,EI,clk,clr;
 reg  [7:0]IR_in;
 wire [3:0]IR_Add,IR_Op_code;
IR G(LI,EI,clk,clr,IR_in,IR_Add,IR_Op_code);
   initial
   begin
      clk=1'b0; LI=1'b0; EI=1'b0; clr=1'b1; IR_in=8'b1001_1000;// clEIr
#100            LI=1'b1; EI=1'b0; clr=1'b1; IR_in=8'b1001_1000;
#100            LI=1'b1; EI=1'b0; clr=1'b0; IR_in=8'b1001_1000;
#100            LI=1'b0; EI=1'b1; clr=1'b0; IR_in=8'b1001_1000;
#100            LI=1'b0; EI=1'b0; clr=1'b0; IR_in=8'b1001_1000;
   end
   always
   #50 clk=~clk;
   endmodule