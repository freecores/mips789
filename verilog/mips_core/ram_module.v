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

`define DEBUG

module mem_array
    (
        input clk,
        input [31:0] pc_i,
        output [31:0] ins_o,
        input [3:0] wren,
        input [31:0]din,
        input [31:0]wr_addr_i,
        input [31:0]rd_addr_i,
        output [31:0]dout
    );
    wire [31:0] rd_addr,pc,wr_addr;
    wire [31:0]dout_w;
    assign dout = dout_w;
    assign rd_addr=rd_addr_i[31:2];
    assign wr_addr=wr_addr_i[31:2];
    assign pc= pc_i[31:2];

`ifdef DEBUG

    sim_syn_ram3 ram3 (
                     .data(din[31:31-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[3]),
                     .clock(clk),
                     .qa(ins_o[31:31-7]),
                     .qb(dout_w[31:31-7])
                 );

    sim_syn_ram2 ram2(
                     .data(din[31-8:31-8-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[2]),
                     .clock(clk),
                     .qa(ins_o[31-8:31-8-7]),
                     .qb(dout_w[31-8:31-7-8])
                 );

    sim_syn_ram1 ram1(
                     .data(din[31-16:31-16-7]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[1]),
                     .clock(clk),
                     .qa(ins_o[31-16:31-7-16]),
                     .qb(dout_w[31-16:31-7-16])
                 );

    sim_syn_ram0 ram0(
                     .data(din[31-24:31-7-24]),
                     .wraddress(wr_addr),
                     .rdaddress_a(pc),
                     .rdaddress_b(rd_addr),
                     .wren(wren[0]),
                     .clock(clk),
                     .qa(ins_o[31-24:31-7-24]),
                     .qb(dout_w[31-24:31-7-24])
                 );


`else                
    ram4096x8_3 ram3(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[31:24]),
                    .address_b(wr_addr),
                    .wren_b(wren[3]),
                    .clock(clk),
                    .q_a(ins_o[31:24]),
                    .q_b(dout_w[31:24])
                );

    ram4096x8_2 ram2(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[23:16]),
                    .address_b(wr_addr),
                    .wren_b(wren[2]),
                    .clock(clk),
                    .q_a(ins_o[23:16]),
                    .q_b(dout_w[23:16])
                );

    ram4096x8_1 ram1(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[15:8]),
                    .address_b(wr_addr),
                    .wren_b(wren[1]),
                    .clock(clk),
                    .q_a(ins_o[15:8]),
                    .q_b(dout_w[15:8])
                );

    ram4096x8_0 ram0(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(32'b0),
                    .data_b(din[7:0]),
                    .address_b(wr_addr),
                    .wren_b(wren[0]),
                    .clock(clk),
                    .q_a(ins_o[7:0]),
                    .q_b(dout_w[7:0])
                );
`endif

endmodule

