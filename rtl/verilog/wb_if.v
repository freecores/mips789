/// I am those days working on adding WISHBONE interface to this core .
//  It now does now fully workes.

module f_d_save( // Added by Liwei 2008,3,17
        input clk,
        input pause ,
        input [31:0] din,
        output reg [31:0] dout
    );

    reg [31:0] save_data;  //temp register

    always @(posedge clk) //latch data at posedge of clk
        if (pause == 0 )save_data  <= din;

    always@(*)         //A MUX to select data for output port
        if (pause ==0 ) dout = din;
        else dout =save_data;

endmodule

/*
module b_d_save( // Added by Liwei 2008,3,17 
        input clk, 
        input pause , 
        input [31:0] din, 
        output reg [31:0] dout); 
    reg lpause; 
    always @(posedge clk)lpause = pause ; 
    reg [31:0] save_data;  //temp register 
    always @(posedge clk) //latch data at posedge of clk 
        if (lpause == 0)save_data  <= din; 
    always@(*)         //A MUX to select data for output port 
        if (lpause ==0 ) dout = din; else dout =save_data; 
endmodule 
*/ 


module b_d_save( // Added by Liwei 2008,3,17
        input clk,
        input pause ,
        input [31:0] din,
        output reg [31:0] dout);

    wire [31:0] w32_1;
    wire w1;
   wire [31:0] w32_2;
    r32_reg_clr_cls r32(
                        .r32_i(din),
                        .r32_o(w32_1),
                        .clk(clk),
                      // .cls(w1),
						.cls(pause),
                        .clr(0)
                    );		  
					    r32_reg_clr_cls r32_1(
                        .r32_i(w32_1),
                        .r32_o(w32_2),
                       .clk(clk),
                      // .cls(w1),
						.cls(pause),
                        .clr(0)
                    );
    r1_reg_clr_cls r1(
                       .r1_i(pause),
                       .r1_o(w1),
                       .clk(clk),
                       .cls(0),
                       .clr(0)
                   );
    always @(*)
        if (pause==0)
            dout=din;
        else
            dout=w32_2;

endmodule					


module b_d_save1( // Added by Liwei 2008,3,17
        input clk,
        input pause ,
        input [31:0] din,
        output reg [31:0] dout);
    /*  reg lpause;
      always @(posedge clk)lpause = pause ; 
     
      reg [31:0] save_data;  //temp register 
      always @(posedge clk) //latch data at posedge of clk 
          if (lpause == 0) 
     save_data  <= din; 
     
    always@(*)         //A MUX to select data for output port 
          if (lpause ==0 ) dout = din; else dout =save_data; 
    */ 
    wire [31:0] w32;
    wire w1;

    r32_reg_clr_cls r32(
                        .r32_i(din),
                        .r32_o(w32),
                        .clk(clk),
                        .cls(w1),
                        .clr(0)
                    );
    r1_reg_clr_cls r1(
                       .r1_i(pause),
                       .r1_o(w1),
                       .clk(clk),
                       .cls(0),
                       .clr(0)
                   );
    always @(*)
        if (w1==0)
            dout=din;
        else
            dout=w32;

endmodule

module addr2sel(
        input [31:0]data_addr,
        output reg sel0,
        output reg sel1,
        output reg sel2,
        output reg sel3,
        output reg sel4,
        output reg sel5,
        output reg sel6,
        output reg sel7,
        output reg sel8

    );

    always @(*)
    casex (data_addr[31:31-4])
        4'b0xxx :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<8;
        4'b1000 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<7;
        4'b1001 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<6;
        4'b1010 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<5;
        4'b1011 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<4;
        4'b1100 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<3;
        4'b1101 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<2;
        4'b1110 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1<<1;
        4'b1111 :{sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 1;
        default   {sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8} = 0;
    endcase
endmodule

