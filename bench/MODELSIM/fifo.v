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

module sim_fifo512_cyclone ( //just uesd for simulation in EDA tools
        data,
        wrreq,
        rdreq,
        clock,
        q,
        full,
        empty,
        rst);

    input	[7:0]  data;
    input	  rst;
    input     wrreq;
    input	  rdreq;
    input	  clock;
    output	[7:0]  q;
    output	  full;
    output	  empty;

    fifo fifo_ff
         (
             .clk_i(clock),
             .rst_i(rst),
             .clear_i(1'b0),
             .data_i(data),
             .wen_i(wrreq),
             .ren_i(rdreq),
             .data_o(q),
             .almost_full_o(),
             .full_o(full),
             .almost_empty_o(),
             .empty_o(empty),
             .cnt_o()
         );

endmodule


//created by zhangfeifei
//modifined only for simulating by liwei
module fifo
    (
        clk_i,
        rst_i,
        clear_i,
        data_i,
        wen_i,
        ren_i,
        data_o,
        almost_full_o,
        full_o,
        almost_empty_o,
        empty_o,
        cnt_o
    );

    parameter DATA_WIDTH    = 8;
    parameter DEPTH         = 512;
    parameter CNT_WIDTH     = 12;

    input  clk_i;
    input  rst_i;
    input  clear_i;

    input  wen_i;
    input  [DATA_WIDTH-1:0] data_i;

    input  ren_i;
    output reg[DATA_WIDTH-1:0] data_o;
    output almost_full_o;
    output full_o;
    output almost_empty_o;
    output empty_o;
    output [CNT_WIDTH-1:0] cnt_o;

    reg    [DATA_WIDTH-1:0] mem[0:DEPTH-1];

    reg    [CNT_WIDTH-1:0] cnt;
    reg    [CNT_WIDTH-2:0] read_pointer;
    reg    [CNT_WIDTH-2:0] write_pointer;
    assign cnt_o = cnt;

    integer i;
    initial
    begin
        for(i=0;i<DEPTH;i=i+1)
            mem[i] =0;
    end

    always @(posedge clk_i)
    begin
        if(~rst_i)
            cnt <=  0;
        else if(clear_i)
            cnt <=  {{(CNT_WIDTH-1){1'b0}},ren_i^wen_i};
        else if(ren_i ^ wen_i)
        begin
            if(ren_i & ~empty_o)
                cnt <= cnt - 1'b1;
            else if( wen_i & ~full_o)
                cnt <= cnt + 1'b1;
        end
    end

    always @(posedge clk_i)
    begin
        if(~rst_i)
            read_pointer <= 0;
        else if(clear_i)
            read_pointer <= { {(CNT_WIDTH-2){1'b0}}, ren_i};
        else if(ren_i & ~empty_o)
            read_pointer <= read_pointer + 1'b1;
    end

    always @ (posedge clk_i )
    begin
        if(~rst_i)
            write_pointer <= 0;
        else if(clear_i)
            write_pointer <= { {(CNT_WIDTH-2){1'b0}}, wen_i};
        else if(wen_i & ~full_o)
            write_pointer <= write_pointer + 1'b1;
    end

    assign empty_o = ~(|cnt);
    assign almost_empty_o = cnt == 1;
    assign full_o  = cnt == DEPTH;
    assign almost_full_o  = &cnt[CNT_WIDTH-2:0];

    always @ (posedge clk_i)
    begin
        if(wen_i & clear_i)
            mem[0] <= data_i;
        else if(wen_i & ~full_o)
            mem[write_pointer] <= data_i;
    end

    always @ (posedge clk_i)
        data_o <= clear_i ? mem[0] : mem[read_pointer];

endmodule


