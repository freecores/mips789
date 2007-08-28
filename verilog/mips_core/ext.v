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

`define EXT_SIGN              1
`define EXT_UNSIGN            2
`define EXT_J                 3
`define EXT_B                 4
`define EXT_SA                5
`define EXT_S2H               6
`define EXT_NOP               0

module ext(
    input [31:0] ins_i ,
    output reg [31:0] res ,
    input [2:0]ctl);
    
    wire [25:0] instr25_0;
    assign instr25_0 = ins_i[25:0] ;

    wire[15:0] sign = {instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15],instr25_0[15]}	 ;

    always @ (*)
    case (ctl)
        `EXT_SIGN    :res ={sign,instr25_0[15:0]};//sign
        `EXT_UNSIGN  :res ={16'b0,instr25_0[15:0]};//zeroext
        `EXT_J       :res ={4'b0,instr25_0[25:0],2'b0};//jmp
        `EXT_B       :res ={sign[13:0],instr25_0[15:0],2'B0};//brach
        `EXT_SA      :res ={27'b0,instr25_0[10:6]} ;//sll,srl
        `EXT_S2H     :res ={instr25_0[15:0],16'B0};//shift to high
        default: res=0;
    endcase
endmodule
