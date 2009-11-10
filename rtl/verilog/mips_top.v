/******************************************************************
 *                                                                * 
 *    Author: Liwei                                               * 
 *                                                                * 
 *    This file is part of the "mips789" project.                 * 
 *    Downloaded from:                                            * 
 *    http://www.opencores.org/pdownloads.cgi/list/mips789        * 
 *                                                                * 
 *    If you encountered any problem, please contact me via       * 
 *    Email:mcupro@opencores.org  or mcupro@163.com               * 
 *                                                                * 
 ******************************************************************/

`include "mips789_defs.v" 	
// synopsys translate_off
`define  use_rst		   
// synopsys translate_on

`define  use_rst
module mips_top (
        input clk,
        `ifdef use_rst
    input rst,
    `endif
 
  input tdi,
  output tdo,
  output tms,
  output tck,
      input int2,int1,
  inout [15:0] usb_data ,
  output addr0, addr1, cs,wr,rd,oe,pkt_end  ,led  ,oe573	  ,
  input pa1,pa3,
  output trst,brst,dint
  ); 
    
    `ifndef use_rst
       wire rst = 1'b1;
    `endif 
   assign trst=1'b1;
   assign brst=1'b1;
   assign dint=1'b1;

    wire [31:0] data2core;
    wire [31:0] data2mem;
    wire [31:0] ins2core;
    wire [31:0] mem_Addr;
    wire [31:0] pc;
    wire [3:0] wr_en;
    wire CLK;
    reg r_rst,rr_rst; 
    always @(posedge CLK)
        r_rst<=rst; 
    always @(posedge CLK)
        rr_rst<=r_rst; 
    wire sys_rst = rr_rst;		 
//	assign CLK = clk; 
pll24_80 PLL(
	.inclk0(clk),
	.c0(CLK));
// synopsys translate_off
 `define  just_sim			   
// synopsys translate_on

`ifdef just_sim						  

    sim_mem_array sim_array 
`else 	 

		   mem_array ram_8k//FPGA RAM
`endif
              (
                  .clk(CLK),
                  .pc_i(pc),
                  .ins_o(ins2core),
                  .wren(wr_en),
                  .din(data2mem),
                  .data_addr_i(mem_Addr),
                  .dout(data2core)
              );

    mips_sys isys
             (
                 .zz_addr_o(mem_Addr),
                 .zz_din(data2core),
                 .zz_dout(data2mem),
                 .zz_ins_i(ins2core),
                 .zz_pc_o(pc),
                 .zz_wr_en_o(wr_en),

                 .clk(CLK),
                 .rst(sys_rst),
  				.tdi(tdi),
 				.tdo(tdo),
 				.tms(tms),
 				.tck(tck),
 				  .int2(int2),
  .int1(int1),
  .usb_data(usb_data) ,
  .addr0(addr0), 
  .addr1(addr1), 
  .cs(cs),
  .wr(wr),
  .rd(rd),
  .oe(oe),
  .pkt_end(pkt_end)   ,
  .led(led) ,
  .oe573(oe573)
             );
endmodule


