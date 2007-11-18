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

module rxd_d(input clr,input clk,input d,output reg q );

    always @(posedge clk)

        if      (clr) q<=0;
        else          q<=d|q;

endmodule

module uart0 (
        clk,rst,rxd_ft,ser_rxd,txd_ld,
        din,rxd_rdy,ser_txd,txd_busy,dout) ;
    input clk;
    wire clk;
    input rst;
    wire rst;
    input rxd_ft;
    wire rxd_ft;
    input ser_rxd;
    wire ser_rxd;
    input txd_ld;
    wire txd_ld;
    input [7:0] din;
    wire [7:0] din;
    output rxd_rdy;
    wire rxd_rdy;
    output ser_txd;
    wire ser_txd;
    output txd_busy;
    wire txd_busy;
    output [7:0] dout;
    wire [7:0] dout;

    wire clk_uart=clk;
    wire w_rxd_rdy;

    uart_read uart_rd_tak(
                  .sync_reset(rst),
                  .clk(clk),
                  .rxd(ser_rxd),
                  .buffer_reg(dout),
                  .int_req(w_rxd_rdy)
              );

    rxd_d rxd_rdy_hold_lw
          (
              .clk(clk_uart),
              .clr(rxd_ft),
              .d(w_rxd_rdy),
              .q(rxd_rdy)
          );

    uart_write uart_txd
               (
                   .sync_reset(rst),
                   .clk(clk),
                   .txd(ser_txd),
                   .data_in(din) ,
                   .write_request(txd_ld),
                   //.write_done(),
                   .write_busy(txd_busy)
               );

endmodule

//These modules below are modified slight by Liwei based on YACC,an CPU core in opencores.
//Thank you TAK

module	uart_write( sync_reset, clk, txd, data_in , write_request,write_done,write_busy);
    input sync_reset,clk;
    input [7:0] data_in;
    input write_request;
    output txd,write_done;
    output write_busy;



    wire		queue_full;
    wire	queing, read_request;
    wire [7:0] queue_data;
    reg read_request_ff;


    //________|--|___write_request (upper  module :     its period should be 1clock time.)
    //__________________________|-|______write_done    (Responds by this module posedge interrupt)
    //With 512Bytes FIFO.
    //No error handling is supported.

    reg		[15:0] clk_ctr;//liwei
    reg		[2:0] bit_ctr;
    reg		[2:0] ua_state;
    reg		[7:0] tx_sr;
    reg		txd;

    wire	 clk_ctr_equ15, clk_ctr_equ31,  bit_ctr_equ7,
          clk_ctr_enable_state, bit_ctr_enable_state  ;
    wire    tx_state;
    wire empty;
    assign write_busy=queue_full;//Apr.2.2005

    always @ (posedge clk) begin
        if (~sync_reset)	read_request_ff<=1'b0;
        else			read_request_ff<=read_request;
    end

    assign queing=	!empty;
    assign read_request	 = queing && ua_state==3'b000;//Jul.14.2004

    assign write_done=ua_state==3'b101;

`ifdef ALTERA
    fifo512_cyclone  alt_fifo(
                         .data(data_in),
                         .wrreq(write_request),
                         .rdreq(read_request),
                         .clock(clk),
                         .q(queue_data),
                         .full(queue_full),
                         .empty(empty));
`else//debug model in simulations

    sim_fifo512_cyclone  sim_fifo(
                             .data(data_in),
                             .wrreq(write_request),
                             .rdreq(read_request),
                             .clock(clk),
                             .q(queue_data),
                             .full(queue_full),
                             .empty(empty),
                             .rst(sync_reset));
