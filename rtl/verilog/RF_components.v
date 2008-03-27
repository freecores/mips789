/******************************************************************
 *                                                                * 
 *    Author: Liwei                                               * 
 *                                                                * 
 *    This file is part of the "mips789" project.                 * 
 *    Downloaded from:                                            * 
 *    http://www.opencores.org/pdownloads.cgi/list/mips789        * 
 *                                                                * 
 *    If you encountered any problem, please contact me via       * 
 *    Email:mcupro@opencores.org  or mcupro@163.com               * 
 *                                                                * 
 ******************************************************************/

`include "mips789_defs.v"
module ext(
        input [31:0] ins_i ,
        output reg [31:0] res ,
        input [2:0]ctl
    );

    wire [25:0] instr25_0;
    assign instr25_0 = ins_i[25:0] ;

    wire[15:0] sign = {16{instr25_0[15]}};

    always @ (*)
    case (ctl)
        `EXT_SIGN    :res = `__TP {sign,instr25_0[15:0]};//sign
        `EXT_UNSIGN  :res = `__TP {16'b0,instr25_0[15:0]};//zeroext
        `EXT_J       :res = `__TP {4'b0,instr25_0[25:0],2'b0};//jmp
        `EXT_B       :res = `__TP {sign[13:0],instr25_0[15:0],2'B0};//branch
        `EXT_SA      :res = `__TP {27'b0,instr25_0[10:6]} ;//sll,srl
        `EXT_S2H     :res = `__TP {instr25_0[15:0],16'B0};//shift to high
        default: res= `__TP 32'bx;
    endcase
endmodule


module compare (
        input [31:0] s,
        input [31:0] t,
        input [2:0]ctl,
        output reg res
    );
    always @ (*)
    case  (ctl)
        `CMP_BEQ:   res = `__TP  (s==t);
        `CMP_BNE:   res = `__TP  (s!=t);
        `CMP_BLTZ:  res = `__TP  s[31];
        `CMP_BGTZ:  res = `__TP  ~s[31] && (|s[30:0]);
        `CMP_BLEZ:  res =  `__TP s[31] |(~|s);
        `CMP_BGEZ:  res = `__TP  ~s[31];
        default res= `__TP 1'Bx;
    endcase
endmodule


module pc_gen(
        input pause,
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
        if (pause)	   pc_next = pc ;
        else begin
            if(pc_prectl == `PC_IGN )
            begin
                case (ctl)
                    `PC_RET 	:	pc_next = `__TP  zz_spc ;
                    `PC_J		:	pc_next = `__TP {pc[31:28],imm[27:0]};
                    `PC_JR		: 	pc_next =  `__TP s;
                    `PC_BC		: begin //	pc_next = (check)?({br_addr[31:0]}):(pc+4);
                        if (check)pc_next =  `__TP {br_addr[31:0]};
                        else pc_next =  `__TP pc+4;
                    end
                    default
                    /* `PC_NEXT	:*/	pc_next = pc + 4 ;
                endcase
            end
            else
            begin
                case (pc_prectl)
                    `PC_KEP 	: pc_next= `__TP pc;
                    `PC_IRQ 	: pc_next= `__TP irq;
                    default
                    /* `PC_RST 	: pc_next= `__TP 'd0;*/
                    pc_next =`__TP 0;
                endcase
            end
        end

endmodule



module reg_array(
        input pause,
        input	[31:0]  data,
        input	[4:0]  wraddress,
        input	[4:0]  rdaddress_a,
        input	[4:0]  rdaddress_b,
        input rd_clk_cls,
        input	wren,
        input	clock,
        output	[31:0]  qa,
        output	[31:0]  qb
    );


    reg	[31:0]  r_data;
    reg	[4:0]  r_wraddress;
    reg	[4:0]  r_rdaddress_a;
    reg	[4:0]  r_rdaddress_b;

    reg r_wren;

    reg [31:0]reg_bank[0:31];

    integer i;
    initial
    begin
        for(i=0;i<32;i=i+1)
            reg_bank[i]=0;
    end

    always@(posedge clock)
        if(0==pause )
        begin
            r_data <=data;
            r_wraddress<=wraddress;
            r_wren<=wren;
        end

    always@(posedge clock)
        if(( 0==rd_clk_cls )&&( 0==pause ))
        begin
            r_rdaddress_a <=rdaddress_a;
            r_rdaddress_b <=rdaddress_b;
        end


    always@(posedge clock)
        if (r_wren)
            reg_bank[r_wraddress] <= r_data ;

    assign qa=(r_rdaddress_a[4:0]==0)?0:
           ((r_wraddress==r_rdaddress_a)&&(1==r_wren))?r_data:
           reg_bank[r_rdaddress_a];

    assign qb=(r_rdaddress_b[4:0]==0)?0:
           ((r_wraddress==r_rdaddress_b)&&(1==r_wren))?r_data:
           reg_bank[r_rdaddress_b];



    always@(posedge clock) //used only for debug
        if((0==pause  )&&(wren)&&(wraddress!=0))
        begin
            $display("%9d ns => Write to register : R%d = %x",$realtime*10,wraddress,data);
        end
endmodule
