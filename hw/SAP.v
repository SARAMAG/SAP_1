





//CONTROL_SEQ 

module control_unit(clk,  clr, cntrl_bus, opcode);
input clk,clr;
parameter opcodesize = 4;
input [opcodesize-1:0] opcode;
parameter cntrlbussize = 12;
parameter T1 = 6'b000001,
   T2 = 6'b000010,
   T3 = 6'b000100,
   T4 = 6'b001000,
   T5 = 6'b010000,
   T6 = 6'b100000;
output [cntrlbussize-1:0] cntrl_bus;
// ring counter 
reg [5:0]  ringcount;
reg [cntrlbussize-1:0] cntrl_bus;
wire [5:0]state ;
always @ (negedge clk)
begin
if (clr)
 ringcount = 6'b000001;
else case(ringcount)
 T1: ringcount <= T2;
 T2: ringcount <= T3;
 T3: ringcount <= T4;
 T4: ringcount <= T5;
 T5: ringcount <= T6; 
 T6: ringcount <= T1;
 endcase
end

assign state = ringcount;
always @(negedge clk)
case ({state, opcode})
{T1, 4'hx}: cntrl_bus = 12'h5E3;    //fetch cycle   PC -> MAR
{T2, 4'hx}: cntrl_bus = 12'hBE3;
{T3, 4'hx}: cntrl_bus = 12'h263;  //fetch cycle 
//LDA operation
{T4, 4'h0}: cntrl_bus = 12'h1A3;
{T5, 4'h0}: cntrl_bus = 12'h2C3;
{T6, 4'h0}: cntrl_bus = 12'h3E3;
//ADD
{T4, 4'h1}: cntrl_bus = 12'h1A3;
{T5, 4'h1}: cntrl_bus = 12'h2E1;
{T6, 4'h1}: cntrl_bus = 12'h3C7;
//SUB
{T4, 4'h2}: cntrl_bus = 12'h1A3;
{T5, 4'h2}: cntrl_bus = 12'h2E1;
{T6, 4'h2}: cntrl_bus = 12'h3EF;
//OUT
{T4, 4'he}: cntrl_bus = 12'h3F2;
{T5, 4'he}: cntrl_bus = 12'h3E3;
{T6, 4'he}: cntrl_bus = 12'h3E3;
//HLT
{T4, 4'hf}: cntrl_bus = 12'h3E3;
{T5, 4'hf}: cntrl_bus = 12'h3E3;
{T6, 4'hf}: cntrl_bus = 12'h3E3;
endcase
endmodule