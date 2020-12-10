module Acc (LA,EA,clk,clr,Acc_in,Acc_out_Bus,Acc_out_Su);
 input       LA,EA,clk,clr;
 input  [7:0]Acc_in;
 output [7:0]Acc_out_Bus,Acc_out_Su;
 reg [7:0]temp;
 
 always@(posedge clk)
 begin
 if (clr)      temp<=8'b0;
 else if(LA) temp<=Acc_in;
 else          temp<=temp;
 end
 
 assign Acc_out_Bus=(EA)?temp:8'bz;
 assign Acc_out_Su =     temp;
 
 endmodule
 
 //-----testbench-----
 module Sim_Acc;
 reg       LA,EA,clk,clr;
 reg  [7:0]Acc_in;
 wire [7:0]Acc_out_Bus,Acc_out_Su;
Acc G(LA,EA,clk,clr,Acc_in,Acc_out_Bus,Acc_out_Su);
   initial
   begin
      clk=1'b0; LA=1'b0; EA=1'b0; clr=1'b1; Acc_in=8'b1001_1000;// clear
#100            LA=1'b1; EA=1'b0; clr=1'b1; Acc_in=8'b1001_1000;
#100            LA=1'b1; EA=1'b0; clr=1'b0; Acc_in=8'b1001_1000;
#100            LA=1'b0; EA=1'b1; clr=1'b0; Acc_in=8'b1001_1000;
#100            LA=1'b0; EA=1'b0; clr=1'b0; Acc_in=8'b1001_1000;
   end
   always
   #50 clk=~clk;
   endmodule