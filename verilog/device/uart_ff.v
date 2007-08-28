/////////////////////////////////////////////////////////////////////
////  Author: Zhangfeifei                                        ////
////                                                             ////
////  Advance Test Technology Laboratory,                        ////
////  Institute of Computing Technology,                         ////
////  Chinese Academy of Sciences                                ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: zhangfeifei@ict.ac.cn or whitewill@opencores.org    ////
////  Tel: +86-10-6256 5533 ext. 5673                            ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/ucore      ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2005-2006 Zhangfeifei                         ////
////                         zhangfeifei@ict.ac.cn               ////
////                                                             ////
////                                                             ////
//// This source file may be used and distributed freely without ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and any derivative work contains the  ////
//// original copyright notice and the associated disclaimer.    ////
////                                                             ////
//// Please let the author know if it is used                    ////
//// for commercial purpose.                                     //// 
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
////                                                             ////
//// Date of Creation: 2005.12.3                                 ////
////                                                             ////
//// Version: 0.0.1                                              ////
////                                                             ////
//// Description: tx module of the uart module,data format is    ////
////              8bits data,1 bits stop bit,and no parity check ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Change log:                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
module uart_rxd(
		clk_i,rst_i,//system signal
		rxd_i,//serial data in
		rdy_o,data_o //data ready and parallel data out signal
		);
  parameter // state difinition
     STA_IDDLE = 0,
     STA_CHECK_START_BIT = 1,
     STA_RECIVE = 2;
 
  input clk_i;
  input rst_i;
  input rxd_i;
 
  output rdy_o;
  output [7:0] data_o;
 
  reg rdy_o;
  reg [7:0] data_o;
   
  reg [7:0] rsr;//reciving shift register
  reg [3:0] num_of_rec;
  
  reg [1:0] reg_sta;
 
  //the counter to count the clk in
  reg [3:0] count;
  reg count_c;//the carry of count
  
  always @(posedge clk_i or negedge rst_i)
  begin
    if(~rst_i)
    begin 
      data_o     <= 8'bx;
      rdy_o      <= 1'b0;
            
      rsr        <= 8'bx;
      num_of_rec <= 3'bx;
      count      <= 4'bx;
      count_c    <= 1'bx;
 
      reg_sta    <= STA_IDDLE;
    end
    else begin
      case (reg_sta)
	STA_IDDLE:
	begin
	  num_of_rec <= 3'd0;
	  count      <= 4'd0;
	  rdy_o      <= 1'b0;
	  if(!rxd_i) 
	    reg_sta  <= STA_CHECK_START_BIT;//recive a start bit
	  else 
	    reg_sta  <= STA_IDDLE;
	end
	STA_CHECK_START_BIT:
	begin
	  count      <= count +1;
	  
	  if(count[3])
	  begin
	    //has passed 8 clk and rxd_i is still zero,then start bit has been confirmed
	    if(!rxd_i)
	      reg_sta <= STA_RECIVE;
	    else 
	      reg_sta <= STA_IDDLE;
	  end
	  else reg_sta <= STA_CHECK_START_BIT;
	end
	STA_RECIVE:
	begin
	  {count_c,count} <= count +1;
	  //has passed 16 clk after the last bit has been checked,sampling a bit
	  if(count_c)
	  begin
	    if(num_of_rec <=3'd7)
	    begin //sampling the reciveed bit
	      rsr        <= {rxd_i,rsr[7:1]};
	      num_of_rec <= num_of_rec +1;
	      reg_sta    <= STA_RECIVE;  
	    end
	    else begin//sampling the stop bit
	      if(rxd_i)//if stop bit exist
	      begin
		  data_o  <= rsr;
		  rdy_o   <= 1'b1;
	      end
	      reg_sta    <= STA_IDDLE;
	    end
	  end
	end
      endcase
    end
  end 
endmodule

/////////////////////////////////////////////////////////////////////
////  Author: Zhangfeifei                                        ////
////                                                             ////
////  Advance Test Technology Laboratory,                        ////
////  Institute of Computing Technology,                         ////
////  Chinese Academy of Sciences                                ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: zhangfeifei@ict.ac.cn or whitewill@opencores.org    ////
////  Tel: +86-10-6256 5533 ext. 5673                            ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/ucore      ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2005-2006 Zhangfeifei                         ////
////                         zhangfeifei@ict.ac.cn               ////
////                                                             ////
////                                                             ////
//// This source file may be used and distributed freely without ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and any derivative work contains the  ////
//// original copyright notice and the associated disclaimer.    ////
////                                                             ////
//// Please let the author know if it is used                    ////
//// for commercial purpose.                                     //// 
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
////                                                             ////
//// Date of Creation: 2005.12.3                                 ////
////                                                             ////
//// Version: 0.0.1                                              ////
////                                                             ////
//// Description: tx module of the uart module,data format is    ////
////              8bits data,1 bits stop bit,and no parity check ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Change log:                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////


module uart_txd(
		clk_i,rst_i,//system signal
		data_i,wen_i,//parallel data in and enable signal
		txd_o,//serial data out
		tre_o// ready to transmit flag
		);

  parameter // state difinition
     STA_IDDLE = 0,
     STA_TRANS = 1,
     STA_FINISH = 2;
     
  input clk_i;
  input rst_i;
  input [7:0] data_i;
  input wen_i;
  
  output txd_o;
  output tre_o;
  
  reg txd_o;
  reg tre_o;
   
  reg [7:0] tsr;//transmitting shift register
  reg [3:0] num_of_trans;
  
  reg [1:0] reg_sta;
 
  //the counter to count the clk in
  reg [3:0] count;
  reg count_c;//the carry of count
     
  always @(posedge clk_i or negedge rst_i)
  begin
    if(~rst_i)
    begin
 
      tsr          <= 8'b0;
      txd_o        <= 1'b1;
      tre_o        <= 1'b1;
      num_of_trans <= 3'bx;
      count_c      <= 1'bx;
      count        <= 4'bx;
 
      reg_sta      <= STA_IDDLE;
    end
    else begin
 
      case(reg_sta)
	STA_IDDLE:
	begin
	  num_of_trans    <= 3'd0;
	  count           <= 4'd0;
	  
	  if(wen_i)
	  begin
	    tsr           <= data_i;
	    tre_o         <= 1'b0;
	    txd_o         <= 1'b0;// transmit the start bit 
	    reg_sta       <= STA_TRANS;
	  end
	  else 
	    reg_sta       <= STA_IDDLE;
	end
	STA_TRANS:
	begin
	  {count_c,count} <= count + 1;
	  
	  if(count_c)
	  begin
	    if(num_of_trans <=3'd7)
	    begin
	      //note ,when num_of_trans==7 ,we transmit the stop bit
	      tsr          <= {1'b1,tsr[7:1]};
	      txd_o        <= tsr[0];
	      num_of_trans <= num_of_trans+1;
	      reg_sta      <= STA_TRANS;
	    end
	    else begin
	      txd_o        <= 1'b1;
	      tre_o        <= 1'b1;
	      reg_sta      <= STA_IDDLE;
	    end
	  end
	end
      endcase
    end
  end
    
  
endmodule

/////////////////////////////////////////////////////////////////////
////  Author: Zhangfeifei                                        ////
////                                                             ////
////  Advance Test Technology Laboratory,                        ////
////  Institute of Computing Technology,                         ////
////  Chinese Academy of Sciences                                ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: zhangfeifei@ict.ac.cn or whitewill@opencores.org    ////
////  Tel: +86-10-6256 5533 ext. 5673                            ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/ucore      ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2005-2006 Zhangfeifei                         ////
////                         zhangfeifei@ict.ac.cn               ////
////                                                             ////
////                                                             ////
//// This source file may be used and distributed freely without ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and any derivative work contains the  ////
//// original copyright notice and the associated disclaimer.    ////
////                                                             ////
//// Please let the author know if it is used                    ////
//// for commercial purpose.                                     //// 
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
////                                                             ////
//// Date of Creation: 2005.12.3                                 ////
////                                                             ////
//// Version: 0.0.1                                              ////
////                                                             ////
//// Description: clk divider of the uart module, provide a clk  ////
////              16times quick than the bitrate                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Change log:                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
					 

module clk_div(
	       clk_i,//100 MHZ clk in
	       rst_i,
	       clk_o//sampling clk out
	       );
  
  parameter
    CLK_RATE = 25,//clk rate in MHZ
    BIT_RATE = 9600,
    DIV_NUM = 651;//CLK_RATE*1_000_000/(BIT_RATE*16);//DIV_NUM = 100M/(9600*16)=651 
  
  input clk_i;
  input rst_i;
  //output clk16_o;
  output clk_o;
 
  reg clk_o;
  
  reg [11:0] count;//the minial value of BIT_RATE is 9600 ,
                   //so the maxminal DIV_NUM is 2604,a length of 12 bit is big enough
  //reg [3:0] count16;//a counter has cycle of 16
  //reg count1;
    
  //assign clk16_o = count16[3];
  //assign clk1_o = count1;
  
  always @(posedge clk_i or negedge rst_i)
  begin
    if(~rst_i)
    begin
      //$display("BIT_RATE=%d,DIV_NUM=%d",BIT_RATE,DIV_NUM);
      clk_o <= 1'b1;
      //count16 <= 4'b1000;
      count <= 0;
    end
    else begin
      count <= count +1;
      if(count==DIV_NUM/2) clk_o <= 1'b0;
      else if(count==DIV_NUM)
      begin
	clk_o <= 1'b1;
	//count16 <= count16+1;
	count <= 0;
      end
    end
  end
 
endmodule

/////////////////////////////////////////////////////////////////////
////  Author: Liwei                                              ////
////                                                             ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: mcupro@yahoo.com.hk or mcupro@opencores.org         ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/mips789    ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2006-2007 Liwei                               ////
////                         mcupro@yahoo.com.hk                 ////
////                                                             ////
////                                                             ////
//// This source file may be used and distributed freely without ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and any derivative work contains the  ////
//// original copyright notice and the associated disclaimer.    ////
////                                                             ////
//// Please let the author know if it is used                    ////
//// for commercial purpose.                                     ////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
////                                                             ////
//// Date of Creation: 2007.8.1                                  ////
////                                                             ////
//// Version: 0.0.1                                              ////
////                                                             ////
//// Description:                                                ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Change log:                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

module uart0 (clk,rst,rxd_ft,ser_rxd,txd_ld,din,rxd_rdy,ser_txd,txd_ldok,dout) ;
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
output txd_ldok;
wire txd_ldok;
output [7:0] dout;
wire [7:0] dout;

wire clk_uart;
wire w_rxd_rdy;
wire w_rxd_clr;


assign w_rxd_clr = ~(rst) & rxd_ft;


clk_div clk_div_ff
(
	.clk_i(clk),
	.clk_o(clk_uart),
	.rst_i(rst)
);



uart_rxd rxd_ff
(
	.clk_i(clk_uart),
	.data_o(dout),
	.rdy_o(w_rxd_rdy),
	.rst_i(rst),
	.rxd_i(ser_rxd)
);



rxd_rdy_hold rxd_rdy_hold_lw
(
	.clk(clk_uart),
	.clr(w_rxd_clr),
	.d(w_rxd_rdy),
	.q(rxd_rdy)
);



uart_txd txd_ff
(
	.clk_i(clk_uart),
	.data_i(din),
	.rst_i(rst),
	.tre_o(txd_ldok),
	.txd_o(ser_txd),
	.wen_i(txd_ld)
);

endmodule 
