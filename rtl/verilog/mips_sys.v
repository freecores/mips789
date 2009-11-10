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


module mips_sys (
    input clk,
    input rst,
    input [31:0] zz_din, 
    input [31:0] zz_ins_i, 
    output [31:0] zz_addr_o, 
    output [31:0] zz_dout,
    output [31:0] zz_pc_o, 
    output [3:0] zz_wr_en_o,
  input tdi,
  output tdo,
  output tms,
  output tck,
  //
    input int2,int1,
  inout [15:0] usb_data ,
  output addr0, addr1, cs,wr,rd,oe,pkt_end   ,led ,oe573
    ) ;


    wire [31:0] cop_addr;
    wire [3:0] cop_mem_ctl;
    wire [31:0] data2cop;
    wire [31:0]cop_data;
    wire clk_sys=clk;
    wire [31:0]irq_addr;
    wire w_irq;

    mips_core i_mips_core
              (
                  .clk(clk_sys),
                  .cop_addr_o(cop_addr),
                  .cop_data_o(data2cop),
                  .cop_dout(cop_data),
                  .cop_mem_ctl_o(cop_mem_ctl),
                  .irq_addr(irq_addr),
                  .irq_i(1'b0),
                  .rst(rst),
                  .zz_addr_o(zz_addr_o),
                  .zz_din(zz_din),
                  .zz_dout(zz_dout),
                  .zz_ins_i(zz_ins_i),
                  .zz_pc_o(zz_pc_o),
                  .zz_wr_en_o(zz_wr_en_o)
              );

    mips_dvc imips_dvc(
                 .din(data2cop),
                 .clk(clk_sys),
                 .rst(rst),
                 .addr(cop_addr) ,
                 .mem_ctl(cop_mem_ctl),
                 .dout(cop_data),
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
  .pkt_end(pkt_end)  ,
  .led(led)  ,
  .oe573(oe573)
  );

endmodule


