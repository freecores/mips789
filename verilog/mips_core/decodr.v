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

/*
AT :
we assume WB_EN as MEM_WE
*/
`define   ALU_NOP             0                   
`define   ALU_SRL             1                   
`define   ALU_SLL             2                   
`define   ALU_SRA             4                   


`define   ALU_MFHI            6                   
`define   ALU_MFLO            7 
`define   ALU_MTLO            30
`define   ALU_MTHI            31
`define   ALU_MULTU           8                   
`define   ALU_MULT            9                   
`define   ALU_DIVU            10                  
`define   ALU_DIV             11                  
`define   ALU_ADD             12                  
`define   ALU_ADDU            13                  
`define   ALU_SUB             14                  
`define   ALU_SUBU            15                  
`define   ALU_SLTU            16                  
`define   ALU_SLT             17                  
`define   ALU_OR              18                  
`define   ALU_AND             19                  
`define   ALU_XOR             20                  
`define   ALU_NOR             21                  
`define   ALU_PA              22                  
`define   ALU_PB              23                  

`define   PC_IGN              1                   
`define   PC_KEP              2                   
`define   PC_IRQ              4                   
`define   PC_RST              8                   

`define   PC_J                1                   
`define   PC_JR               2                   
`define   PC_BC               4                   
`define   PC_NEXT             5                   
`define   PC_NOP              0  
`define PC_RET 6 		
 `define PC_SPC 6

`define   RD_RD               1                   
`define   RD_RT               2                   
`define   RD_R31              3                   
`define   RD_NOP              0 
`define RD_ZR 0                  

`define   RD_NOP              0                   

`define   RF                  13                  
`define   EXEC                10                  
`define   DMEM                4                   
`define   WB                  2                   

`define   WB_ALU              0                   
`define   WB_MEM              1                   
`define   WB_NOP              0                   

`define   WB_NOP              0                   

`define   MUXA_PC             1                   
`define   MUXA_RS             2                   
`define   MUXA_EXT            3                   
`define   MUXA_SPC            0                   
`define   MUXA_NOP            0                   

`define   MUXB_RT             1                   
`define   MUXB_EXT            2                   
`define   MUXB_NOP            0                   

`define   MUXB_NOP            0                   
`define   FW_ALU              3'b001              
`define   FW_MEM              3'b010              
`define   FW_NOP              3'b100              

`define   CMP_BEQ             1                   
`define   CMP_BNE             2                   
`define   CMP_BLEZ            3                   
`define   CMP_BGEZ            4                   
`define   CMP_BGTZ            5                   
`define   CMP_BLTZ            6                   
`define   CMP_NOP             0                   

`define   FSM_CUR             1                   
`define   FSM_MUL             2                   
`define   FSM_RET             4                   
`define   FSM_NOP             0  
`define   FSM_LD              5	
`define   FSM_NOI             6

`define   REG_NOP             0                   
`define   REG_CLR             1                   
`define   REG_KEP             2                   

`define   REG_KEP             2                   
`define   EXT_SIGN            1                   
`define   EXT_UNSIGN          2                   
`define   EXT_J               3                   
`define   EXT_B               4                   
`define   EXT_SA              5                   
`define   EXT_S2H             6                   
`define   EXT_NOP             0                   
/*
`define   EXT_CTL_LEN         3                   
`define   RD_SEL_LEN          1                   
`define   CMP_CTL_LEN         3                   
`define   PC_GEN_CTL_LEN      3                   
`define   FSM_CTL_LEN         3                   
`define   MUXA_CTL_LEN        2                   
`define   MUXB_CTL_LEN        2                   
`define   ALU_FUNC_LEN        5                   
`define   ALU_WE_LEN          1                   
`define   DMEM_CTL_LEN        4                   
`define   WB_MUX_CTL_LEN      1                   
`define   WB_WE_LEN           1                   
*/
`define   EN                  1                   
`define   DIS                 0     
`define IGN 0              

`define   DMEM_SB             1                   
`define   DMEM_LBS            2                   
`define   DMEM_LB             3                   
`define   DMEM_LBU            4                   
`define   DMEM_SW             5                   
`define   DMEM_LW             6                   
`define   DMEM_SH             7                   
`define   DMEM_LHS            8                   
`define   DMEM_LH             9                   
`define   DMEM_LHU            10                  
`define   DMEM_NOP            0                   

`define   DMEM_NOP            0


