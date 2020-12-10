module SAP_1 (clk,clr,DataOut);
  input       clk,clr;
  output [7:0]DataOut;
  wire [11:0] CON;
  wire [07:0] RAM_out,W_Bus,A,B;
  wire [05:0] State;
  wire [03:0] PC_out,MAR_out,IR_Op_code;
//11 10 09 08 07 06 05 04 03 02 01 00
//CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
PC  Com0(.CP (CON[11]),.clk (clk),.clr (clr),.EP (CON[10]),.PC_out (W_Bus[3:0]));
MAR Com1(.LM (CON[9]),.clk (clk),.clr (clr),.MAR_in (W_Bus[3:0]),.MAR_out (MAR_out));
RAM Com2(.CE (CON[8]),.clk (clk),.clr (clr),.RAM_add (MAR_out),.RAM_out (W_Bus));
IR Com3(.LI (CON[7]),.EI (CON[6]),.clk (clk),.clr (clr),.IR_in (W_Bus),.IR_Add (W_Bus[3:0]),.IR_Op_code (IR_Op_code));
Ring_counter Com4(.clk (clk),.clr (clr),.State (State));
Con_Seq Com5(.Op_code (IR_Op_code),.State (State),.Con_signals (CON));
Acc Com6(.LA (CON[5]),.EA (CON[4]),.clk (clk),.clr (clr),.Acc_in (W_Bus),.Acc_out_Bus (W_Bus),.Acc_out_Su (A));
addsub Com7(.Su (CON[3]),.Eu (CON[2]),.ina (A),.inb (B),. result (W_Bus));
Reg_8_bit B_reg(.LR (CON[1]),.clk (clk),.clr (clr),.Reg_8_bit_in (W_Bus),.Reg_8_bit_out (B));
Reg_8_bit Out_reg(.LR (CON[0]),.clk (clk),.clr (clr),.Reg_8_bit_in (W_Bus),.Reg_8_bit_out (DataOut));

endmodule  

module Sim_SAP_1;
  reg       clk,clr;
  wire [7:0]DataOut;
SAP_1 F(clk,clr,DataOut);
   initial
   begin
      clk=1'b1;  clr=1'b1;// clear
#070             clr=1'b0;   end
   always
   #50 clk=~clk;
   endmodule