`endif



    // 7bit counter
    // I set the regerster lenth as 16 .Sufficent but not waste.Liwei
    always @(posedge clk ) begin
        if (~sync_reset)
            clk_ctr <= 0;
        else if (clk_ctr_enable_state && clk_ctr_equ31)  clk_ctr<=0;
        else if (clk_ctr_enable_state)	                 clk_ctr <= clk_ctr + 1;
        else	clk_ctr <= 0;
    end


    assign	clk_ctr_equ15 = clk_ctr==`COUNTER_VALUE1;
    assign	clk_ctr_equ31 = clk_ctr==`COUNTER_VALUE2;

    // 3bit counter
    always @(posedge clk) begin
        if (~sync_reset)
            bit_ctr <= 0;
        else if (bit_ctr_enable_state) begin
            if (clk_ctr_equ15)
                bit_ctr <= bit_ctr + 1;
        end
        else
            bit_ctr <= 0;
    end

    assign	bit_ctr_equ7 = (bit_ctr==7);

    assign	clk_ctr_enable_state = bit_ctr_enable_state ||ua_state==3'b110 ||  ua_state==3'b001 ||  ua_state==3'b100||ua_state==3'b101;
    assign	bit_ctr_enable_state =  ua_state==3'b010 || ua_state==3'b011;


    always @(posedge clk ) begin
        if (~sync_reset) ua_state <= 3'b000;
        else begin
            case (ua_state)
                3'b000:	if (queing)  ua_state <= 3'b001;	//wait write_request
                3'b001:	if ( clk_ctr_equ15) ua_state <= 3'b010;	// write start bit
                3'b010:	if (bit_ctr_equ7 & clk_ctr_equ15) ua_state <= 3'b011;		// start bit, bit0-7 data  send
                3'b011:	if (clk_ctr_equ15) ua_state <= 3'b100;					// bit7 data send
                3'b100:	if (clk_ctr_equ15) ua_state <= 3'b101;	// stop bit				// stop bit send
                3'b101:	if (clk_ctr_equ15) ua_state <= 3'b110;	//LIWEI				// stop bit send
                3'b110:	if (clk_ctr_equ15) ua_state <= 3'b111;		  //LIWEI
                3'b111:	 ua_state <= 3'h0;	// TAK					// byte read cycle end
                default: ua_state <= 3'h0;
            endcase
        end
    end




    // tx shift reg.
    always @(posedge clk ) begin
        if (~sync_reset) tx_sr<=0;
        else if (read_request_ff) tx_sr <= queue_data[7:0]; //data_in[7:0]; // load
        else if (tx_state ) tx_sr <= {1'b0, tx_sr[7:1]};
    end

    assign  tx_state=(  ua_state==3'h2 || ua_state==3'h3)		&&	clk_ctr_equ15;


    // tx
    always @(posedge clk ) begin
        if (~sync_reset) txd <=1'b1;
        else if (~sync_reset)			  txd<=1'b1;
        else if (ua_state==3'h0)		  txd<=1'b1;
        else if (ua_state==3'h1 && clk_ctr_equ15) txd<=1'b0;	// start bit
        else if (ua_state==3'h2 && clk_ctr_equ15) txd<=tx_sr[0];
        else if (ua_state==3'h3 && clk_ctr_equ15) txd<=1'b1;     // stop bit
    end
endmodule


module	uart_read( sync_reset, clk, rxd,buffer_reg, int_req);
    input sync_reset;
    input	clk, rxd;
    output	[7:0] buffer_reg;
    output	int_req;


    //________|-|______int_req (This module,, posedge interrupt)
    //
    //Spec. Upper module must service within 115.2Kbpsx8bit time. Maybe enough time...
    //
    //No error handling (overrun ) is supported.

    reg	        rxq1;
    reg		[15:0] clk_ctr;
    reg		[2:0] bit_ctr;
    reg		[2:0] ua_state;
    reg		[7:0] rx_sr;             //.,tx_sr;
    reg		int_req;
    reg		[7:0] buffer_reg;

    wire	 clk_ctr_equ15, clk_ctr_equ31, bit_ctr_equ7,
          clk_ctr_enable_state, bit_ctr_enable_state  ;
    wire 	clk_ctr_equ0;

    //sync_reset

    //synchronization
    always @(posedge clk ) begin
        rxq1 <=rxd ;
    end

    // 7bit counter
    always @(posedge clk ) begin
        if (~sync_reset)
            clk_ctr <= 0;
        else if (clk_ctr_enable_state && clk_ctr_equ31)  clk_ctr<=0;
        else if (clk_ctr_enable_state)	                 clk_ctr <= clk_ctr + 1;
        else	clk_ctr <= 0;
    end
    assign	clk_ctr_equ15 =  (clk_ctr==`COUNTER_VALUE1)  ;//
    assign	clk_ctr_equ31 =  (clk_ctr==`COUNTER_VALUE2) ;//
    assign  clk_ctr_equ0=    (clk_ctr==`COUNTER_VALUE3);	//


    // 3bit counter
    always @(posedge clk) begin
        if (~sync_reset)
            bit_ctr <= 0;
        else if (bit_ctr_enable_state) begin
            if (clk_ctr_equ15)
                bit_ctr <= bit_ctr + 1;
        end
        else
            bit_ctr <= 0;
    end

    assign	bit_ctr_equ7 = (bit_ctr==7);


    assign	clk_ctr_enable_state =  ua_state !=3'b000  && ua_state<=3'b011;
    assign	bit_ctr_enable_state = ua_state==3'h2;

    always @(posedge clk ) begin
        if (~sync_reset) ua_state <= 3'h0;
        else begin
            case (ua_state)
                3'h0:	if (rxq1==0) ua_state <= 3'h1;  // if rxd==0 then goto next state and enable clock						// start bit search
                3'h1:	if (clk_ctr_equ15) ua_state <= 3'h2;					// start bit receive
                3'h2:	if (bit_ctr_equ7 & clk_ctr_equ15) ua_state <= 3'h3;
                3'h3:	if (clk_ctr_equ15)     ua_state <=3'h4; 								// stop bit receive
                3'h4:   ua_state <= 3'b000;
                default: ua_state <= 3'b000;
            endcase
        end
    end


    //reg_we
    always @(posedge clk ) begin
        if (~sync_reset) 			   buffer_reg<=8'h00;
        else if (ua_state==3'h3 && clk_ctr_equ0)  buffer_reg<=rx_sr;
    end

    //int_req
    always @(posedge clk ) begin
        if (~sync_reset) 			    int_req<=1'b0;
        else if (ua_state==3'h4	)   int_req<=1'b1;
        else 					    int_req<=1'b0;
    end


    // rx shift reg.
    always @(posedge clk ) begin
        if (~sync_reset) rx_sr <= 0;
        else if (clk_ctr_equ15) rx_sr <= {rxq1, rx_sr[7:1]};
    end

endmodule
