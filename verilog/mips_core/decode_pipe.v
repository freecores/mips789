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



module decode_pipe3 
(
clk,id2ra_ctl_clr,id2ra_ctl_cls,
ra2ex_ctl_clr,ins_i,alu_func_o,alu_we_o,
cmp_ctl_o,dmem_ctl_o,dmem_ctl_ur_o,ext_ctl_o,
fsm_dly,muxa_ctl_o,muxb_ctl_o,pc_gen_ctl_o,rd_sel_o,
wb_mux_ctl_o,wb_we_o
) ;

input clk;
wire clk;
input id2ra_ctl_clr;
wire id2ra_ctl_clr;
input id2ra_ctl_cls;
wire id2ra_ctl_cls;
input ra2ex_ctl_clr;
wire ra2ex_ctl_clr;
input [31:0] ins_i;
wire [31:0] ins_i;
output [4:0] alu_func_o;
wire [4:0] alu_func_o;
output [0:0] alu_we_o;
wire [0:0] alu_we_o;
output [2:0] cmp_ctl_o;
wire [2:0] cmp_ctl_o;
output [3:0] dmem_ctl_o;
wire [3:0] dmem_ctl_o;
output [3:0] dmem_ctl_ur_o;
wire [3:0] dmem_ctl_ur_o;
output [2:0] ext_ctl_o;
wire [2:0] ext_ctl_o;
output [2:0] fsm_dly;
wire [2:0] fsm_dly;
output [1:0] muxa_ctl_o;
wire [1:0] muxa_ctl_o;
output [1:0] muxb_ctl_o;
wire [1:0] muxb_ctl_o;
output [2:0] pc_gen_ctl_o;
wire [2:0] pc_gen_ctl_o;
output [1:0] rd_sel_o;
wire [1:0] rd_sel_o;
output [0:0] wb_mux_ctl_o;
wire [0:0] wb_mux_ctl_o;
output [0:0] wb_we_o;
wire [0:0] wb_we_o;


wire [4:0] BUS2040;
wire [0:0] BUS2048;
wire [2:0] BUS2056;
wire [3:0] BUS2064;
wire [2:0] BUS2072;
wire [1:0] BUS2086;
wire [1:0] BUS2094;
wire [2:0] BUS2102;
wire [1:0] BUS2110;
wire [0:0] BUS2118;
wire [0:0] BUS2126;


decoder3 decoder
(
	.alu_func(BUS2040),
	.alu_we(BUS2048),
	.cmp_ctl(BUS2056),
	.dmem_ctl(BUS2064),
	.ext_ctl(BUS2072),
	.fsm_dly(fsm_dly),
	.ins_i(ins_i),
	.muxa_ctl(BUS2086),
	.muxb_ctl(BUS2094),
	.pc_gen_ctl(BUS2102),
	.rd_sel(BUS2110),
	.wb_mux(BUS2118),
	.wb_we(BUS2126)
);



pipelinedregs pipereg
(
	.alu_func_i(BUS2040),
	.alu_func_o(alu_func_o),
	.alu_we_i(BUS2048),
	.alu_we_o(alu_we_o),
	.clk(clk),
	.cmp_ctl_i(BUS2056),
	.cmp_ctl_o(cmp_ctl_o),
	.dmem_ctl_i(BUS2064),
	.dmem_ctl_o(dmem_ctl_o),
	.dmem_ctl_ur_o(dmem_ctl_ur_o),
	.ext_ctl(ext_ctl_o),
	.ext_ctl_i(BUS2072),
	.id2ra_ctl_clr(id2ra_ctl_clr),
	.id2ra_ctl_cls(id2ra_ctl_cls),
	.muxa_ctl_i(BUS2086),
	.muxa_ctl_o(muxa_ctl_o),
	.muxb_ctl_i(BUS2094),
	.muxb_ctl_o(muxb_ctl_o),
	.pc_gen_ctl_i(BUS2102),
	.pc_gen_ctl_o(pc_gen_ctl_o),
	.ra2ex_ctl_clr(ra2ex_ctl_clr),
	.rd_sel_i(BUS2110),
	.rd_sel_o(rd_sel_o),
	.wb_mux_ctl_i(BUS2118),
	.wb_mux_ctl_o(wb_mux_ctl_o),
	.wb_we_i(BUS2126),
	.wb_we_o(wb_we_o)
);



endmodule 
