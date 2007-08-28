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

`define DMEM_SB    1
`define DMEM_LBS   2
`define DMEM_LB    3
`define DMEM_LBU   4
`define DMEM_SW    5
`define DMEM_LW    6
`define DMEM_SH    7
`define DMEM_LHS   8
`define DMEM_LH    9
`define DMEM_LHU   10
`define DMEM_NOP   0


module infile_dmem_ctl_reg(
        input clk,
        input [3:0]ctl_i,
        input [31:0]dmem_addr_i,
        output reg [1:0]byte_addr_o,
        output reg [3:0]ctl_o
    );

    wire   [1:0]byte_addr_i;
    assign byte_addr_i = dmem_addr_i[1:0] ;
    always @(posedge clk)
    begin
        ctl_o<=(dmem_addr_i[31]==0)?ctl_i:0;
        byte_addr_o<=byte_addr_i;
    end

endmodule

module mem_addr_ctl(
        input [3:0]ctl,
        input [31:0]addr_i,
        output reg[3:0]wr_en
    );
    always@(*)
    case (ctl)
        `DMEM_SB:
        begin
            case(addr_i[1:0])
                0:wr_en = 4'b1000;
                1:wr_en = 4'b0100;
                2:wr_en = 4'b0010;
                3:wr_en = 4'b0001;
            endcase
        end
        `DMEM_SH  :
        begin
            case(addr_i[1:0])
                'd0:wr_en=4'b1100;
                'd2:wr_en=4'b0011;
            endcase
        end
        `DMEM_SW :
        begin
            wr_en=4'b1111;
        end
        default wr_en=4'b0000;
    endcase

endmodule



module mem_dout_ctl(
        input [1:0]byte_addr,
        input [3:0]ctl,
        input [31:0] din,
        output reg [31:0] dout
    );

    always @(*)
    case (ctl)

        `DMEM_LBS :
        case (byte_addr)
            'd0:dout={{24{din[31]}},din[31:24]};
            'd1:dout={{24{din[23]}},din[23:16]};
            'd2:dout={{24{din[15]}},din[15:8]};
            'd3:dout={{24{din[7]}},din[7:0] };
            default :
                dout=32'b0;
        endcase//checked
        `DMEM_LBU :
        case (byte_addr)
            'd3:dout={24'b0,din[7:0]};
            'd2:dout={24'b0,din[15:8]};
            'd1:dout={24'b0,din[23:16]};
            'd0:dout={24'b0,din[31:24]};
            default :
                dout=32'b0;
        endcase
        `DMEM_LHU :
        case (byte_addr)
            'd0:dout={16'b0,din[23:16],din[31:24]};
            'd2:dout={16'b0,din[7:0],din[15:8]};
        endcase
        `DMEM_LHS :
        case (byte_addr)
            'd0 :dout={{16{din[23]}},din[23:16],din[31:24]};
            'd2 :dout={{16{din[7 ]}},din[7 :0],din[15:8]};
            default:dout=0;
        endcase
        `DMEM_LW  :
            dout=din;
        default :
            dout=32'b0;
    endcase
endmodule

module mem_din_ctl(
        input [3:0]ctl,
        input [31:0]din,
        output reg [31:0]dout
    );

    always @(*)

    case (ctl)
        `DMEM_SB   :
            dout={din[7:0],din[7:0],din[7:0],din[7:0]};
        `DMEM_SH   :
            dout = {din[15:0],din[15:0]};
        `DMEM_SW   :
            dout =din;
        default dout=din;
    endcase

endmodule

/*

ex. 1,
unsigned short a[4]={0,1,2,3};
00000001
00020003

ex. 2
unsigned char a[4]={0,1,2,3};
00010203


ex.  3
unsigned int b[3]={0x12345678,0,0x12345678};
12345678
00000000
12345678

*/
