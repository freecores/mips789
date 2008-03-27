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

module mips_top (
        input pause,
        input clk,
        input rst,
        input ser_rxd,
        output ser_txd,
        output [6:0]seg7led1,
        output [6:0]seg7led2,
        output [7:0] lcd_data,
        output lcd_rs,
        output lcd_rw,
        output lcd_en,
        output led1,
        output led2,
        input  key1,
        input  key2
    );

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


    wire [31:0] pc_s ;
    wire [31:0] ins2core_s;

`ifdef ALTERA
    pll50 Ipll(
              .inclk0(clk),
              .c0(CLK)
          );//clock for FPGA
    mem_array ram_8k//FPGA RAM
`else 	 
    assign CLK = clk;//clock for simultation
    sim_mem_array sim_array//memory for simultion
`endif	   		   

              (
                  .clk(CLK),
                  .pc_i(pc_s),
                  .ins_o(ins2core_s),
                  .wren(wr_en),
                  .din(data2mem),
                  .data_addr_i(mem_Addr),
                  .dout(data2core)
              );


    `ifdef  WB_INS_LATCH_ADDR

         f_d_save  ins_addr_keep(
             .clk(CLK),
             .pause(pause) ,
             .din(pc),
             .dout(pc_s)
         );

    //  assign pc_s=pc;
    assign ins2core =ins2core_s;

			`else 

    b_d_save  ins_data_keep(
                  .clk(CLK),
                  .pause(pause) ,
                  .din(ins2core_s),
                  .dout(ins2core)
              );

    assign pc_s=pc;
    //assign ins2core =ins2core_s;

				 `endif 

    mips_sys isys
             (
                 .pause(pause),
                 .zz_addr_o(mem_Addr),
                 .zz_din(data2core),
                 .zz_dout(data2mem),
                 .zz_ins_i(ins2core),
                 .zz_pc_o(pc),
                 .zz_wr_en_o(wr_en),

                 .clk(CLK),
                 .rst(sys_rst),

                 .ser_rxd(ser_rxd),
                 .ser_txd(ser_txd),

                 .seg7led1(seg7led1),
                 .seg7led2(seg7led2),

                 .lcd_data(lcd_data),
                 .lcd_rs(lcd_rs),
                 .lcd_rw(lcd_rw),
                 .lcd_en(lcd_en),

                 .led1(led1),
                 .led2(led2),

                 .key1(key1),
                 .key2(key2)
             );
endmodule
