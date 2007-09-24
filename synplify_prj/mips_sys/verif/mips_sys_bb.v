module synplicity_altsyncram4_r_w_reg_array (wren_a,wren_b,data_a,address_a,address_b,clock0,clock1,clocken0,clocken1,q_b);
input wren_a;
input wren_b;
input [31:0]data_a;
input [4:0]address_a;
input [4:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
output [31:0]q_b;
endmodule

module scfifo_Z1 (data,clock,wrreq,rdreq,aclr,sclr,q,usedw,full,empty,almost_full,almost_empty);
input [7:0]data;
input clock;
input wrreq;
input rdreq;
input aclr;
input sclr;
output [7:0]q;
output [8:0]usedw;
output full;
output empty;
output almost_full;
output almost_empty;
endmodule

