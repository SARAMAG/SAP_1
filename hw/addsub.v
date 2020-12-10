module addsub(Su,Eu,ina,inb, result);
input Su, Eu;
parameter wordsize = 8;
input [wordsize-1:0] ina, inb;
output [wordsize-1:0] result;
assign result = Eu?(Su?ina-inb:ina+inb):8'bz;
endmodule