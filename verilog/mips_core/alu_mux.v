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



`define MUXA_PC 1
`define MUXA_RS 2
`define MUXA_EXT 3
`define MUXA_SPC 0
`define MUXA_NOP 0

`define MUXB_RT 1
`define MUXB_EXT 2
`define MUXB_NOP 0


`define FW_ALU 3'b001
`define FW_MEM 3'b010
`define FW_NOP 3'b100


module alu_muxa(
        input [31:0]spc,
        input [31:0]pc,
        input [31:0]fw_mem,
        input [31:0]rs,
        input [31:0]fw_alu,
        input [31:0]ext,
        input [1:0] ctl,
        input [2:0] fw_ctl,
        output reg [31:0]a_o
    );

    always @(*)
    begin
        case (ctl)
            `MUXA_RS:   a_o = (fw_ctl ==`FW_ALU )?fw_alu:(fw_ctl==`FW_MEM)?fw_mem:rs;
            `MUXA_PC:   a_o = pc;
            `MUXA_EXT:  a_o = ext;
            `MUXA_SPC:  a_o = spc;
            default :   a_o = rs;
        endcase
    end
endmodule

module alu_muxb(
        input [31:0] rt,
        input [31:0]fw_alu,
        input [31:0]fw_mem,
        input [31:0]ext ,
        input [1:0]ctl ,
        input [2:0]fw_ctl ,
        output reg [31:0] b_o
    );
    always@(*)
    case (ctl)
        `MUXB_RT :b_o = (fw_ctl ==`FW_ALU )?fw_alu:(fw_ctl==`FW_MEM)?fw_mem:rt;
        `MUXB_EXT :	b_o=ext;
        default b_o=rt;
    endcase
endmodule
