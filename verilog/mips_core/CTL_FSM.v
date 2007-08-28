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

module ctl_FSM8 (
        clk, iack, id2ra_ctl_clr, id2ra_ctl_cls,
        id2ra_ins_clr, id2ra_ins_cls, id_cmd, irq,
        pc_prectl, ra2exec_ctl_clr, rst	   ,zz_is_nop
    );

    parameter
        ID_CUR	 = 1,
        ID_LD	 = 5,
        ID_MUL	 = 2,
        ID_NOI	 = 6,
        ID_RET	 = 4,
        ONE	 = 1,
        PC_IGN	 = 1,
        PC_IRQ	 = 4,
        PC_KEP	 = 2,
        PC_RST	 = 8,
        ZERO	 = 0;
    input   clk;
    input   [2:0] id_cmd;
    input   irq;
    input   rst;
    output  iack;
    output zz_is_nop;
    output  id2ra_ctl_clr;
    output  id2ra_ctl_cls;
    output  id2ra_ins_clr;
    output  id2ra_ins_cls;
    output  [3:0] pc_prectl;
    output  ra2exec_ctl_clr;

    wire    clk;
    reg     iack;
    reg zz_is_nop;
    reg     id2ra_ctl_clr;
    reg     id2ra_ctl_cls;
    reg     id2ra_ins_clr;
    reg     id2ra_ins_cls;
    wire    [2:0] id_cmd;
    wire    irq;
    reg     [3:0] pc_prectl;
    reg     ra2exec_ctl_clr;
    wire    rst;
									  
    reg  [0:5]delay_counter_Sreg0, next_delay_counter_Sreg0;
						
`define D2_MUL_DLY 4'b0000
`define IDLE 4'b0001
`define MUL 4'b0010
`define CUR 4'b0011
`define RET 4'b0100
`define IRQ 4'b0101
`define RST 4'b0110
`define LD 4'b0111
`define NOI 4'b1000

    reg [3:0] CurrState_Sreg0;
    reg [3:0] NextState_Sreg0;
    reg riack;
										  
    always @ (*)
    begin : Sreg0_NextState
        case (CurrState_Sreg0) // synopsys parallel_case full_case
            `IDLE:
            begin
                id2ra_ins_clr=ZERO;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ZERO;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr =ZERO;
                pc_prectl=PC_IGN;
                iack = riack;
                if ((irq)&&(~iack))
                    NextState_Sreg0 <= `IRQ;
                else if (id_cmd ==ID_NOI)
                    NextState_Sreg0 <= `NOI;
                else if (id_cmd==ID_CUR)
                    NextState_Sreg0 <= `CUR;
                else if (id_cmd==ID_MUL)
                    NextState_Sreg0 <= `MUL;
                else if (id_cmd==ID_LD)
                    NextState_Sreg0 <= `LD;
                else if (id_cmd==ID_RET)
                    NextState_Sreg0 <= `RET;
                else
                    NextState_Sreg0 <= `IDLE;
            end
            `MUL:
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ZERO;
                pc_prectl =PC_KEP;
                iack = riack;
                NextState_Sreg0 <= `D2_MUL_DLY;
                next_delay_counter_Sreg0 <= 34 - 1;
                zz_is_nop =0;
            end
            `CUR:
            begin
                id2ra_ins_clr=ZERO;
                id2ra_ins_cls=ONE;
                id2ra_ctl_clr=ZERO;
                id2ra_ctl_cls=ONE;
                ra2exec_ctl_clr=ONE;
                pc_prectl =PC_KEP;
                iack = riack;
                NextState_Sreg0 <= `NOI;
                zz_is_nop = 1;
            end
            `RET:
            begin
                id2ra_ins_clr=ZERO;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ZERO;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr =ZERO;
                pc_prectl =PC_IGN;
                iack =ZERO;
                riack =ZERO;
                NextState_Sreg0 <= `IDLE;
                zz_is_nop = ZERO;
            end
            `IRQ:
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ONE;
                pc_prectl =PC_IRQ;
                iack =ONE;
                riack=ONE;
                NextState_Sreg0 <= `IDLE;
                zz_is_nop = ZERO;
            end
            `RST:
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ONE;
                pc_prectl=PC_RST;
                iack=ZERO;
                riack=ZERO;
                NextState_Sreg0 <= `IDLE;
                zz_is_nop = ONE;
            end
            `LD:
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ZERO;
                pc_prectl =PC_KEP;
                iack=riack;
                NextState_Sreg0 <= `IDLE;
                zz_is_nop = ZERO;
            end
            `NOI:
            begin
                id2ra_ins_clr=ZERO;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ZERO;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr =ZERO;
                iack=riack;
                pc_prectl=PC_IGN;
                NextState_Sreg0 <= `IDLE;
                zz_is_nop = ZERO;
            end
            `D2_MUL_DLY:
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ZERO;
                pc_prectl =PC_KEP;
                iack=riack;
                zz_is_nop = ONE;
                if (delay_counter_Sreg0 == 0)
                    NextState_Sreg0 <= `IDLE;
                else
                begin
                    NextState_Sreg0 <= `D2_MUL_DLY;
                    if (delay_counter_Sreg0 != 0) next_delay_counter_Sreg0 <= delay_counter_Sreg0 - 1;
                end
            end
            default :
            begin
                id2ra_ins_clr=ONE;
                id2ra_ins_cls=ZERO;
                id2ra_ctl_clr=ONE;
                id2ra_ctl_cls=ZERO;
                ra2exec_ctl_clr=ONE;
                pc_prectl=PC_RST;
                iack=ZERO;
                riack=ZERO;
                zz_is_nop = ONE;
                NextState_Sreg0 <= `IDLE;
            end
        endcase
    end

    always @ (posedge clk or negedge rst)
    begin : Sreg0_CurrentState
        if (~rst)
            CurrState_Sreg0 <= `RST;
        else
            CurrState_Sreg0 <= NextState_Sreg0;
    end
									
    always @ (posedge clk or negedge rst)
    begin : Sreg0_RegOutput
        if (~rst)
        begin
            delay_counter_Sreg0 <= 0	;	// Initialization in the reset state or default value required!!
        end
        else
        begin
            delay_counter_Sreg0 <= next_delay_counter_Sreg0;
        end
    end

endmodule


/*
how to modify this module 
	1,add riack
	2,change the `RST action as default
	3,set `IRQ has highest pority.
*/
