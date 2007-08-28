//This file is based on YACC ->alu.v 



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

`define                ALU_ADD      12                
`define                ALU_ADDU     13
`define                ALU_SUB      14
`define                ALU_SUBU     15
`define                ALU_SLTU     16
`define                ALU_SLT      17
`define                ALU_OR       18
`define                ALU_AND      19
`define                ALU_XOR      20
`define                ALU_NOR      21
`define                ALU_PA       22
`define                ALU_PB       23

module alu (a,b,alu_out,alu_func);

    input [31:0] a,b;
    output reg [31:0] alu_out;
    input [4:0]	alu_func;

    wire [31:0] c;

    reg [32:0] sum;

    always @(*)
    begin
        case (alu_func)
            `ALU_PA     : alu_out=a;
            `ALU_PB     : alu_out=b;
            `ALU_ADD    : alu_out=a+b;
            `ALU_SUB  ,
            `ALU_SUBU      : alu_out=a + (~b)+1;
            `ALU_OR     : alu_out=a | b;
            `ALU_AND     : alu_out=a & b;
            `ALU_XOR       : alu_out=a ^ b;
            `ALU_NOR        : alu_out=~(a | b);
            `ALU_SLTU : alu_out=(a < b)?1:0;
            `ALU_SLT :
            begin
                sum={a[31],a}+~{b[31],b}+33'h0_0000_0001;
                alu_out={31'h0000_0000,sum[32]};
            end
            default : alu_out=32'h0;
        endcase
    end
endmodule

/*
this file is based on YACC's alu.v
*/
