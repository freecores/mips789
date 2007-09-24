module altpll_Z1 (inclk,fbin,pllena,clkswitch,areset,pfdena,clkena,extclkena,scanclk,scanaclr,scanread,scanwrite,scandata,clk,extclk,clkbad,enable0,enable1,activeclock,clkloss,locked,scandataout,scandone,sclkout0,sclkout1);
input [1:0]inclk;
input fbin;
input pllena;
input clkswitch;
input areset;
input pfdena;
input [5:0]clkena;
input [3:0]extclkena;
input scanclk;
input scanaclr;
input scanread;
input scanwrite;
input scandata;
output [5:0]clk;
output [3:0]extclk;
output [1:0]clkbad;
output enable0;
output enable1;
output activeclock;
output clkloss;
output locked;
output scandataout;
output scandone;
output sclkout0;
output sclkout1;
endmodule

module altsyncram_Z2 (wren_a,wren_b,rden_b,data_a,data_b,address_a,address_b,clock0,clock1,clocken0,clocken1,aclr0,aclr1,byteena_a,byteena_b,addressstall_a,addressstall_b,q_a,q_b);
input wren_a;
input wren_b;
input rden_b;
input [7:0]data_a;
input [7:0]data_b;
input [10:0]address_a;
input [10:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
input aclr0;
input aclr1;
input [0:0]byteena_a;
input [0:0]byteena_b;
input addressstall_a;
input addressstall_b;
output [7:0]q_a;
output [7:0]q_b;
endmodule

module altsyncram_Z3 (wren_a,wren_b,rden_b,data_a,data_b,address_a,address_b,clock0,clock1,clocken0,clocken1,aclr0,aclr1,byteena_a,byteena_b,addressstall_a,addressstall_b,q_a,q_b);
input wren_a;
input wren_b;
input rden_b;
input [7:0]data_a;
input [7:0]data_b;
input [10:0]address_a;
input [10:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
input aclr0;
input aclr1;
input [0:0]byteena_a;
input [0:0]byteena_b;
input addressstall_a;
input addressstall_b;
output [7:0]q_a;
output [7:0]q_b;
endmodule

module altsyncram_Z4 (wren_a,wren_b,rden_b,data_a,data_b,address_a,address_b,clock0,clock1,clocken0,clocken1,aclr0,aclr1,byteena_a,byteena_b,addressstall_a,addressstall_b,q_a,q_b);
input wren_a;
input wren_b;
input rden_b;
input [7:0]data_a;
input [7:0]data_b;
input [10:0]address_a;
input [10:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
input aclr0;
input aclr1;
input [0:0]byteena_a;
input [0:0]byteena_b;
input addressstall_a;
input addressstall_b;
output [7:0]q_a;
output [7:0]q_b;
endmodule

module altsyncram_Z5 (wren_a,wren_b,rden_b,data_a,data_b,address_a,address_b,clock0,clock1,clocken0,clocken1,aclr0,aclr1,byteena_a,byteena_b,addressstall_a,addressstall_b,q_a,q_b);
input wren_a;
input wren_b;
input rden_b;
input [7:0]data_a;
input [7:0]data_b;
input [10:0]address_a;
input [10:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
input aclr0;
input aclr1;
input [0:0]byteena_a;
input [0:0]byteena_b;
input addressstall_a;
input addressstall_b;
output [7:0]q_a;
output [7:0]q_b;
endmodule

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

module scfifo_Z6 (data,clock,wrreq,rdreq,aclr,sclr,q,usedw,full,empty,almost_full,almost_empty);
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

