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

module mips_dvc (

        input [31:0]din,
        input clk,
        input rst,
        input [31:0]addr ,
        input [3:0]mem_ctl,

        output reg [31:0]dout ,

        output reg[7:0] lcd_data,
        output lcd_rs,
        output lcd_rw,
        output lcd_en,

        input  ser_rxd,
        output ser_txd,

        output [6:0]seg7led1,
        output [6:0]seg7led2	,
        output led1,
        output led2		  ,
        input key1,
        input key2 ,

        output reg[31:0]irq_addr_o,  //not registed
        output irq_req_o
    );

    reg r_key1;
    reg r_key2;

    reg rr_key1;
    reg rr_key2;

    always @(posedge clk)
    begin
        r_key1<=key1;
        r_key2<=key2;
    end

    always @(posedge clk)
    begin
        rr_key1<=r_key1;
        rr_key2<=r_key2;
    end

initial
begin
        lcd_data<=0; 
end
    wire sv_byte = (mem_ctl==`DMEM_SB);
    wire ld_byte = mem_ctl==`DMEM_LBS||mem_ctl==`DMEM_LBU;

    wire sv_wd = (mem_ctl==`DMEM_SW);
    wire ld_wd = (mem_ctl==`DMEM_LW);


    wire wr_uartdata   =	  addr==`UART_DATA_ADDR 	&& 		sv_byte;
    wire wr_lcddata    =	  addr==`LCD_DATA_ADDR 		&& 		sv_byte;
    wire rd_uartdata   =	  addr==`UART_DATA_ADDR 	&& 		ld_byte;
    wire rd_status 	   =	  addr==`STATUS_ADDR 		&& 		ld_wd;
    wire wr_cmd        =	  addr==`CMD_ADDR 			&& 		sv_wd;
    wire rd_cmd        =	  addr==`CMD_ADDR		 	&& 		ld_wd;
    wire wr_seg7       =	  addr==`SEG7LED_ADDR 		&& 		sv_byte  ;

    wire set_tmr_addr  = addr==`TMR_IRQ_ADDR    &&     sv_wd;
    wire set_key1_addr = addr==`KEY1_IRQ_ADDR   &&     sv_wd;
    wire set_key2_addr = addr==`KEY2_IRQ_ADDR   &&     sv_wd;
    wire wr_tmr_data   = addr==`TMR_DATA_ADDR   &&     sv_wd;
    wire rd_tmr_data   = addr==`TMR_DATA_ADDR   &&     ld_wd;

    wire w_tmr_req;
    wire [31:0]w_tmr_data;

    reg [31:0] tmr_addr;
    reg [31:0] key1_addr;
    reg [31:0] key2_addr;

    reg [31:0] cmd ;

    // wire w_txd_ld		=		cmd[0]	;
    wire w_rxd_ft		=		cmd[1]	;

    assign lcd_rs 		= 		cmd[2]	;
    assign lcd_rw 		= 		cmd[3]	;
    assign lcd_en 		=		cmd[4]	;

    assign led1 		= 		cmd[5]	;
    assign led2 		= 		cmd[6]	;

    wire  tmr_clr		=       cmd[7]	;
    wire  tmr_en		=		cmd[8]  ;

    reg [7:0] seg7data;
    wire [7:0] uart_dout;
    wire w_txd_busy;
    wire w_rx_rdy;

    always@(posedge clk )
        if (~rst)
        begin
            dout<=0;
        end
        else
        begin
            if (rd_status) dout<={28'b0,/*added here*/w_rx_rdy,w_txd_busy,rr_key1,rr_key2};else
            if (rd_cmd)dout<=cmd;else
            if (rd_uartdata)dout<={24'b0,uart_dout};else
            if ( rd_tmr_data )dout<=w_tmr_data;	else
            dout<=0;
        end

    always @(posedge clk)
        if (~rst)
        begin
            cmd<=0;
            seg7data<=0;   
            tmr_addr<=32'bX;
            key1_addr<=32'BX;
            key2_addr<=32'BX;
        end
        else
        begin

            if (wr_cmd)   cmd<=din;
            if (wr_seg7) seg7data<=din[7:0];
            if (wr_lcddata)	   lcd_data<=din[7:0];

            if (set_tmr_addr)tmr_addr<=din;
            if (set_key1_addr)key1_addr<=din;
            if (set_key2_addr)key2_addr<=din;

        end

    uart0 iuart0(

              .clk(clk),
              .rst(rst),
              .ser_rxd(ser_rxd),
              .ser_txd(ser_txd),

              .rxd_ft(w_rxd_ft),
              .txd_ld(wr_uartdata),

              .din(din[7:0]),

              .rxd_rdy(w_rx_rdy),
              .txd_busy(w_txd_busy),

              .dout(uart_dout)
          ) ;

    seg7led_cv iseg7_cv (
                   .data(seg7data),
                   .seg7led1(seg7led1),
                   .seg7led2(seg7led2)
               );

    tmr0 mips_tmr0(
             .clk(clk),
             .clr(tmr_clr),
             .din(din) ,
             .ld(wr_tmr_data),
             .tmr_en(tmr_en),
             .tmr_req(w_tmr_req),
             .cntr_o(w_tmr_data)
         );


    //interrupt control
    wire tmr_irq_bit  =       cmd[31] ;
    wire key1_irq_bit =       cmd[30] ;
    wire key2_irq_bit =       cmd[29] ;

    wire tmr_req_do =	w_tmr_req & tmr_irq_bit;
    wire key1_req_do = rr_key1 & key1_irq_bit;
    wire key2_req_do = rr_key2 & key2_irq_bit;

    assign irq_req_o = 0;//tmr_req_do;

    always @(*)
        if (tmr_req_do)         irq_addr_o = tmr_addr;else
    if (key1_req_do)     irq_addr_o = key1_addr;else
    if (key2_req_do)	  irq_addr_o = key2_addr ;
    else                      irq_addr_o = 0;

endmodule
