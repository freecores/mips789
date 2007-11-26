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

module tmr0 (
        input clk,
        input clr,
        input[31:0] din ,
        input ld,
        input tmr_en,
        output tmr_req,
        output [31:0] cntr_o
    );

    reg [31:0]s_cntr;
    reg [31:0]cntr;

    assign cntr_o=cntr;

    always @(posedge clk)
        if (ld)
            s_cntr<= din;


    always @(posedge clk)
        if (ld)
            cntr<=din;
        else if (cntr==0)
            cntr<=s_cntr;
        else if (tmr_en)
            cntr<=cntr-1;

    wire w_irq = cntr==0;

    tmr_d itmr_d(
              .clr(clr),
              .clk(clk),
              .d(w_irq),
              .q(tmr_req)
          );
endmodule


module tmr_d(input clr,input clk,input d,output reg q );

    always @(posedge clk)

        if      (clr) q<=0;
        else          q<=d|q;

endmodule

module seg7led_cv(
        input [7:0] data,
        output reg [6:0] seg7led2,
        output reg [6:0] seg7led1
    );

    always @(*)
    begin
        seg7led2= seg(data[3:0]) ;
        seg7led1= seg(data[7:4]) ;
    end

    function [7:0] seg;
        input [3:0] addr;
        begin
            case(addr)
                0: seg = 7'b0111111;
                1: seg = 7'b0000110;
                2: seg = 7'b1011011;
                3: seg = 7'b1001111;
                4: seg = 7'b1100110;
                5: seg = 7'b1101101;
                6: seg = 7'b1111100;
                7: seg = 7'b0000111;
                8: seg = 7'b1111111;
                9: seg = 7'b1100111;
                10: seg = 7'b1110111;
                11: seg = 7'b1111100;
                12: seg = 7'b1011000;
                13: seg = 7'b1011110;
                14: seg = 7'b1111001;
                15: seg = 7'b1110001;
                default  seg = 7'bx;
            endcase
        end
    endfunction

endmodule
