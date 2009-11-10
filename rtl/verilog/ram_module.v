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

module mem_array
    (
        input clk,
        input [31:0] pc_i,
        output [31:0] ins_o,
        input [3:0] wren,
        input [31:0]din,
        input [31:0]data_addr_i,
        output [31:0]dout
    );
    wire [31:0] data_addr;
    wire [31:0]dout_w;
    assign dout = dout_w;
    assign data_addr=data_addr_i[31:2];
    wire [29:0]pc= pc_i[31:2];

    ram2048x8_3 ram3(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(pc),
                    .data_b(din[31:24]),
                    .address_b(data_addr),
                    .wren_b(wren[3]),
                    .clock(clk),
                    .q_a(ins_o[31:24]),
                    .q_b(dout_w[31:24])
                );

    ram2048x8_2 ram2(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(pc),
                    .data_b(din[23:16]),
                    .address_b(data_addr),
                    .wren_b(wren[2]),
                    .clock(clk),
                    .q_a(ins_o[23:16]),
                    .q_b(dout_w[23:16])
                );

    ram2048x8_1 ram1(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(pc),
                    .data_b(din[15:8]),
                    .address_b(data_addr),
                    .wren_b(wren[1]),
                    .clock(clk),
                    .q_a(ins_o[15:8]),
                    .q_b(dout_w[15:8])
                );

    ram2048x8_0 ram0(
                    .data_a(32'b0),
                    .wren_a(1'b0),
                    .address_a(pc),
                    .data_b(din[7:0]),
                    .address_b(data_addr),
                    .wren_b(wren[0]),
                    .clock(clk),
                    .q_a(ins_o[7:0]),
                    .q_b(dout_w[7:0])
                );

endmodule
