module sim_syn_ram0(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb);

    input   [7:0]  data;
    input   [10:0]  wraddress;
    input   [10:0]  rdaddress_a;
    input   [10:0]  rdaddress_b;
    input     wren;
    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    input     clock;
    output  [7:0]  qa;
    output  [7:0]  qb;
    reg [7:0] mem_bank  [0:2047]  ;
    initial begin
        mem_bank[0] = 'h00 ; mem_bank[1] = 'hac ; mem_bank[2] = 'h00 ; mem_bank[3] = 'hc0 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'hc4 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'hc0 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h2a ;
        mem_bank[10] = 'hfd ; mem_bank[11] = 'h04 ; mem_bank[12] = 'h17 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h0e ; mem_bank[15] = 'h7f ; mem_bank[16] = 'h14 ; mem_bank[17] = 'hff ; mem_bank[18] = 'hff ; mem_bank[19] = 'hff ;
        mem_bank[20] = 'hff ; mem_bank[21] = 'h08 ; mem_bank[22] = 'h01 ; mem_bank[23] = 'he8 ; mem_bank[24] = 'h14 ; mem_bank[25] = 'h10 ; mem_bank[26] = 'h25 ; mem_bank[27] = 'h25 ; mem_bank[28] = 'h01 ; mem_bank[29] = 'hff ;
        mem_bank[30] = 'h24 ; mem_bank[31] = 'h25 ; mem_bank[32] = 'h0f ; mem_bank[33] = 'h00 ; mem_bank[34] = 'hf9 ; mem_bank[35] = 'h25 ; mem_bank[36] = 'hff ; mem_bank[37] = 'h00 ; mem_bank[38] = 'h10 ; mem_bank[39] = 'h08 ;
        mem_bank[40] = 'h00 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h00 ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ;
    end
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    always @ (posedge clock)
    begin
        r_data<=data;
        r_wraddress<=wraddress;
        r_rdaddress_a<=rdaddress_a;
        r_rdaddress_b<=rdaddress_b;
        r_wren<=wren;
    end
    assign qa =mem_bank[r_rdaddress_a];
    assign qb =mem_bank[r_rdaddress_b];
endmodule



module sim_syn_ram1(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb);

    input   [7:0]  data;
    input   [10:0]  wraddress;
    input   [10:0]  rdaddress_a;
    input   [10:0]  rdaddress_b;
    input     wren;
    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    input     clock;
    output  [7:0]  qa;
    output  [7:0]  qb;
    reg [7:0] mem_bank  [0:2047]  ;
    initial begin
        mem_bank[0] = 'h00 ; mem_bank[1] = 'h80 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h00 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h00 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h02 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h18 ;
        mem_bank[10] = 'hff ; mem_bank[11] = 'h00 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h28 ; mem_bank[17] = 'hff ; mem_bank[18] = 'hff ; mem_bank[19] = 'hff ;
        mem_bank[20] = 'hff ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'hff ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h80 ; mem_bank[27] = 'h20 ; mem_bank[28] = 'h00 ; mem_bank[29] = 'h00 ;
        mem_bank[30] = 'h00 ; mem_bank[31] = 'h80 ; mem_bank[32] = 'h00 ; mem_bank[33] = 'h00 ; mem_bank[34] = 'hff ; mem_bank[35] = 'h20 ; mem_bank[36] = 'h00 ; mem_bank[37] = 'h80 ; mem_bank[38] = 'h00 ; mem_bank[39] = 'h00 ;
        mem_bank[40] = 'h00 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h00 ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ;
    end
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    always @ (posedge clock)
    begin
        r_data<=data;
        r_wraddress<=wraddress;
        r_rdaddress_a<=rdaddress_a;
        r_rdaddress_b<=rdaddress_b;
        r_wren<=wren;
    end
    assign qa =mem_bank[r_rdaddress_a];
    assign qb =mem_bank[r_rdaddress_b];
endmodule



