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

module rf_stage (
        clk,irq_i,rst_i,wb_we_i,cmp_ctl_i,
        ext_ctl_i,fw_alu_i,fw_cmp_rs,fw_cmp_rt,
        fw_mem_i,id_cmd,ins_i,irq_addr_i,pc_gen_ctl,
        pc_i,rd_sel_i,wb_addr_i,wb_din_i,zz_spc_i,iack_o,
        id2ra_ctl_clr_o,id2ra_ctl_cls_o,ra2ex_ctl_clr_o,ext_o,
        pc_next,rd_index_o,rs_n_o,rs_o,rt_n_o,rt_o
    ) ;

    input clk;
    wire clk;
    input irq_i;
    wire irq_i;
    input rst_i;
    wire rst_i;
    input wb_we_i;
    wire wb_we_i;
    input [2:0] cmp_ctl_i;
    wire [2:0] cmp_ctl_i;
    input [2:0] ext_ctl_i;
    wire [2:0] ext_ctl_i;
    input [31:0] fw_alu_i;
    wire [31:0] fw_alu_i;
    input [2:0] fw_cmp_rs;
    wire [2:0] fw_cmp_rs;
    input [2:0] fw_cmp_rt;
    wire [2:0] fw_cmp_rt;
    input [31:0] fw_mem_i;
    wire [31:0] fw_mem_i;
    input [2:0] id_cmd;
    wire [2:0] id_cmd;
    input [31:0] ins_i;
    wire [31:0] ins_i;
    input [31:0] irq_addr_i;
    wire [31:0] irq_addr_i;
    input [2:0] pc_gen_ctl;
    wire [2:0] pc_gen_ctl;
    input [31:0] pc_i;
    wire [31:0] pc_i;
    input [1:0] rd_sel_i;
    wire [1:0] rd_sel_i;
    input [4:0] wb_addr_i;
    wire [4:0] wb_addr_i;
    input [31:0] wb_din_i;
    wire [31:0] wb_din_i;
    input [31:0] zz_spc_i;
    wire [31:0] zz_spc_i;
    output iack_o;
    wire iack_o;
    output id2ra_ctl_clr_o;
    wire id2ra_ctl_clr_o;
    output id2ra_ctl_cls_o;
    wire id2ra_ctl_cls_o;
    output ra2ex_ctl_clr_o;
    wire ra2ex_ctl_clr_o;
    output [31:0] ext_o;
    wire [31:0] ext_o;
    output [31:0] pc_next;
    wire [31:0] pc_next;
    output [4:0] rd_index_o;
    wire [4:0] rd_index_o;
    output [4:0] rs_n_o;
    wire [4:0] rs_n_o;
    output [31:0] rs_o;
    wire [31:0] rs_o;
    output [4:0] rt_n_o;
    wire [4:0] rt_n_o;
    output [31:0] rt_o;
    wire [31:0] rt_o;


    wire NET6609;
    wire NET6658;
    wire NET7774;
    wire NET904;
    wire [3:0] BUS1013;
    wire [31:0] BUS2085;
    wire [4:0] BUS3236;
    wire [4:0] BUS3237;
    wire [4:0] BUS5421;
    wire [31:0] BUS6061;
    wire [31:0] BUS6095;


    cal_cpi CAL_CPI
            (
                .clk(clk),
                .clk_no(CLK_NO),
                .ins_no(INS_NO),
                .is_nop(NET7774),
                .rst(rst_i)
            );



    ctl_FSM MAIN_FSM
            (
                .clk(clk),
                .iack(iack_o),
                .id2ra_ctl_clr(id2ra_ctl_clr_o),
                .id2ra_ctl_cls(id2ra_ctl_cls_o),
                .id2ra_ins_clr(NET6609),
                .id2ra_ins_cls(NET6658),
                .id_cmd(id_cmd),
                .irq(irq_i),
                .pc_prectl(BUS1013),
                .ra2exec_ctl_clr(ra2ex_ctl_clr_o),
                .rst(rst_i),
                .zz_is_nop(NET7774)
            );



    pc_gen i_pc_gen
           (
               .check(NET904),
               .ctl(pc_gen_ctl),
               .imm(ext_o),
               .irq(irq_addr_i),
               .pc(pc_i),
               .pc_next(pc_next),
               .pc_prectl(BUS1013),
               .s(rs_o),
               .zz_spc(zz_spc_i)
           );



    compare i_cmp
            (
                .ctl(cmp_ctl_i),
                .res(NET904),
                .s(rs_o),
                .t(rt_o)
            );



    ext i_ext
        (
            .ctl(ext_ctl_i),
            .ins_i(BUS2085),
            .res(ext_o)
        );



    r32_reg_clr_cls ins_reg
                    (
                        .clk(clk),
                        .clr(NET6609),
                        .cls(NET6658),
                        .r32_i(ins_i),
                        .r32_o(BUS2085)
                    );



    jack jack1
         (
             .ins_i(BUS2085),
             .rd_o(BUS5421),
             .rs_o(rs_n_o),
             .rt_o(rt_n_o)
         );



    jack jack2
         (
             .ins_i(ins_i),
             .rs_o(BUS3237),
             .rt_o(BUS3236)
         );

    rd_sel rd_sel
           (
               .ctl(rd_sel_i),
               .rd_i(BUS5421),
               .rd_o(rd_index_o),
               .rt_i(rt_n_o)
           );

    reg_array reg_bank
              (
                  .clock(clk),
                  .data(wb_din_i),
                  .qa(BUS6061),
                  .qb(BUS6095),
                  .rd_clk_cls(NET6658),
                  .rdaddress_a(BUS3237),
                  .rdaddress_b(BUS3236),
                  .wraddress(wb_addr_i),
                  .wren(wb_we_i)
              );

    fwd_mux rf_fwd_rt
            (
                .din(BUS6095),
                .dout(rt_o),
                .fw_alu(fw_alu_i),
                .fw_ctl(fw_cmp_rt),
                .fw_dmem(fw_mem_i)
            );

    fwd_mux rs_fwd_rs
            (
                .din(BUS6061),
                .dout(rs_o),
                .fw_alu(fw_alu_i),
                .fw_ctl(fw_cmp_rs),
                .fw_dmem(fw_mem_i)
            );

endmodule
