
`timescale 10ns / 1ns
module mips_top_tb;


//Internal signals declarations:
reg clk;
reg rst;
reg ser_rxd;
wire ser_txd;
wire [6:0]seg7led1;
wire [6:0]seg7led2;
wire [7:0]lcd_data;
wire lcd_rs;
wire lcd_rw;
wire lcd_en;
wire led1;
wire led2;
reg key1;
reg key2;



	mips_top mips789_tb (

		.clk(clk),
		.rst(rst),
		.ser_rxd(ser_rxd),
		.ser_txd(ser_txd),
		.seg7led1(seg7led1),
		.seg7led2(seg7led2),
		.lcd_data(lcd_data),
		.lcd_rs(lcd_rs),
		.lcd_rw(lcd_rw),
		.lcd_en(lcd_en),
		.led1(led1),
		.led2(led2),
		.key1(key1),
		.key2(key2));

always #5 clk = ~clk;

initial
	begin
clk = 0; 
rst = 1;
key1= 0;
key2= 0;
ser_rxd = 1;
#10 rst = 0;
#10 rst = 1;
#100000 key1=1;
#10000 key1=0;

end

endmodule
