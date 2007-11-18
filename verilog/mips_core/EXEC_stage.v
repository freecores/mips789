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



module exec_stage1 
(
clk,rst,spc_cls_i,alu_func,
dmem_fw_ctl,ext_i,fw_alu,fw_dmem,
muxa_ctl_i,muxa_fw_ctl,muxb_ctl_i,
muxb_fw_ctl,pc_i,rs_i,rt_i,alu_ur_o,
dmem_data_ur_o,zz_spc_o
);

input clk;
wire clk;
input rst;
wire rst;
input spc_cls_i;
wire spc_cls_i;
input [4:0] alu_func;
wire [4:0] alu_func;
input [2:0] dmem_fw_ctl;
wire [2:0] dmem_fw_ctl;
input [31:0] ext_i;
wire [31:0] ext_i;
input [31:0] fw_alu;
wire [31:0] fw_alu;
input [31:0] fw_dmem;
wire [31:0] fw_dmem;
input [1:0] muxa_ctl_i;
wire [1:0] muxa_ctl_i;
input [2:0] muxa_fw_ctl;
wire [2:0] muxa_fw_ctl;
input [1:0] muxb_ctl_i;
wire [1:0] muxb_ctl_i;
input [2:0] muxb_fw_ctl;
wire [2:0] muxb_fw_ctl;
input [31:0] pc_i;
wire [31:0] pc_i;
input [31:0] rs_i;
wire [31:0] rs_i;
input [31:0] rt_i;
wire [31:0] rt_i;
output [31:0] alu_ur_o;
wire [31:0] alu_ur_o;
output [31:0] dmem_data_ur_o;
wire [31:0] dmem_data_ur_o;
output [31:0] zz_spc_o;
wire [31:0] zz_spc_o;

wire [31:0] BUS2332;
wire [31:0] BUS2446;
wire [31:0] BUS468;
wire [31:0] BUS476;


big_alu MIPS_alu
(
	.a(BUS476),
	.b(BUS468),
	.c(alu_ur_o),
	.clk(clk),
	.ctl(alu_func),
	.rst(rst)
);



add32 add4
(
	.d_i(pc_i),
	.d_o(BUS2446)
);



dmem_data_mux dmem_data_mux
(
	.data_o(dmem_data_ur_o),
	.fw_alu(fw_alu),
	.fw_ctl(dmem_fw_ctl),
	.fw_dmem(fw_dmem),
	.rt(rt_i)
);



alu_muxa i_alu_muxa
(
	.a_o(BUS476),
	.ctl(muxa_ctl_i),
	.ext(ext_i),
	.fw_alu(fw_alu),
	.fw_ctl(muxa_fw_ctl),
	.fw_mem(fw_dmem),
	.pc(BUS2332),
	.rs(rs_i),
	.spc(zz_spc_o)
);



alu_muxb i_alu_muxb
(
	.b_o(BUS468),
	.ctl(muxb_ctl_i),
	.ext(ext_i),
	.fw_alu(fw_alu),
	.fw_ctl(muxb_fw_ctl),
	.fw_mem(fw_dmem),
	.rt(rt_i)
);



r32_reg pc_nxt
(
	.clk(clk),
	.r32_i(BUS2446),
	.r32_o(BUS2332)
);



r32_reg_cls spc
(
	.clk(clk),
	.cls(spc_cls_i),
	.r32_i(pc_i),
	.r32_o(zz_spc_o)
);



endmodule 
