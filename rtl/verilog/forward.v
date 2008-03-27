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

/*
module fw_latch5(input clk,input[4:0]d,output reg  [4:0]q,input cls);
    always @ (posedge clk)if (cls==0) q<=d;
endmodule

module fw_latch1(input clk,input d,output reg q,input cls);
    always @ (posedge clk)if (cls==0) q<=d;
endmodule
*/

module forward_node (
        input [4:0]rn,
        input [4:0]alu_wr_rn,
        input alu_we,
        input [4:0]mem_wr_rn,
        input mem_we,
        output reg [2:0]mux_fw
    )  ;
    /*
       assign mux_fw = ((alu_we)&&(alu_wr_rn==rn)&&(alu_wr_rn!=0))?`FW_ALU:
              ((mem_we)&&(mem_wr_rn==rn)&&(mem_wr_rn!=0))?`FW_MEM:
              `FW_NOP;
             
          		  */
    always @(*)
        if ((alu_we)&&(alu_wr_rn==rn)&&(alu_wr_rn!=0))
            mux_fw= `__TP  `FW_ALU;
        else if ((mem_we)&&(mem_wr_rn==rn)&&(mem_wr_rn!=0))
            mux_fw=`__TP `FW_MEM;
        else   mux_fw=  `__TP     `FW_NOP;

endmodule

module fwd_mux(
        input [31:0]din,
        output reg [31:0]dout,
        input [31:0]fw_alu	,
        input [2:0]fw_ctl,
        input [31:0]fw_dmem
    );
    always@(*)
    case (fw_ctl)
        `FW_ALU :dout=fw_alu;
        `FW_MEM :dout=fw_dmem;
        default
        dout=din;
    endcase
endmodule

module forward  (
        input pause,
        input alu_we,
        input clk,
        input mem_We,
        input [4:0] fw_alu_rn,
        input [4:0] fw_mem_rn,
        input [4:0] rns_i,
        input [4:0] rnt_i,
        output [2:0] alu_rs_fw,
        output [2:0] alu_rt_fw,
        output [2:0] cmp_rs_fw,
        output [2:0] cmp_rt_fw,
        output [2:0] dmem_fw
    ) ;

    wire [2:0] BUS1345;
    wire [4:0] BUS82;
    wire [4:0] BUS937;

    forward_node fw_alu_rs
                 (
                     .alu_we(alu_we),
                     .alu_wr_rn(fw_alu_rn),
                     .mem_we(mem_We),
                     .mem_wr_rn(fw_mem_rn),
                     .mux_fw(alu_rs_fw),
                     .rn(BUS82)
                 );



    forward_node fw_alu_rt
                 (
                     .alu_we(alu_we),
                     .alu_wr_rn(fw_alu_rn),
                     .mem_we(mem_We),
                     .mem_wr_rn(fw_mem_rn),
                     .mux_fw(BUS1345),
                     .rn(BUS937)
                 );



    forward_node fw_cmp_rs
                 (
                     .alu_we(alu_we),
                     .alu_wr_rn(fw_alu_rn),
                     .mem_we(mem_We),
                     .mem_wr_rn(fw_mem_rn),
                     .mux_fw(cmp_rs_fw),
                     .rn(rns_i)
                 );



    forward_node fw_cmp_rt
                 (
                     .alu_we(alu_we),
                     .alu_wr_rn(fw_alu_rn),
                     .mem_we(mem_We),
                     .mem_wr_rn(fw_mem_rn),
                     .mux_fw(cmp_rt_fw),
                     .rn(rnt_i)
                 );



    r5_reg_clr_cls fw_reg_rns
                   (
                       .clk(clk),
                       .cls(pause),
                       .clr(0),
                       .r5_i(rns_i),
                       .r5_o(BUS82)
                   );



    r5_reg_clr_cls fw_reg_rnt
                   (
                       .cls(pause),
                       .clr(0),
                       .clk(clk),
                       .r5_i(rnt_i),
                       .r5_o(BUS937)
                   );


    assign alu_rt_fw[2:0] = BUS1345[2:0];
    assign dmem_fw[2:0] = BUS1345[2:0];

endmodule


