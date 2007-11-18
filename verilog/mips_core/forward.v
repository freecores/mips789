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




`define FW_ALU 3'b001
`define FW_MEM 3'b010
`define FW_NOP 3'b100

module fw_latch5(input clk,input[4:0]d,output reg  [4:0]q);
    always @ (posedge clk) q<=d;
endmodule

module fw_latch1(input clk,input d,output reg q);
    always @ (posedge clk) q<=d;
endmodule

module forward_node (
            input [4:0]rn,
            input [4:0]alu_wr_rn,
            input alu_we,
            input [4:0]mem_wr_rn,
            input mem_we,
            output  wire[2:0]mux_fw
        );
    assign mux_fw = ((alu_we)&&(alu_wr_rn==rn)&&(alu_wr_rn!=0))?`FW_ALU:
           ((mem_we)&&(mem_wr_rn==rn)&&(mem_wr_rn!=0))?`FW_MEM:
           `FW_NOP;
endmodule

module forward2 (alu_we,clk,mem_We,fw_alu_rn,fw_mem_rn,rns_i,rnt_i,alu_rs_fw,alu_rt_fw,cmp_rs_fw,
cmp_rt_fw,dmem_fw) ;

input alu_we;
wire alu_we;
input clk;
wire clk;
input mem_We;
wire mem_We;
input [4:0] fw_alu_rn;
wire [4:0] fw_alu_rn;
input [4:0] fw_mem_rn;
wire [4:0] fw_mem_rn;
input [4:0] rns_i;
wire [4:0] rns_i;
input [4:0] rnt_i;
wire [4:0] rnt_i;
output [2:0] alu_rs_fw;
wire [2:0] alu_rs_fw;
output [2:0] alu_rt_fw;
wire [2:0] alu_rt_fw;
output [2:0] cmp_rs_fw;
wire [2:0] cmp_rs_fw;
output [2:0] cmp_rt_fw;
wire [2:0] cmp_rt_fw;
output [2:0] dmem_fw;
wire [2:0] dmem_fw;

wire [2:0] BUS1345;
wire [4:0] BUS82;
wire [4:0] BUS937;

forward_node fw_alu_rs
(
	.alu_we(alu_we),
	.alu_wr_rn(fw_alu_rn),
	.mem_we(mem_We),
	.mem_wr_rn(fw_mem_rn),
	.mux_fw(alu_rs_fw),
	.rn(BUS82)
);



forward_node fw_alu_rt
(
	.alu_we(alu_we),
	.alu_wr_rn(fw_alu_rn),
	.mem_we(mem_We),
	.mem_wr_rn(fw_mem_rn),
	.mux_fw(BUS1345),
	.rn(BUS937)
);



forward_node fw_cmp_rs
(
	.alu_we(alu_we),
	.alu_wr_rn(fw_alu_rn),
	.mem_we(mem_We),
	.mem_wr_rn(fw_mem_rn),
	.mux_fw(cmp_rs_fw),
	.rn(rns_i)
);



forward_node fw_cmp_rt
(
	.alu_we(alu_we),
	.alu_wr_rn(fw_alu_rn),
	.mem_we(mem_We),
	.mem_wr_rn(fw_mem_rn),
	.mux_fw(cmp_rt_fw),
	.rn(rnt_i)
);



fw_latch5 fw_reg_rns
(
	.clk(clk),
	.d(rns_i),
	.q(BUS82)
);



fw_latch5 fw_reg_rnt
(
	.clk(clk),
	.d(rnt_i),
	.q(BUS937)
);


assign alu_rt_fw[2:0] = BUS1345[2:0];
assign dmem_fw[2:0] = BUS1345[2:0];

endmodule 


