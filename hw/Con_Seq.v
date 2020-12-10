module Con_Seq (Op_code,State,Con_signals);
 input       [03:0]Op_code;
 input       [05:0]State;
 output reg  [11:0]Con_signals;
 parameter T1=6'b00_0001,
           T2=6'b00_0010,
           T3=6'b00_0100,
           T4=6'b00_1000,
           T5=6'b01_0000,
           T6=6'b10_0000; 
 always@(*)
 begin
 case (State)
                        //CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
      T1:Con_signals<=12'b_0__1__1__0__0__0__0__0__0__0__0__0;
      T2:Con_signals<=12'b_1__0__0__0__0__0__0__0__0__0__0__0;
      T3:Con_signals<=12'b_0__0__0__1__1__0__0__0__0__0__0__0;
 //-------------------------LDA---------------------------
 default:if (Op_code==4'b0000) begin
         case(State)
	  T4:Con_signals<=12'b_0__0__1__0__0__1__0__0__0__0__0__0;
      T5:Con_signals<=12'b_0__0__0__1__0__0__1__0__0__0__0__0;
 default:Con_signals<=12'b_0__0__0__0__0__0__0__0__0__0__0__0;
         endcase
                               end
 //-------------------------ADD---------------------------
   else if (Op_code==4'b0001) 
         case(State)
                        //CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
	  T4:Con_signals<=12'b_0__0__1__0__0__1__0__0__0__0__0__0;
      T5:Con_signals<=12'b_0__0__0__1__0__0__0__0__0__0__1__0;
 default:Con_signals<=12'b_0__0__0__0__0__0__1__0__0__1__0__0;
	     endcase
//-------------------------SUB---------------------------
   else if (Op_code==4'b0010) 
         case(State)
                        //CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
	  T4:Con_signals<=12'b_0__0__1__0__0__1__0__0__0__0__0__0;
      T5:Con_signals<=12'b_0__0__0__1__0__0__0__0__0__0__1__0;
 default:Con_signals<=12'b_0__0__0__0__0__0__1__0__1__1__0__0;
         endcase
 //-------------------------OUT---------------------------
   else if (Op_code==4'b1110) 
         case(State)
                        //CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
	  T4:Con_signals<=12'b_0__0__0__0__0__0__0__1__0__0__0__1;
 default:Con_signals<=12'b_0__0__0__0__0__0__0__0__0__0__0__0;
         endcase
//-------------------------HLT---------------------------
   else //(Op_code==4'b1111) 
                        //CP_EP_LM_CE_LI_EI_LA_EA_SU_EU_LB_LO
      Con_signals<=12'b_0__0__0__0__0__0__1__0__0__1__0__0;
	  
endcase
 end
 endmodule
 
 /* 
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
   endmodule */