module sel_latch (
        input sel0,
        input sel1,
        input sel2,
        input sel3,
        input sel4,
        input sel5,
        input sel6,
        input sel7,
        input sel8,

        output  lsel0,
        output lsel1,
        output  lsel2,
        output lsel3,
        output  lsel4,
        output  lsel5,
        output  lsel6,
        output lsel7,
        output lsel8,

        input clk,
        input pause

    );

    wire  [8:0] w_lsel ;

    assign lsel0 = w_lsel[0];
    assign lsel1 = w_lsel[1];
    assign lsel2 = w_lsel[2];
    assign lsel3 = w_lsel[3];
    assign lsel4 = w_lsel[4];
    assign lsel5 = w_lsel[5];
    assign lsel6 = w_lsel[6];
    assign lsel7 = w_lsel[7];
    assign lsel8 = w_lsel[8];

    wire [8:0] sel_in = {sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8};//,sel0sel0}
    r9_reg_clr_cls sel_reg(
                       .r9_i(sel_in),
                       .r9_o(w_lsel),
                       .clk(clk),
                       .clr(0),
                       .cls(pause)
                   );

endmodule


module wb_ack_mux(
        input lsel0,
        input lsel1,
        input lsel2,
        input lsel3,
        input lsel4,
        input lsel5,
        input lsel6,
        input lsel7,
        input lsel8,

        input ack0  ,
        input ack1  ,
        input ack2  ,
        input ack3  ,
        input ack4  ,
        input ack5  ,
        input ack6  ,
        input ack7  ,
        input ack8  ,
        output pause
    );

    wire [8:0] w_lsel = {lsel0,lsel1,lsel2,lsel3,lsel4,lsel5,lsel6,lsel7,lsel8 };
    wire [8:0] w_ack  = {ack0,ack1,ack2,ack3,ack4,ack5,ack6,ack7,ack8 } ;
    assign pause = (w_lsel & w_ack)!=0 ;

endmodule

module wbbux_data_mux(
        input din0,
        input din1,
        input din2,
        input din3,
        input din4,
        input din5,
        input din6,
        input din7,
        input din8,
        output reg  dout,
        input sel0   ,
        input sel1   ,
        input sel2   ,
        input sel3   ,
        input sel4   ,
        input sel5   ,
        input sel6   ,
        input sel7   ,
        input sel8
    );

    wire [8:0] w_sel = {sel0,sel1,sel2,sel3,sel4,sel5,sel6,sel7,sel8}   ;

    always @ (*)

    case(w_sel)

        1<<8:dout=din0;
        1<<7:dout=din1;
        1<<6:dout=din2;
        1<<5:dout=din3;
        1<<4:dout=din4;
        1<<3:dout=din5;
        1<<2:dout=din6;
        1<<1:dout=din7;
        1<<0:dout=din8;

        default dout='bx;

    endcase

endmodule

////////////////////////////////////
// In order to add pause signal,
// we need to modify pc
///////////////////////////////////

/*
module r1_reg_clr_cls(input[`R1_LEN-1:0] r1_i,output reg[`R1_LEN-1:0] r1_o,input clk,input clr,input cls);always@(posedge clk)if(clr) r1_o<=0;else if(cls)r1_o<=r1_o;else r1_o<=r1_i;endmodule
*/

module pc (
        input clk,
        input pause,
        input clr,
        input [31:0] pc_i,
        input [31:0] pc_o
    );

    wire lpause ;//links to the LATCH of pause ;

    r1_reg_clr_cls pause_latch(
                       .r1_i(pause),
                       .r1_o(lpause ),
                       .cls(0),
                       .clr(clr),
                       .clk(clk)
                   );

    wire pc_cls = lpause | pause ;

    r32_reg_clr_cls pc_latch(
                        .r32_i(pc_i),
                        .r32_o(pc_o ),
                        .cls(pc_cls),
                        .clr(clr),
                        .clk(clk)
                    );

endmodule
