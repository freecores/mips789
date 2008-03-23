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


module mem_module  (
        input pause,
        input clk,
        input [31:0] din,
        input [31:0] dmem_addr_i,
        input [3:0] dmem_ctl,
        input [31:0] zZ_din,
        output [31:0] Zz_addr,
        output [31:0] Zz_dout,
        output [3:0] Zz_wr_en,
        output [31:0] dout
    ) ;


    wire [3:0] BUS512;
    wire [1:0] BUS629;
    wire [31:0] dmem_addr_i;
    wire [31:0] dmem_addr_s;// = dmem_addr_i;

    wire [3:0] dmem_ctl_s;


    wire [31:0]rt_r;
    r32_reg_clr_cls rt_latch(
                        .r32_i(din),
                        .r32_o(rt_r),
                        .clk(clk),
                        .cls(pause),
                        .clr(0)
                    );

    infile_dmem_ctl_reg dmem_ctl_post
                        (	 .pause(pause),
                           .byte_addr_o(BUS629),
                           .clk(clk),
                           .ctl_i(dmem_ctl_s),
                           .ctl_o(BUS512),
                           .dmem_addr_i(dmem_addr_s)
                        );

    mem_addr_ctl i_mem_addr_ctl
                 (
                     .addr_i(dmem_addr_s),
                     .ctl(dmem_ctl_s),
                     .wr_en(Zz_wr_en)
                 );



    wire [31:0] din_s ;
    mem_din_ctl i_mem_din_ctl
                (
                    .ctl(dmem_ctl_s),
                    .din(din_s),
                    .dout(Zz_dout)
                );



    /*
    comment this coz the save module will connect to data output.
    mem_save  u3u(
    .clk(clk),
    .pause(pause) ,
    .din(din),
    .dout(din_s) 
    ); 	 						

    */

    assign din_s=din;

    /*
    comment this coz the save module will connect to data output.
    mem_save  u4u(
    .clk(clk),
    .pause(pause) ,
    .din(dmem_ctl),
    .dout(dmem_ctl_s) 
    );
    */



    assign dmem_ctl_s = dmem_ctl;

    /*
    comment this coz the save module will connect to data output.

    mem_save  uu(
    .clk(clk),
    .pause(pause) ,
    .din(dmem_addr_i),
    .dout(dmem_addr_s) 
    ); 	 	
    */
    assign dmem_addr_s=dmem_addr_i;


    wire [31:0]dout_s;


    mem_dout_ctl i_mem_dout_ctl

                 (
                     .rt_r(rt_r),
                     .byte_addr(BUS629),
                     .ctl(BUS512),
                     .din(zZ_din),
                     .dout(dout_s)
                 );

    //
    b_d_save  uu3(
                  .clk(clk),
                  .pause(pause) ,
                  .din(dout_s),
                  .dout(dout)
              );

    assign Zz_addr= dmem_addr_s;

endmodule





module infile_dmem_ctl_reg(
        input pause,
        input clk,
        input [3:0]ctl_i,
        input [31:0]dmem_addr_i,
        output reg [1:0]byte_addr_o,
        output reg [3:0]ctl_o
    );

    wire   [1:0]byte_addr_i;
    assign byte_addr_i = dmem_addr_i[1:0] ;

    always @(posedge clk)
        //	if(0==pause)
        //the registers in SYN_RAM does not pause so ,
        //the latch for delay need not to pause either
    begin
        ctl_o<=(dmem_addr_i[31]==0)?ctl_i:0;
        byte_addr_o<=byte_addr_i;
    end

endmodule

module mem_addr_ctl(
        input [3:0]ctl,
        input [31:0]addr_i,
        output reg[3:0]wr_en
    );
    always@(*)
    case (ctl)
        `DMEM_SB:
        begin
            case(addr_i[1:0])
                0:wr_en = 4'b1000;
                1:wr_en = 4'b0100;
                2:wr_en = 4'b0010;
                3:wr_en = 4'b0001;
            endcase
        end
        `DMEM_SH  :
        begin
            case(addr_i[1:0])
                'd0:wr_en=4'b1100;
                'd2:wr_en=4'b0011;
                default :wr_en = 4'b0000;
            endcase
        end

        `DMEM_SWL :
        begin
            case(addr_i[1:0])
                0:wr_en = 4'b0001;
                1:wr_en = 4'b0011;
                2:wr_en = 4'b0111;
                3:wr_en = 4'b1111;
            endcase
        end

        `DMEM_SWR :
        begin
            case(addr_i[1:0])
                0:wr_en = 4'b1000;
                1:wr_en = 4'b1100;
                2:wr_en = 4'b1110;
                3:wr_en = 4'b1111;
            endcase
        end
        `DMEM_SW :
        begin
            wr_en=4'b1111;
        end
        default wr_en=4'b0000;
    endcase

endmodule


module mem_dout_ctl(
        input [31:0] rt_r,
        input [1:0]byte_addr,
        input [3:0]ctl,
        input [31:0] din,
        output reg [31:0] dout
    );

    always @(*)
    case (ctl)

        `DMEM_LBS :
        case (byte_addr)

            'd0:dout={{24{din[31]}},din[31:24]};
            'd1:dout={{24{din[23]}},din[23:16]};
            'd2:dout={{24{din[15]}},din[15:8]};
            'd3:dout={{24{din[7]}},din[7:0] };
        endcase
        `DMEM_LBU :
        case (byte_addr)
            'd3:dout={24'b0,din[7:0]};
            'd2:dout={24'b0,din[15:8]};
            'd1:dout={24'b0,din[23:16]};
            'd0:dout={24'b0,din[31:24]};
        endcase
        `DMEM_LHU :
        case (byte_addr)
            'd0:dout={16'b0,din[31:24],din[23:16]};
            'd2:dout={16'b0,din[15:8],din[7 :0]};
            default:dout=32'bX;
        endcase
        `DMEM_LHS :
        case (byte_addr)
            'd0 :dout={{16{din[31]}},din[31:24],din[23:16]};
            'd2 :dout={{16{din[15]}},din[15:8],din[7 :0]};
            default:dout=32'bX;
        endcase

        `DMEM_LWL  :begin
            case (byte_addr)

                'd0:dout={din[31:24],rt_r[23:0]};
                'd1:dout={din[31:16],rt_r[15:0]};
                'd2:dout={din[31:8],rt_r[7:0]};
                default :
                    dout=din;
            endcase
        end
        `DMEM_LWR  : begin
            case (byte_addr)
                'd1:dout={rt_r[31:24],din[23:0]};
                'd2:dout={rt_r[31:16],din[15:0]};
                'd3:dout={rt_r[31:8],din[7:0]};
                default :
                    dout=din;
            endcase
        end

        `DMEM_LW  :
            dout=din;
        default :
            dout=32'b0;
    endcase

endmodule

module mem_din_ctl(
        input [3:0]ctl,
        input [31:0]din,
        output reg [31:0]dout
    );

    always @(*)

    case (ctl)
        `DMEM_SB   :
            dout={din[7:0],din[7:0],din[7:0],din[7:0]};
        `DMEM_SH   :
            dout = {din[15:0],din[15:0]};
        `DMEM_SWL ,
        `DMEM_SWR ,
        `DMEM_SW  :
            dout =din;
        default dout=32'bX;
    endcase

endmodule