module sim_syn_ram2(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb);

    input   [7:0]  data;
    input   [10:0]  wraddress;
    input   [10:0]  rdaddress_a;
    input   [10:0]  rdaddress_b;
    input     wren;
    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    input     clock;
    output  [7:0]  qa;
    output  [7:0]  qb;
    reg [7:0] mem_bank  [0:2047]  ;
    initial begin
        mem_bank[0] = 'h1c ; mem_bank[1] = 'h9c ; mem_bank[2] = 'h04 ; mem_bank[3] = 'h84 ; mem_bank[4] = 'h05 ; mem_bank[5] = 'ha5 ; mem_bank[6] = 'h1d ; mem_bank[7] = 'hbd ; mem_bank[8] = 'h80 ; mem_bank[9] = 'h85 ;
        mem_bank[10] = 'h60 ; mem_bank[11] = 'h84 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h02 ; mem_bank[16] = 'h42 ; mem_bank[17] = 'h03 ; mem_bank[18] = 'h42 ; mem_bank[19] = 'h43 ;
        mem_bank[20] = 'h42 ; mem_bank[21] = 'he0 ; mem_bank[22] = 'h42 ; mem_bank[23] = 'hbd ; mem_bank[24] = 'hbf ; mem_bank[25] = 'hb0 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h02 ; mem_bank[29] = 'h42 ;
        mem_bank[30] = 'h00 ; mem_bank[31] = 'h40 ; mem_bank[32] = 'h00 ; mem_bank[33] = 'h00 ; mem_bank[34] = 'h00 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h84 ; mem_bank[37] = 'h02 ; mem_bank[38] = 'h42 ; mem_bank[39] = 'he0 ;
        mem_bank[40] = 'h44 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h00 ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ;
    end
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    always @ (posedge clock)
    begin
        r_data<=data;
        r_wraddress<=wraddress;
        r_rdaddress_a<=rdaddress_a;
        r_rdaddress_b<=rdaddress_b;
        r_wren<=wren;
    end
    assign qa =mem_bank[r_rdaddress_a];
    assign qb =mem_bank[r_rdaddress_b];
endmodule



module sim_syn_ram3(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb);

    input   [7:0]  data;
    input   [10:0]  wraddress;
    input   [10:0]  rdaddress_a;
    input   [10:0]  rdaddress_b;
    input     wren;
    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    input     clock;
    output  [7:0]  qa;
    output  [7:0]  qb;
    reg [7:0] mem_bank  [0:2047]  ;
    initial begin
        mem_bank[0] = 'h3c ; mem_bank[1] = 'h37 ; mem_bank[2] = 'h3c ; mem_bank[3] = 'h34 ; mem_bank[4] = 'h3c ; mem_bank[5] = 'h34 ; mem_bank[6] = 'h3c ; mem_bank[7] = 'h37 ; mem_bank[8] = 'hac ; mem_bank[9] = 'h00 ;
        mem_bank[10] = 'h14 ; mem_bank[11] = 'h24 ; mem_bank[12] = 'h0c ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h08 ; mem_bank[15] = 'h3c ; mem_bank[16] = 'h34 ; mem_bank[17] = 'h24 ; mem_bank[18] = 'h24 ; mem_bank[19] = 'h14 ;
        mem_bank[20] = 'h24 ; mem_bank[21] = 'h03 ; mem_bank[22] = 'h24 ; mem_bank[23] = 'h27 ; mem_bank[24] = 'haf ; mem_bank[25] = 'haf ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h02 ; mem_bank[28] = 'h26 ; mem_bank[29] = 'h30 ;
        mem_bank[30] = 'h0c ; mem_bank[31] = 'h00 ; mem_bank[32] = 'h0c ; mem_bank[33] = 'h00 ; mem_bank[34] = 'h10 ; mem_bank[35] = 'h02 ; mem_bank[36] = 'h30 ; mem_bank[37] = 'h3c ; mem_bank[38] = 'h34 ; mem_bank[39] = 'h03 ;
        mem_bank[40] = 'ha0 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h00 ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ;
    end
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    always @ (posedge clock)
    begin
        r_data<=data;
        r_wraddress<=wraddress;
        r_rdaddress_a<=rdaddress_a;
        r_rdaddress_b<=rdaddress_b;
        r_wren<=wren;
    end
    assign qa =mem_bank[r_rdaddress_a];
    assign qb =mem_bank[r_rdaddress_b];
endmodule