`define   EXT_CTL_LEN         3                   
`define   RD_SEL_LEN          2                   
`define   CMP_CTL_LEN         3                   
`define   PC_GEN_CTL_LEN      3                   
`define   FSM_CTL_LEN         3                   
`define   MUXA_CTL_LEN        2                   
`define   MUXB_CTL_LEN        2                   
`define   ALU_FUNC_LEN        5                   
`define   ALU_WE_LEN          1                   
`define   DMEM_CTL_LEN        4                   
`define   WB_MUX_CTL_LEN      1                   
`define   WB_WE_LEN           1  

module decoder3(
        input [31:0]ins_i,
        output reg [`EXT_CTL_LEN-1:0] ext_ctl,
        output reg [`RD_SEL_LEN-1:0] rd_sel,
        output reg [`CMP_CTL_LEN-1:0]cmp_ctl,
        output reg [`PC_GEN_CTL_LEN-1:0]pc_gen_ctl,
        output reg [`FSM_CTL_LEN-1:0]fsm_dly,
        output reg [`MUXA_CTL_LEN-1:0]muxa_ctl,
        output reg [`MUXB_CTL_LEN-1:0]muxb_ctl,
        output reg [`ALU_FUNC_LEN-1:0]alu_func,
        output reg [`DMEM_CTL_LEN-1:0]dmem_ctl,
        output reg [`ALU_WE_LEN-1:0] alu_we,
        output reg [`WB_MUX_CTL_LEN-1:0]wb_mux,
        output reg [`WB_WE_LEN-1:0]wb_we
    );

    wire [5:0]  inst_op,inst_func;
    wire [4:0]  inst_regimm;//,inst_rs,inst_rt,inst_rd,inst_sa;
    wire [4:0]  inst_cop0_func;//cop0's function code filed
    wire [25:0] inst_cop0_code;//cop0's code field

    assign inst_op        = ins_i[31:26];
    assign inst_func      = ins_i[5:0];
    assign inst_regimm    = ins_i[20:16];
    assign inst_cop0_func = ins_i[25:21];
    assign inst_cop0_code = ins_i[25:0];

    always @(*)
    begin
        case (inst_op)//synthesis parallel_case
            'd0://special operation
            begin
                case (inst_func) //synthesis parallel_case
                    'd0://SLL rd,rt,sa
                    begin
                        //replaceID  = `SLL ;
                        ext_ctl = `EXT_SA;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_EXT;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SLL;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SLL ;
                    end
                    'd2://SRL rd,rt,sa
                    begin
                        //replaceID  = `SRL ;
                        ext_ctl = `EXT_SA;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_EXT;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SRL;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SRL ;
                    end
                    'd3://SRA rd,rt,sa
                    begin
                        //replaceID  = `SRA ;
                        ext_ctl = `EXT_SA;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_EXT;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SRA;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SRA ;
                    end
                    'd4://SLLV rd,rt,rs
                    begin
                        //replaceID  = `SLLV ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `SLLV ;
                    end
                    'd6://SRLV rd,rt,rs
                    begin
                        //replaceID  = `SRLV ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `SRLV ;
                    end
                    'd7://SRAV rd,rt,rs
                    begin
                        //replaceID  = `SRAV ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `SRAV ;
                    end
                    'd8://JR rs
                    begin
                        //replaceID  = `JR ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_JR;
                        fsm_dly = `FSM_CUR;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_NOP;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `JR ;
                    end
                    'd9://JALR jalr rs(rd=31) or jalr rd,rs
                    begin
                        //replaceID  = `JALR ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `JALR ;
                    end
                    'd12://SYSCALL
                    begin
                        //replaceID  = `SYSCALL ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `SYSCALL ;
                    end
                    'd13://BREAK
                    begin
                        //replaceID  = `BREAK ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `BREAK ;
                    end
                    'd16://MFHI rd
                    begin
                        //replaceID  = `MFHI ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_MFHI;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `MFHI ;
                    end
                    'd17://MTHI rs
                    begin
                        //replaceID  = `MTHI ;
                        ext_ctl = `EXT_NOP	;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_MTHI;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `MTHI ;
                    end
                    'd18://MFLO rd
                    begin
                        //replaceID  = `MFLO ;
                        ext_ctl = `EXT_NOP	;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_MFLO;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `MFLO ;
                    end
                    'd19://MTLO rs
                    begin
                        //replaceID  = `MTLO ;
                        ext_ctl = `EXT_NOP	;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_MFLO;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;

                        //end of `MTLO ;
                    end
                    'd24://MULT rs,rt
                    begin
                        //replaceID  = `MULT ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_MUL;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_MULT;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `MULT ;
                    end
                    'd25://MULTU rs,rt
                    begin
                        //replaceID  = `MULTU ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_MUL;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_MULTU;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `MULTU ;
                    end
                    'd26://DIV rs,rt
                    begin
                        //replaceID  = `DIV ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_MUL;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_DIV;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `DIV ;
                    end
                    'd27://DIVU rs,rt
                    begin
                        //replaceID  = `DIVU ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_MUL;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_DIVU;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `DIVU ;
                    end
                    'd32://ADD rd,rs,rt
                    begin
                        //replaceID  = `ADD ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_ADD;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `ADD ;
                    end
                    'd33://ADDU rd,rs,rt
                    begin
                        //replaceID  = `ADDU ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_ADD;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `ADDU ;
                    end
                    'd34://SUB rd,rs,rt
                    begin
                        //replaceID  = `SUB ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SUB;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SUB ;
                    end
                    'd35://SUBU rd,rs,rt
                    begin
                        //replaceID  = `SUBU ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SUBU;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SUBU ;
                    end
                    'd36://AND rd,rs,rt
                    begin
                        //replaceID  = `AND ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_AND;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `AND ;
                    end
                    'd37://OR rd,rs,rt
                    begin
                        //replaceID  = `OR ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_OR;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `OR ;
                    end
                    'd38://XOR rd,rs,rt
                    begin
                        //replaceID  = `XOR ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_XOR;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `XOR ;
                    end
                    'd39://NOR rd,rs,rt
                    begin
                        //replaceID  = `NOR ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_NOR;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `NOR ;
                    end
                    'd42://SLT rd,rs,rt
                    begin
                        //replaceID  = `SLT ;
                        ext_ctl = `EXT_SIGN;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SLT;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SLT ;
                    end
                    'd43://SLTU rd,rs,rt
                    begin
                        //replaceID  = `SLTU ;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_RS;
                        muxb_ctl = `MUXB_RT;
                        alu_func = `ALU_SLTU;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                        //end of `SLTU ;
                    end
                    default:
                    begin
                        //replaceID  = `INVALID ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `INVALID ;
                    end
                endcase
            end
            'd1://regimm opreation
            begin
                case (inst_regimm) //synthesis parallel_case
                    'd0://BLTZ rs,offset(signed)
                    begin
                        //replaceID  = `BLTZ ;
                        ext_ctl = `EXT_B;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_BLTZ;
                        pc_gen_ctl = `PC_BC;
                        fsm_dly = `FSM_CUR;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_NOP;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `BLTZ ;
                    end
                    'd1://BGEZ rs,offset(signed)
                    begin
                        //replaceID  = `BGEZ ;
                        ext_ctl = `EXT_B;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_BGEZ;
                        pc_gen_ctl = `PC_BC;
                        fsm_dly = `FSM_CUR;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_NOP;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                        //end of `BGEZ ;
                    end
                    'd16://BLTZAL rs,offset(signed)
                    begin
                        //replaceID  = `BLTZAL ;
                        ext_ctl = `IGN;
                        rd_sel = `IGN;
                        cmp_ctl = `IGN;
                        pc_gen_ctl = `IGN;
                        fsm_dly = `IGN;
                        muxa_ctl = `IGN;
                        muxb_ctl = `IGN;
                        alu_func = `IGN;
                        alu_we = `IGN;
                        dmem_ctl = `IGN;
                        wb_we =  `IGN;
                        wb_mux = `IGN;
                        //end of `BLTZAL ;
                    end
                    'd17://BGEZAL rs,offset(signed)
                    begin
                        //replaceID  = `BGEZAL ;
                    end
                    default:
                    begin
                        //replaceID   = `INVALID ;
                    end
                endcase
            end
            'd2://J imm26({pc[31:28],imm26,00})
            begin
                //replaceID  = `J ;
                ext_ctl = `EXT_J;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_J;
                fsm_dly = `FSM_NOI;
                muxa_ctl = `MUXA_NOP;
                muxb_ctl = `MUXB_NOP;
                alu_func = `ALU_NOP;
                alu_we = `DIS;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `J ;
            end
            'd3://JAL imm26({pc[31:28],imm26,00})
            begin
                //replaceID  = `JAL ;
                ext_ctl = `EXT_J;
                rd_sel = `RD_R31;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_J;
                fsm_dly = `FSM_NOI;
                muxa_ctl = `MUXA_PC;
                muxb_ctl = `MUXB_RT;
                alu_func = `ALU_PA;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `JAL ;
            end
            'd4://BEQ rs,rt,offset(signed)
            begin
                //replaceID  = `BEQ ;
                ext_ctl = `EXT_B;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_BEQ;
                pc_gen_ctl = `PC_BC;
                fsm_dly = `FSM_CUR;
                muxa_ctl = `MUXA_NOP;
                muxb_ctl = `MUXB_NOP;
                alu_func = `ALU_NOP;
                alu_we = `DIS;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `BEQ ;
            end
            'd5://BNE rs,rt,offset(signed)
            begin
                //replaceID  = `BNE ;
                ext_ctl = `EXT_B;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_BNE;
                pc_gen_ctl = `PC_BC;
                fsm_dly = `FSM_CUR;
                muxa_ctl = `MUXA_NOP;
                muxb_ctl = `MUXB_NOP;
                alu_func = `ALU_NOP;
                alu_we = `DIS;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `BNE ;
            end
            'd6://BLEZ rs,offset(signed)
            begin
                //replaceID  = `BLEZ ;
                ext_ctl = `EXT_B;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_BLEZ;
                pc_gen_ctl = `PC_BC;
                fsm_dly = `FSM_CUR;
                muxa_ctl = `MUXA_NOP;
                muxb_ctl = `MUXB_NOP;
                alu_func = `ALU_NOP;
                alu_we = `DIS;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `BLEZ ;
            end
            'd7://BGTZ rs,offset(signed)
            begin
                //replaceID  = `BGTZ ;
                ext_ctl = `EXT_B;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_BGTZ;
                pc_gen_ctl = `PC_BC;
                fsm_dly = `FSM_CUR;
                muxa_ctl = `MUXA_NOP;
                muxb_ctl = `MUXB_NOP;
                alu_func = `ALU_NOP;
                alu_we = `DIS;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `BGTZ ;
            end
            'd8://ADDI rt,rs,imm16(singed)
            begin
                //replaceID  = `ADDI ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `ADDI ;
            end
            'd9://ADDIU rt,rs,imm16(singed)
            begin
                //replaceID  = `ADDIU ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `ADDIU ;
            end
            'd10://SLTI rt,rs,imm16(singed)
            begin
                //replaceID  = `SLTI ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_SLT;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `SLTI ;
            end
            'd11://SLTIU rt,rs,imm16(singed)
            begin
                //replaceID  = `SLTIU ;
                ext_ctl = `EXT_UNSIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_SLTU;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `SLTIU ;
            end
            'd12://ANDI rt,rs,imm16(singed)
            begin
                //replaceID  = `ANDI ;
                ext_ctl = `EXT_UNSIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_AND;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `ANDI ;
            end
            'd13://ORI rt,rs,imm16(singed)
            begin
                //replaceID  = `ORI ;
                ext_ctl = `EXT_UNSIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_OR;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `ORI ;
            end
            'd14://XORI rt,rs,imm16(singed)
            begin
                //replaceID  = `XORI ;
                ext_ctl = `EXT_UNSIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_XOR;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `EN;
                wb_mux = `WB_ALU;
                //end of `XORI ;
            end
            'd15://LUI rt,imm16
            begin
                //replaceID  = `LUI ;
                ext_ctl = `EXT_S2H;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_PB;
                alu_we = `EN;
                dmem_ctl = `DMEM_NOP;
                wb_we =  `DIS;
                wb_mux = `WB_ALU;
                //end of `LUI ;
            end
            'd16://COP0 func
            begin
                case(inst_cop0_func) //synthesis parallel_case
                    'd0://mfc0 rt,rd // GPR[rd] = CPR[rt] //differ to mips32 definition
                        //read saved PC
                    begin
                        //replaceID  = `MFC0;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_RD;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_NEXT;
                        fsm_dly = `FSM_NOP;
                        muxa_ctl = `MUXA_SPC;
                        muxb_ctl = `MUXB_EXT;
                        alu_func = `ALU_PA;
                        alu_we = `EN;
                        dmem_ctl = `DMEM_LB;
                        wb_we =  `DIS;
                        wb_mux = `WB_ALU;
                    end

                    'd4://mtc0 rt,rd // CPR[rd] = GPR[rt] //follow the mips32 definition
                    begin	 //return from interrupt
                        //replaceID  = `MTC0;
                        ext_ctl = `EXT_NOP;
                        rd_sel = `RD_NOP;
                        cmp_ctl = `CMP_NOP;
                        pc_gen_ctl = `PC_SPC;
                        fsm_dly = `FSM_RET;
                        muxa_ctl = `MUXA_NOP;
                        muxb_ctl = `MUXB_NOP;
                        alu_func = `ALU_NOP;
                        alu_we = `DIS;
                        dmem_ctl = `DMEM_NOP;
                        wb_we =  `DIS;
                        wb_mux = `WB_NOP;
                    end
                    default:
                    begin

                    end
                endcase
            end
            'd32://LB rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LB ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_LB;
                wb_we =  `EN;
                wb_mux = `WB_MEM;
                //end of `LB ;
            end
            'd33://LH rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LH ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_LH;
                wb_we =  `EN;
                wb_mux = `WB_NOP;
                //end of `LH ;
            end
            'd34://LWL rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LWL ;
                ext_ctl = `IGN;
                rd_sel = `IGN;
                cmp_ctl = `IGN;
                pc_gen_ctl = `IGN;
                fsm_dly = `IGN;
                muxa_ctl = `IGN;
                muxb_ctl = `IGN;
                alu_func = `IGN;
                alu_we = `IGN;
                dmem_ctl = `IGN;
                wb_we =  `IGN;
                wb_mux = `IGN;
                //end of `LWL ;
            end
            'd35://LW rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LW ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_LW;
                wb_we =  `EN;
                wb_mux = `WB_MEM;
                //end of `LW ;
            end
            'd36://LBU rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LBU ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_LBU;
                wb_we =  `EN;
                wb_mux = `WB_MEM;
                //end of `LBU ;
            end
            'd37://LHU rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LHU ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_LHU;
                wb_we =  `EN;
                wb_mux = `WB_MEM;
                //end of `LHU ;
            end
            'd38://LWR rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `LWR ;
                ext_ctl = `IGN;
                rd_sel = `IGN;
                cmp_ctl = `IGN;
                pc_gen_ctl = `IGN;
                fsm_dly = `IGN;
                muxa_ctl = `IGN;
                muxb_ctl = `IGN;
                alu_func = `IGN;
                alu_we = `IGN;
                dmem_ctl = `IGN;
                wb_we =  `IGN;
                wb_mux = `IGN;
                //end of `LWR ;
            end
            'd40://SB rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `SB ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_SB;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `SB ;
            end
            'd41://SH rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `SH ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_RT;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_SH;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `SH ;
            end
            'd42://SWL rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `SWL ;
                ext_ctl = `IGN;
                rd_sel = `IGN;
                cmp_ctl = `IGN;
                pc_gen_ctl = `IGN;
                fsm_dly = `IGN;
                muxa_ctl = `IGN;
                muxb_ctl = `IGN;
                alu_func = `IGN;
                alu_we = `IGN;
                dmem_ctl = `IGN;
                wb_we =  `IGN;
                wb_mux = `IGN;
                //end of `SWL ;
            end
            'd43://SW rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `SW ;
                ext_ctl = `EXT_SIGN;
                rd_sel = `RD_NOP;
                cmp_ctl = `CMP_NOP;
                pc_gen_ctl = `PC_NEXT;
                fsm_dly = `FSM_NOP;
                muxa_ctl = `MUXA_RS;
                muxb_ctl = `MUXB_EXT;
                alu_func = `ALU_ADD;
                alu_we = `DIS;
                dmem_ctl = `DMEM_SW;
                wb_we =  `DIS;
                wb_mux = `WB_NOP;
                //end of `SW ;
            end
            'd46://SWR rt,offset(base) (offset:signed;base:rs)
            begin
                //replaceID  = `SWR ;
                ext_ctl = `IGN;
                rd_sel = `IGN;
                cmp_ctl = `IGN;
                pc_gen_ctl = `IGN;
                fsm_dly = `IGN;
                muxa_ctl = `IGN;
                muxb_ctl = `IGN;
                alu_func = `IGN;
                alu_we = `IGN;
                dmem_ctl = `IGN;
                wb_we =  `IGN;
                wb_mux = `IGN;
                //end of `SWR ;
            end
            default:
            begin
                //replaceID   = `INVALID ;
            end
        endcase
    end
endmodule
