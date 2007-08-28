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


`define CMP_BEQ      1
`define CMP_BNE      2
`define CMP_BLEZ     3
`define CMP_BGEZ     4
`define CMP_BGTZ     5
`define CMP_BLTZ     6
`define CMP_NOP      0	  

module compare (
        input [31:0] s,
        input [31:0] t,
        input [2:0]ctl,
        output reg res
    );
    reg [32:0]sum;
    always @ (*)
    case  (ctl)
        `CMP_BEQ:   res = s==t;
        `CMP_BNE:   res = s!=t;
        `CMP_BLTZ:  res = s[31];
        `CMP_BGTZ:  res = ~s[31] && (|s[30:0]);
        `CMP_BLEZ:  res = s[31] |(~|s);
        `CMP_BGEZ:  res = ~s[31];
        default res=1'B0;
    endcase
endmodule
