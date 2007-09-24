`include "include.h"
module ctl_FSM (
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
        ONE	     = 1,
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
    reg riack;

    reg  [5:0]delay_counter_Sreg0, next_delay_counter_Sreg0;


    reg [3:0] CurrState_Sreg0;
    reg [3:0] NextState_Sreg0;


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
                else
                    if (id_cmd ==ID_NOI)
                        NextState_Sreg0 <= `NOI;
                    else
                        if (id_cmd==ID_CUR)
                            NextState_Sreg0 <= `CUR;
                        else
                            if (id_cmd==ID_MUL)
                                NextState_Sreg0 <= `MUL;
                            else
                                if (id_cmd==ID_LD)
                                    NextState_Sreg0 <= `LD;
                                else
                                    if (id_cmd==ID_RET)
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
                next_delay_counter_Sreg0 <= 34;
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
                zz_is_nop = ZERO;
                if (id_cmd ==ID_NOI)
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
                    if (delay_counter_Sreg0 != 0)
                        next_delay_counter_Sreg0 <= delay_counter_Sreg0 - 1;
                end
            end

            default :	  //the same as RST
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
                NextState_Sreg0 <=`IDLE;
            end

        endcase
    end

    always @ (posedge clk/* or negedge rst*/)
    begin : Sreg0_CurrentState
        if (rst)
            CurrState_Sreg0 <= `RST;
        else
            CurrState_Sreg0 <= NextState_Sreg0;
    end

    always @ (posedge clk /*or negedge rst*/)
    begin : Sreg0_RegOutput
        if (rst)
        begin
            delay_counter_Sreg0 <= 40	;	// Initialization in the reset state or default value required!!
        end
        else
        begin
            delay_counter_Sreg0 <= next_delay_counter_Sreg0;
        end
    end

endmodule
