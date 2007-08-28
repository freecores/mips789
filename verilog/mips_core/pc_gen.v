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
`define   PC_IGN              1                   
`define   PC_KEP              2                   
`define   PC_IRQ              4                   
`define   PC_RST              8 

`define PC_J     1
`define PC_JR    2
`define PC_BC    4
`define PC_NEXT  5	
`define PC_SPC   6
`define PC_RET   6
`define PC_NOP   0

module pc_gen2 (
        input [2:0]ctl,
        output reg   [31:0]pc_next,
        input [3:0] pc_prectl,
        input check,
        input [31:0]s,
        input [31:0]pc,
        input [31:0]zz_spc,
        input [31:0]imm,
        input [31:0]irq
    );

    wire [32:0] br_addr = pc + imm ;

    always @ (*)
        if(pc_prectl == `PC_IGN )
        begin
            case (ctl)
                `PC_RET :		  pc_next = zz_spc ;
                `PC_J:pc_next ={pc[31:28],imm[27:0]};
                `PC_JR: pc_next = s;
                `PC_BC: pc_next = (check)?({br_addr[31:0]}):(pc+4);
                `PC_NEXT:pc_next = pc+ 4 ;
                default pc_next = pc + 4;
            endcase
        end
        else
        begin
            case (pc_prectl)
                `PC_KEP : pc_next=pc;
                `PC_IRQ : pc_next=irq;
                `PC_RST : pc_next='d0;
                default:pc_next =0;
            endcase
        end

endmodule
