

module mips_led (clk,key2,rst,cop_data,irq_addr,seg7led1,seg7led2) ;
input clk;
wire clk;
input key2;
wire key2;
input rst;
wire rst;
input [31:0] cop_data;
wire [31:0] cop_data;
input [31:0] irq_addr;
wire [31:0] irq_addr;
output [6:0] seg7led1;
wire [6:0] seg7led1;
output [6:0] seg7led2;
wire [6:0] seg7led2;

wire [31:0] cop_addr;
wire [3:0] cop_mem_ctl;
wire [31:0] data2cop;
wire [31:0] data2core;
wire [31:0] data2mem;
wire [31:0] ins2core;
wire [31:0] mem_Addr;
wire [31:0] pc;
wire [3:0] wr_en;

mips_core1 mips_core_
(
	.clk(clk),
	.cop_addr_o(cop_addr),
	.cop_data_o(data2cop),
	.cop_dout(cop_data),
	.cop_mem_ctl_o(cop_mem_ctl),
	.irq_addr(irq_addr),
	.irq_i(key2),
	.rst(rst),
	.zz_addr_o(mem_Addr),
	.zz_din(data2core),
	.zz_dout(data2mem),
	.zz_ins_i(ins2core),
	.zz_pc_o(pc),
	.zz_wr_en_o(wr_en)
);



mem_array ram_4k
(
	.clk(clk),
	.din(data2mem),
	.dout(data2core),
	.ins_o(ins2core),
	.pc_i(pc),
	.rd_addr_i(mem_Addr),
	.wr_addr_i(mem_Addr),
	.wren(wr_en)
);



mips_seg7led seg7led
(
	.addr_i(cop_addr),
	.clk(clk),
	.din(data2cop),
	.dmem_ctl_i(cop_mem_ctl),
	.rst(rst),
	.seg7led1(seg7led1),
	.seg7led2(seg7led2)
);



endmodule 
