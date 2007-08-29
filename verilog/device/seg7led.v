`define SEG7LED_ADDR 'H80_00_00_10
`define DMEM_SB 1

module mips_seg7led (
	input [31:0]  addr_i,
	input clk,
	input [31:0] din,
	input [3:0]dmem_ctl_i,
	input rst,
	output [6:0]seg7led1,
	output [6:0]seg7led2
);

reg [7:0] data;

wire   wr_seg7led;
assign wr_seg7led= (addr_i==`SEG7LED_ADDR)&&(dmem_ctl_i==`DMEM_SB )  ; 
always @(posedge clk)
	if 	(wr_seg7led) 
		data<=din[7:0];	  //no matter big-endian  or little		   
		
		assign seg7led1= 	 seg(data[3:0]) ;
		assign seg7led2= 	 seg(data[7:4]) ;
		
		    function [7:0] seg;
        input [3:0] addr;
        begin
            case(addr)
                0: seg = 7'b0111111;
                1: seg = 7'b0000110;
                2: seg = 7'b1011011;
                3: seg = 7'b1001111;
                4: seg = 7'b1100110;
                5: seg = 7'b1101101;
                6: seg = 7'b1111100;
                7: seg = 7'b0000111;
                8: seg = 7'b1111111;
                9: seg = 7'b1100111;
                10: seg = 7'b1110111;
                11: seg = 7'b1111100;
                12: seg = 7'b1011000;
                13: seg = 7'b1011110;
                14: seg = 7'b1111001;
                15: seg = 7'b1110001;
                default: seg = {7{1'b0}};
            endcase
        end
    endfunction
endmodule		  