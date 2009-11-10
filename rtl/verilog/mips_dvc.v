
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
`define JTAG_BASE_ADDR      'h8100_0000
`define JTAG_RD_FIFO        'h8100_0100
`define JTAG_RD_FIFO_FLAG   'h8100_0200   
`define USB_DATA_ADDR       'h8100_0300 
`define USB_CTL_ADDR        'h8100_0400  
*/
module mips_dvc (
        input [31:0]din,
        input clk,
        input rst,
        input [31:0]addr ,
        input [3:0]mem_ctl,
        
  output reg [31:0]dout ,
  input tdi,
  output tdo,
  output tms,
  output tck,    
  //68013 interface         
  input int2,int1,
  inout [15:0] usb_data ,
  output reg addr0, addr1, cs,wr,rd,oe,pkt_end    ,led  ,oe573
 
  );     
     
  reg int1_reg;
  reg int2_reg;
  always @ (posedge clk)int1_reg <= int1;		  	    
  always @ (posedge clk)int2_reg <= int2;		   		 
	  
    wire sv_byte = (mem_ctl==`DMEM_SB);
    wire ld_byte =((mem_ctl==`DMEM_LBS)||(mem_ctl==`DMEM_LBU));
    wire sv_wd = (mem_ctl==`DMEM_SW);
    wire ld_wd = (mem_ctl==`DMEM_LW);
 
    wire sv_hw = (mem_ctl==`DMEM_SH);
    wire ld_hw = (mem_ctl==`DMEM_LHU );  
 
    wire load = ld_byte|ld_wd|ld_hw;
     
wire [34:0] fifo_din = {addr[6:4],din[31:0]};
wire sel_jtagc = ((addr[31:24]=='h81)&&(addr[23:7]==0));//((addr[31:0] & 'hff00_0000)==`JTAG_BASE_ADDR) ;
wire wr_jtagc = sv_wd & sel_jtagc ;
wire rd_fifo_data = (addr== `JTAG_RD_FIFO  ) & ld_wd;
wire rd_fifo_flag = (addr== `JTAG_RD_FIFO_FLAG ) & ld_wd;
wire [32:0]fifo_dout;
wire fifo_full;
wire fifo_empty ;
wire jtagc_idle;
reg jtagc_idle_r;
always @ (posedge clk) jtagc_idle_r<=jtagc_idle;
JTAGC  jtag_controller(
        .clk(clk) ,
        .rst(rst) ,
        .tdi(tdi) ,
        .tdo(tdo) ,
        .tms(tms) ,
        .tck(tck) , 
        .fifo_din(fifo_din),
        .fifo_wr(wr_jtagc),
        .fifo_full(fifo_full),
        .fifo_dout(fifo_dout),
        .fifo_rd(rd_fifo_data),
        .fifo_empty(fifo_empty)	  ,
		.SET_TMS(SET_TMS),
		.jtagc_idle(jtagc_idle)
    );
   reg  rd_fifo_data_r ;
   reg dr0_ir1;
   reg fifo_full_r,fifo_empty_r;
   always @ (posedge clk)fifo_full_r <=fifo_full ;
   always @ (posedge clk)fifo_empty_r<=fifo_empty ;
   always @ (posedge clk)rd_fifo_data_r<=rd_fifo_data;
   always @ (posedge clk)if (rd_fifo_data_r)dr0_ir1 <= fifo_dout[32];	 
   reg [31:0] jtag_flags;//
   always @ (posedge clk)
   begin 
   jtag_flags[0] <= dr0_ir1 ;    jtag_flags[1] <= fifo_empty_r ;    jtag_flags[2] <= fifo_full_r ;    
   jtag_flags[3] <=  int2_reg;    jtag_flags[4] <=  int1_reg;    jtag_flags[5] <= jtagc_idle_r ; 
   jtag_flags[31:6]<=0;
   end
    //= {26'b0,jtagc_idle_r,int1_reg ,int2_reg, fifo_full_r,fifo_empty_r,dr0_ir1};
                  //  5       4         3          2                 1      0
 ///////////////////////////////////////////////////////
           
  reg usb_wr ;
  reg SET_TMS ; 
 
   always @ (posedge clk)
   if ((addr==`USB_CTL_ADDR )& sv_wd ) begin    
  usb_wr <= din[0];
  addr0<=   din[1];
  addr1<=   din[2];
  cs<=   din[3];
  wr<=   din[4];
  rd<=   din[5];
  oe<=   din[6];
  pkt_end<= din[7];	  
 SET_TMS <=din[10]; 
 led<=din[11];
 oe573<=din[12];
   end  
   
   
   
reg [15:0] data_fpga2usb;
wire [15:0]  data_usb2fpga  ;
always @ (posedge clk)
   if ((addr ==`USB_DATA_ADDR)&&sv_hw ) 
 begin    
    data_fpga2usb<=din[15:0];
    end
    
   iopin usb16data_pin(
    .en(usb_wr),
    .q(data_usb2fpga),
    .d(data_fpga2usb),
    .pin(usb_data)
    );          
      
reg  [15:0]  data_usb2fpga_r ;
always @ (posedge clk)data_usb2fpga_r<=data_usb2fpga;
reg [31:0]dout_w; 
always@(posedge clk )if (load)
case(addr)  
`USB_DATA_ADDR:begin dout_w[31:16]<=0;dout_w[15:0]<=   data_usb2fpga_r;end
`JTAG_RD_FIFO_FLAG :dout_w<=jtag_flags;
`JTAG_RD_FIFO :begin dout_w[31:16]<=0;dout_w[15:0]<= data_usb2fpga_r;  end
`USB_CTL_ADDR :begin
  dout_w[31:13]<=0;  //
  dout_w[0]<=usb_wr;// <= din[0];
  dout_w[1]<=addr0;//<=   din[1];
  dout_w[2]<=addr1;//<=   din[2];
  dout_w[3]<=cs;//<=   din[3];
  dout_w[4]<=wr;//<=   din[4];
  dout_w[5]<=rd;//<=   din[5];
  dout_w[6]<=oe;//<=   din[6];
  dout_w[7]<=pkt_end;//<= din[7];
  dout_w[10]<=SET_TMS ; 
  dout_w[11]<=led;
  dout_w[12]<=oe573;
end			   
default dout_w<=0;
endcase  
else 
dout_w <=0;  	

always @ (*)
if (rd_fifo_data_r)
dout=fifo_dout[31:0] ;
else dout=dout_w;  	  
endmodule