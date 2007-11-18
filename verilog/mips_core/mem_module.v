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



module mem_module1 (clk,din,dmem_addr_i,dmem_ctl,zZ_din,Zz_addr,Zz_dout,Zz_wr_en,dout) ;

// ------------ Port declarations --------- //
input clk;
wire clk;
input [31:0] din;
wire [31:0] din;
input [31:0] dmem_addr_i;
wire [31:0] dmem_addr_i;
input [3:0] dmem_ctl;
wire [3:0] dmem_ctl;
input [31:0] zZ_din;
wire [31:0] zZ_din;
output [31:0] Zz_addr;
wire [31:0] Zz_addr;
output [31:0] Zz_dout;
wire [31:0] Zz_dout;
output [3:0] Zz_wr_en;
wire [3:0] Zz_wr_en;
output [31:0] dout;
wire [31:0] dout;

// ----------- Signal declarations -------- //
wire [3:0] BUS512;
wire [1:0] BUS629;
wire [31:0] BUS650;

// -------- Component instantiations -------//

infile_dmem_ctl_reg dmem_ctl_post
(
	.byte_addr_o(BUS629),
	.clk(clk),
	.ctl_i(dmem_ctl),
	.ctl_o(BUS512),
	.dmem_addr_i(BUS650)
);



mem_addr_ctl i_mem_addr_ctl
(
	.addr_i(BUS650),
	.ctl(dmem_ctl),
	.wr_en(Zz_wr_en)
);



mem_din_ctl i_mem_din_ctl
(
	.ctl(dmem_ctl),
	.din(din),
	.dout(Zz_dout)
);



mem_dout_ctl i_mem_dout_ctl
(
	.byte_addr(BUS629),
	.ctl(BUS512),
	.din(zZ_din),
	.dout(dout)
);



// ----------- Terminals assignment --------//
//	       ---- Input terminals ---         //
assign BUS650[31:0] = dmem_addr_i[31:0];

//		   ---- Output terminals ---        //
assign Zz_addr[31:0] = BUS650[31:0];

endmodule 
