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

`include "include.h"  


module mips_sys (
	`ifdef ALTERA	  
        zz_addr_o,
        zz_din,
        zz_dout,
        zz_ins_i,
        zz_pc_o,
        zz_wr_en_o 		 ,
	`endif	  				

        clk,
        rst,

        ser_rxd,
        ser_txd,

        seg7led1,
        seg7led2 ,

        lcd_data,
        lcd_rs,
        lcd_rw,
        lcd_en,

        led1,
        led2,

        key1,
        key2

    ) ;
    input key1;
    input key2;

    input clk;
    wire clk;

    input rst;
    wire rst;


    output [6:0] seg7led1;
    wire [6:0] seg7led1;
    output [6:0] seg7led2;
    wire [6:0] seg7led2;

    output [7:0]lcd_data;
    output lcd_rs;
    output 	lcd_rw ;
    output 	lcd_en	;
    output led1;
    output led2;

`ifdef	ALTERA
    input [31:0] zz_din;
    wire [31:0] zz_din;
    input [31:0] zz_ins_i;
    wire [31:0] zz_ins_i;
    output [31:0] zz_addr_o;
    wire [31:0] zz_addr_o;
    output [31:0] zz_dout;
    wire [31:0] zz_dout;
    output [31:0] zz_pc_o;
    wire [31:0] zz_pc_o;
    output [3:0] zz_wr_en_o;
    wire [3:0] zz_wr_en_o;
`endif

    input ser_rxd;
    output ser_txd;

    wire [31:0] cop_addr;
    wire [3:0] cop_mem_ctl;
    wire [31:0] data2cop;
    wire [31:0]cop_data;
    wire clk_sys;
    wire [31:0]irq_addr;
    wire w_irq;

    `ifndef ALTERA
            mem_array ram_4k
            (
                .clk(clk_sys),
                .din(data2mem),
                .dout(data2core),
                .ins_o(ins2core),
                .pc_i(pc),
                .rd_addr_i(mem_Addr),
                .wr_addr_i(mem_Addr),
                .wren(wr_en)
            );
    assign clk_sys=clk;
`else 
    assign clk_sys=clk;
`endif


    mips_core mips_core
              (
                  .clk(clk_sys),
                  .cop_addr_o(cop_addr),
                  .cop_data_o(data2cop),
                  .cop_dout(cop_data),
                  .cop_mem_ctl_o(cop_mem_ctl),
                  .irq_addr(irq_addr),
                  .irq_i(w_irq),
                  .rst(rst),

`ifdef 	ALTERA
                  .zz_addr_o(zz_addr_o),
                  .zz_din(zz_din),
                  .zz_dout(zz_dout),
                  .zz_ins_i(zz_ins_i),
                  .zz_pc_o(zz_pc_o),
                  .zz_wr_en_o(zz_wr_en_o)
`else		  	   
                  .zz_addr_o(mem_Addr),
                  .zz_din(data2core),
                  .zz_dout(data2mem),
                  .zz_ins_i(ins2core),
                  .zz_pc_o(pc),
                  .zz_wr_en_o(wr_en)
`endif
              );

    mips_dvc imips_dvc(
                 .din(data2cop),
                 .clk(clk_sys),
                 .rst(rst),
                 .addr(cop_addr) ,
                 .mem_ctl(cop_mem_ctl),
                 .dout(cop_data),

                 .lcd_data(lcd_data),
                 .lcd_rs(lcd_rs),
                 .lcd_rw(lcd_rw),
                 .lcd_en(lcd_en),

                 .ser_rxd(ser_rxd),
                 .ser_txd(ser_txd),

                 .seg7led1(seg7led1),
                 .seg7led2(seg7led2),

                 .led1(led1),
                 .led2(led2),

                 .key1(key1),
                 .key2(key2)   ,

                 .irq_addr_o(irq_addr),  //not registed
                 .irq_req_o(w_irq)
             );

endmodule

