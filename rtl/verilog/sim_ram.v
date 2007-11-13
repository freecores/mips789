//This file is only used for simulation.
module sim_mem_array 
    ( 
        input clk, 
        input [31:0] pc_i, 
        output [31:0] ins_o, 
        input [3:0] wren, 
        input [31:0]din, 
        input [31:0]data_addr_i, 
        output [31:0]dout 
    ); 

    wire [29:0] data_addr,pc; 
    wire [31:0]dout_w; 
    assign dout = dout_w; 
    assign data_addr=data_addr_i[31:2]; 
    assign pc= pc_i[31:2]; 

    sim_syn_ram3 ram3 ( 
                     .data(din[31:24]), 
                     .wraddress(data_addr), 
                     .rdaddress_a(pc), 
                     .rdaddress_b(data_addr), 
                     .wren(wren[3]), 
                     .clock(clk), 
                     .qa(ins_o[31:24]), 
                     .qb(dout_w[31:24]) 
                 ); 
    sim_syn_ram2 ram2( 
                     .data(din[23:16]), 
                     .wraddress(data_addr), 
                     .rdaddress_a(pc), 
                     .rdaddress_b(data_addr), 
                     .wren(wren[2]), 
                     .clock(clk), 
                     .qa(ins_o[23:16]), 
                     .qb(dout_w[23:16]) 
                 ); 
    sim_syn_ram1 ram1( 
                     .data(din[15:8]), 
                     .wraddress(data_addr), 
                     .rdaddress_a(pc), 
                     .rdaddress_b(data_addr), 
                     .wren(wren[1]), 
                     .clock(clk), 
                     .qa(ins_o[15:8]), 
                     .qb(dout_w[15:8]) 
                 ); 
    sim_syn_ram0 ram0( 
                     .data(din[7:0]), 
                     .wraddress(data_addr), 
                     .rdaddress_a(pc), 
                     .rdaddress_b(data_addr), 
                     .wren(wren[0]), 
                     .clock(clk), 
                     .qa(ins_o[7:0]), 
                     .qb(dout_w[7:0]) 
                 ); 
endmodule 


module sim_syn_ram0(
    input   [7:0]  data,
    input   [10:0]  wraddress,
    input   [10:0]  rdaddress_a,
    input   [10:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:2047]  ;
    
initial begin   
       mem_bank[0] = 'h00 ; mem_bank[1] = 'hdc ; mem_bank[2] = 'h00 ; mem_bank[3] = 'hf0 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'hf4 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'hf0 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h2a ; 
       mem_bank[10] = 'hfd ; mem_bank[11] = 'h04 ; mem_bank[12] = 'h90 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h0e ; mem_bank[15] = 'h09 ; mem_bank[16] = 'hff ; mem_bank[17] = 'hff ; mem_bank[18] = 'h0d ; mem_bank[19] = 'hff ; 
       mem_bank[20] = 'hff ; mem_bank[21] = 'hff ; mem_bank[22] = 'hff ; mem_bank[23] = 'hfa ; mem_bank[24] = 'h01 ; mem_bank[25] = 'h08 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h40 ; mem_bank[28] = 'h23 ; mem_bank[29] = 'h80 ; 
       mem_bank[30] = 'h21 ; mem_bank[31] = 'hc0 ; mem_bank[32] = 'hff ; mem_bank[33] = 'hff ; mem_bank[34] = 'h09 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h25 ; mem_bank[37] = 'h0b ; mem_bank[38] = 'hff ; mem_bank[39] = 'hff ; 
       mem_bank[40] = 'hff ; mem_bank[41] = 'hff ; mem_bank[42] = 'hfa ; mem_bank[43] = 'h01 ; mem_bank[44] = 'h08 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'hff ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h18 ; mem_bank[49] = 'h00 ; 
       mem_bank[50] = 'h00 ; mem_bank[51] = 'h04 ; mem_bank[52] = 'h08 ; mem_bank[53] = 'h00 ; mem_bank[54] = 'h00 ; mem_bank[55] = 'h18 ; mem_bank[56] = 'h00 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h04 ; mem_bank[59] = 'hfc ; 
       mem_bank[60] = 'h00 ; mem_bank[61] = 'h28 ; mem_bank[62] = 'h08 ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h00 ; mem_bank[65] = 'h18 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h08 ; mem_bank[69] = 'h08 ; 
       mem_bank[70] = 'h00 ; mem_bank[71] = 'h00 ; mem_bank[72] = 'h18 ; mem_bank[73] = 'h00 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h08 ; mem_bank[76] = 'hfc ; mem_bank[77] = 'h00 ; mem_bank[78] = 'h28 ; mem_bank[79] = 'h00 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'hff ; mem_bank[82] = 'h00 ; mem_bank[83] = 'h14 ; mem_bank[84] = 'h00 ; mem_bank[85] = 'h00 ; mem_bank[86] = 'h02 ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h00 ; mem_bank[89] = 'h00 ; 
       mem_bank[90] = 'h02 ; mem_bank[91] = 'h00 ; mem_bank[92] = 'h00 ; mem_bank[93] = 'hfd ; mem_bank[94] = 'h24 ; mem_bank[95] = 'h08 ; mem_bank[96] = 'h00 ; mem_bank[97] = 'h00 ; mem_bank[98] = 'h18 ; mem_bank[99] = 'h00 ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'hc2 ; mem_bank[102] = 'h08 ; mem_bank[103] = 'h01 ; mem_bank[104] = 'he0 ; mem_bank[105] = 'h18 ; mem_bank[106] = 'h14 ; mem_bank[107] = 'h10 ; mem_bank[108] = 'h25 ; mem_bank[109] = 'h0a ; 
       mem_bank[110] = 'h00 ; mem_bank[111] = 'h00 ; mem_bank[112] = 'h0a ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h03 ; mem_bank[115] = 'h00 ; mem_bank[116] = 'h2e ; mem_bank[117] = 'h0d ; mem_bank[118] = 'h00 ; mem_bank[119] = 'h2e ; 
       mem_bank[120] = 'h01 ; mem_bank[121] = 'hf4 ; mem_bank[122] = 'h00 ; mem_bank[123] = 'h18 ; mem_bank[124] = 'h14 ; mem_bank[125] = 'h10 ; mem_bank[126] = 'h08 ; mem_bank[127] = 'h20 ; mem_bank[128] = 'he0 ; mem_bank[129] = 'h18 ; 
       mem_bank[130] = 'h14 ; mem_bank[131] = 'h10 ; mem_bank[132] = 'ha2 ; mem_bank[133] = 'h01 ; mem_bank[134] = 'h02 ; mem_bank[135] = 'hff ; mem_bank[136] = 'ha2 ; mem_bank[137] = 'h38 ; mem_bank[138] = 'h07 ; mem_bank[139] = 'h0f ; 
       mem_bank[140] = 'h20 ; mem_bank[141] = 'hff ; mem_bank[142] = 'hff ; mem_bank[143] = 'hf8 ; mem_bank[144] = 'h00 ; mem_bank[145] = 'ha2 ; mem_bank[146] = 'h0c ; mem_bank[147] = 'h0f ; mem_bank[148] = 'he8 ; mem_bank[149] = 'ha2 ; 
       mem_bank[150] = 'h80 ; mem_bank[151] = 'h0f ; mem_bank[152] = 'he8 ; mem_bank[153] = 'ha2 ; mem_bank[154] = 'h01 ; mem_bank[155] = 'h0f ; mem_bank[156] = 'he8 ; mem_bank[157] = 'h18 ; mem_bank[158] = 'h14 ; mem_bank[159] = 'h10 ; 
       mem_bank[160] = 'h08 ; mem_bank[161] = 'h20 ; mem_bank[162] = 'he8 ; mem_bank[163] = 'h14 ; mem_bank[164] = 'h10 ; mem_bank[165] = 'hff ; mem_bank[166] = 'h00 ; mem_bank[167] = 'h24 ; mem_bank[168] = 'h00 ; mem_bank[169] = 'h00 ; 
       mem_bank[170] = 'h14 ; mem_bank[171] = 'h00 ; mem_bank[172] = 'hfb ; mem_bank[173] = 'h24 ; mem_bank[174] = 'h00 ; mem_bank[175] = 'h00 ; mem_bank[176] = 'hf7 ; mem_bank[177] = 'h24 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h00 ; 
       mem_bank[180] = 'hef ; mem_bank[181] = 'h24 ; mem_bank[182] = 'h00 ; mem_bank[183] = 'h0f ; mem_bank[184] = 'he8 ; mem_bank[185] = 'h00 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h10 ; mem_bank[188] = 'h00 ; mem_bank[189] = 'h14 ; 
       mem_bank[190] = 'h10 ; mem_bank[191] = 'h08 ; mem_bank[192] = 'h18 ; mem_bank[193] = 'he8 ; mem_bank[194] = 'h14 ; mem_bank[195] = 'h10 ; mem_bank[196] = 'hff ; mem_bank[197] = 'h00 ; mem_bank[198] = 'h24 ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h00 ; mem_bank[201] = 'h14 ; mem_bank[202] = 'h00 ; mem_bank[203] = 'h00 ; mem_bank[204] = 'h04 ; mem_bank[205] = 'h00 ; mem_bank[206] = 'h00 ; mem_bank[207] = 'hf7 ; mem_bank[208] = 'h24 ; mem_bank[209] = 'h00 ; 
       mem_bank[210] = 'h00 ; mem_bank[211] = 'hef ; mem_bank[212] = 'h24 ; mem_bank[213] = 'h00 ; mem_bank[214] = 'h0f ; mem_bank[215] = 'he8 ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h10 ; mem_bank[219] = 'h00 ; 
       mem_bank[220] = 'h14 ; mem_bank[221] = 'h10 ; mem_bank[222] = 'h08 ; mem_bank[223] = 'h18 ; mem_bank[224] = 'he8 ; mem_bank[225] = 'h10 ; mem_bank[226] = 'hff ; mem_bank[227] = 'h03 ; mem_bank[228] = 'hff ; mem_bank[229] = 'h02 ; 
       mem_bank[230] = 'h80 ; mem_bank[231] = 'hc0 ; mem_bank[232] = 'ha2 ; mem_bank[233] = 'hff ; mem_bank[234] = 'h10 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h08 ; mem_bank[237] = 'h18 ; mem_bank[238] = 'he8 ; mem_bank[239] = 'h14 ; 
       mem_bank[240] = 'h10 ; mem_bank[241] = 'h25 ; mem_bank[242] = 'hff ; mem_bank[243] = 'hff ; mem_bank[244] = 'he0 ; mem_bank[245] = 'hff ; mem_bank[246] = 'hc1 ; mem_bank[247] = 'h25 ; mem_bank[248] = 'h14 ; mem_bank[249] = 'h10 ; 
       mem_bank[250] = 'h08 ; mem_bank[251] = 'h18 ; mem_bank[252] = 'he8 ; mem_bank[253] = 'h14 ; mem_bank[254] = 'h10 ; mem_bank[255] = 'h25 ; mem_bank[256] = 'hff ; mem_bank[257] = 'he0 ; mem_bank[258] = 'hff ; mem_bank[259] = 'h00 ; 
       mem_bank[260] = 'h00 ; mem_bank[261] = 'h07 ; mem_bank[262] = 'h25 ; mem_bank[263] = 'hc1 ; mem_bank[264] = 'h01 ; mem_bank[265] = 'h00 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'hfb ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h14 ; 
       mem_bank[270] = 'h10 ; mem_bank[271] = 'h08 ; mem_bank[272] = 'h18 ; mem_bank[273] = 'he0 ; mem_bank[274] = 'h18 ; mem_bank[275] = 'h14 ; mem_bank[276] = 'h10 ; mem_bank[277] = 'h25 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h68 ; 
       mem_bank[280] = 'hd0 ; mem_bank[281] = 'hcc ; mem_bank[282] = 'h00 ; mem_bank[283] = 'h1c ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h21 ; mem_bank[286] = 'h40 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'hfd ; mem_bank[289] = 'h00 ; 
       mem_bank[290] = 'h2e ; mem_bank[291] = 'h4f ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h1c ; mem_bank[294] = 'h40 ; mem_bank[295] = 'h00 ; mem_bank[296] = 'h00 ; mem_bank[297] = 'hff ; mem_bank[298] = 'h01 ; mem_bank[299] = 'hfa ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'he8 ; mem_bank[302] = 'h10 ; mem_bank[303] = 'h00 ; mem_bank[304] = 'h14 ; mem_bank[305] = 'h00 ; mem_bank[306] = 'h00 ; mem_bank[307] = 'h00 ; mem_bank[308] = 'h00 ; mem_bank[309] = 'h00 ; 
       mem_bank[310] = 'h34 ; mem_bank[311] = 'h48 ; mem_bank[312] = 'h00 ; mem_bank[313] = 'h10 ; mem_bank[314] = 'h00 ; mem_bank[315] = 'h08 ; mem_bank[316] = 'h18 ; mem_bank[317] = 'h00 ; mem_bank[318] = 'h14 ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'hff ; mem_bank[321] = 'h24 ; mem_bank[322] = 'h00 ; mem_bank[323] = 'h00 ; mem_bank[324] = 'h7f ; mem_bank[325] = 'h24 ; mem_bank[326] = 'h08 ; mem_bank[327] = 'h00 ; mem_bank[328] = 'h00 ; mem_bank[329] = 'h14 ; 
       mem_bank[330] = 'h00 ; mem_bank[331] = 'h00 ; mem_bank[332] = 'h80 ; mem_bank[333] = 'h00 ; mem_bank[334] = 'h00 ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h80 ; mem_bank[337] = 'h00 ; mem_bank[338] = 'h00 ; mem_bank[339] = 'h7f ; 
       mem_bank[340] = 'h24 ; mem_bank[341] = 'h00 ; mem_bank[342] = 'h00 ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h24 ; mem_bank[345] = 'h08 ; mem_bank[346] = 'h00 ; mem_bank[347] = 'h00 ; mem_bank[348] = 'h34 ; mem_bank[349] = 'h00 ; 
       mem_bank[350] = 'h08 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'h00 ; mem_bank[353] = 'h18 ; mem_bank[354] = 'h00 ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h01 ; mem_bank[357] = 'h08 ; mem_bank[358] = 'h01 ; mem_bank[359] = 'h00 ; 
       mem_bank[360] = 'h18 ; mem_bank[361] = 'h00 ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h42 ; mem_bank[364] = 'h01 ; mem_bank[365] = 'h08 ; mem_bank[366] = 'h01 ; mem_bank[367] = 'h00 ; mem_bank[368] = 'h14 ; mem_bank[369] = 'h00 ; 
       mem_bank[370] = 'hdf ; mem_bank[371] = 'h24 ; mem_bank[372] = 'h08 ; mem_bank[373] = 'h00 ; mem_bank[374] = 'h00 ; mem_bank[375] = 'h14 ; mem_bank[376] = 'h00 ; mem_bank[377] = 'h00 ; mem_bank[378] = 'h20 ; mem_bank[379] = 'h08 ; 
       mem_bank[380] = 'h00 ; mem_bank[381] = 'h00 ; mem_bank[382] = 'h14 ; mem_bank[383] = 'h00 ; mem_bank[384] = 'hbf ; mem_bank[385] = 'h24 ; mem_bank[386] = 'h08 ; mem_bank[387] = 'h00 ; mem_bank[388] = 'h00 ; mem_bank[389] = 'h14 ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h00 ; mem_bank[392] = 'h40 ; mem_bank[393] = 'h08 ; mem_bank[394] = 'h00 ; mem_bank[395] = 'hff ; mem_bank[396] = 'h00 ; mem_bank[397] = 'h1c ; mem_bank[398] = 'h08 ; mem_bank[399] = 'h00 ; 
       mem_bank[400] = 'he0 ; mem_bank[401] = 'h18 ; mem_bank[402] = 'h14 ; mem_bank[403] = 'h10 ; mem_bank[404] = 'h25 ; mem_bank[405] = 'h25 ; mem_bank[406] = 'h01 ; mem_bank[407] = 'h8b ; mem_bank[408] = 'hff ; mem_bank[409] = 'h01 ; 
       mem_bank[410] = 'h05 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h6f ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h04 ; mem_bank[415] = 'h01 ; mem_bank[416] = 'h76 ; mem_bank[417] = 'h00 ; mem_bank[418] = 'h01 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h05 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h7d ; mem_bank[423] = 'h00 ; mem_bank[424] = 'hed ; mem_bank[425] = 'h25 ; mem_bank[426] = 'h84 ; mem_bank[427] = 'h00 ; mem_bank[428] = 'he9 ; mem_bank[429] = 'h25 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h73 ; mem_bank[437] = 'h20 ; mem_bank[438] = 'h53 ; mem_bank[439] = 'h20 ; 
       mem_bank[440] = 'h54 ; mem_bank[441] = 'h44 ; mem_bank[442] = 'h00 ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h00 ;     
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
    assign qa =(r_rdaddress_a<444)?mem_bank[r_rdaddress_a]:0;
    assign qb =(r_rdaddress_b<444)?mem_bank[r_rdaddress_b]:0;
endmodule



module sim_syn_ram1(
    input   [7:0]  data,
    input   [10:0]  wraddress,
    input   [10:0]  rdaddress_a,
    input   [10:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:2047]  ;
    
initial begin   
       mem_bank[0] = 'h00 ; mem_bank[1] = 'h86 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h06 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h06 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h08 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h18 ; 
       mem_bank[10] = 'hff ; mem_bank[11] = 'h00 ; mem_bank[12] = 'h01 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'hff ; mem_bank[17] = 'hff ; mem_bank[18] = 'h00 ; mem_bank[19] = 'hff ; 
       mem_bank[20] = 'hff ; mem_bank[21] = 'hff ; mem_bank[22] = 'hff ; mem_bank[23] = 'hff ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h11 ; mem_bank[28] = 'h10 ; mem_bank[29] = 'h10 ; 
       mem_bank[30] = 'h10 ; mem_bank[31] = 'h18 ; mem_bank[32] = 'hff ; mem_bank[33] = 'hff ; mem_bank[34] = 'h00 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h20 ; mem_bank[37] = 'h00 ; mem_bank[38] = 'hff ; mem_bank[39] = 'hff ; 
       mem_bank[40] = 'hff ; mem_bank[41] = 'hff ; mem_bank[42] = 'hff ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h00 ; mem_bank[47] = 'h80 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h00 ; 
       mem_bank[50] = 'h00 ; mem_bank[51] = 'h00 ; mem_bank[52] = 'h00 ; mem_bank[53] = 'h80 ; mem_bank[54] = 'h80 ; mem_bank[55] = 'h00 ; mem_bank[56] = 'h00 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h00 ; mem_bank[59] = 'hff ; 
       mem_bank[60] = 'h80 ; mem_bank[61] = 'h00 ; mem_bank[62] = 'h00 ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h80 ; mem_bank[65] = 'h00 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h00 ; mem_bank[69] = 'h00 ; 
       mem_bank[70] = 'h80 ; mem_bank[71] = 'h80 ; mem_bank[72] = 'h00 ; mem_bank[73] = 'h00 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h00 ; mem_bank[76] = 'hff ; mem_bank[77] = 'h80 ; mem_bank[78] = 'h00 ; mem_bank[79] = 'h00 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h00 ; mem_bank[82] = 'h80 ; mem_bank[83] = 'h00 ; mem_bank[84] = 'h00 ; mem_bank[85] = 'h00 ; mem_bank[86] = 'h00 ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h00 ; mem_bank[89] = 'h00 ; 
       mem_bank[90] = 'h00 ; mem_bank[91] = 'h00 ; mem_bank[92] = 'h00 ; mem_bank[93] = 'hff ; mem_bank[94] = 'h18 ; mem_bank[95] = 'h00 ; mem_bank[96] = 'h00 ; mem_bank[97] = 'h80 ; mem_bank[98] = 'h00 ; mem_bank[99] = 'h00 ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'h10 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h00 ; mem_bank[104] = 'hff ; mem_bank[105] = 'h00 ; mem_bank[106] = 'h00 ; mem_bank[107] = 'h00 ; mem_bank[108] = 'h80 ; mem_bank[109] = 'h00 ; 
       mem_bank[110] = 'h00 ; mem_bank[111] = 'h00 ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h00 ; mem_bank[115] = 'h00 ; mem_bank[116] = 'h00 ; mem_bank[117] = 'h00 ; mem_bank[118] = 'h00 ; mem_bank[119] = 'h00 ; 
       mem_bank[120] = 'h00 ; mem_bank[121] = 'hff ; mem_bank[122] = 'h00 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h00 ; mem_bank[125] = 'h00 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h00 ; mem_bank[128] = 'hff ; mem_bank[129] = 'h00 ; 
       mem_bank[130] = 'h00 ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h00 ; mem_bank[133] = 'h00 ; mem_bank[134] = 'h00 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h00 ; mem_bank[137] = 'h00 ; mem_bank[138] = 'h00 ; mem_bank[139] = 'h00 ; 
       mem_bank[140] = 'ha1 ; mem_bank[141] = 'hff ; mem_bank[142] = 'h00 ; mem_bank[143] = 'hff ; mem_bank[144] = 'h00 ; mem_bank[145] = 'h00 ; mem_bank[146] = 'h00 ; mem_bank[147] = 'h00 ; mem_bank[148] = 'h03 ; mem_bank[149] = 'h00 ; 
       mem_bank[150] = 'h00 ; mem_bank[151] = 'h00 ; mem_bank[152] = 'h03 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h00 ; mem_bank[155] = 'h00 ; mem_bank[156] = 'h03 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h00 ; mem_bank[159] = 'h00 ; 
       mem_bank[160] = 'h00 ; mem_bank[161] = 'h00 ; mem_bank[162] = 'hff ; mem_bank[163] = 'h00 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h00 ; mem_bank[166] = 'h80 ; mem_bank[167] = 'h00 ; mem_bank[168] = 'h00 ; mem_bank[169] = 'h80 ; 
       mem_bank[170] = 'h00 ; mem_bank[171] = 'h00 ; mem_bank[172] = 'hff ; mem_bank[173] = 'h10 ; mem_bank[174] = 'h00 ; mem_bank[175] = 'h00 ; mem_bank[176] = 'hff ; mem_bank[177] = 'h10 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h00 ; 
       mem_bank[180] = 'hff ; mem_bank[181] = 'h10 ; mem_bank[182] = 'h00 ; mem_bank[183] = 'h00 ; mem_bank[184] = 'h03 ; mem_bank[185] = 'h00 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h00 ; mem_bank[188] = 'h00 ; mem_bank[189] = 'h00 ; 
       mem_bank[190] = 'h00 ; mem_bank[191] = 'h00 ; mem_bank[192] = 'h00 ; mem_bank[193] = 'hff ; mem_bank[194] = 'h00 ; mem_bank[195] = 'h00 ; mem_bank[196] = 'h00 ; mem_bank[197] = 'h80 ; mem_bank[198] = 'h00 ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h80 ; mem_bank[201] = 'h00 ; mem_bank[202] = 'h00 ; mem_bank[203] = 'h00 ; mem_bank[204] = 'h00 ; mem_bank[205] = 'h00 ; mem_bank[206] = 'h00 ; mem_bank[207] = 'hff ; mem_bank[208] = 'h10 ; mem_bank[209] = 'h00 ; 
       mem_bank[210] = 'h00 ; mem_bank[211] = 'hff ; mem_bank[212] = 'h10 ; mem_bank[213] = 'h00 ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h03 ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h00 ; 
       mem_bank[220] = 'h00 ; mem_bank[221] = 'h00 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'hff ; mem_bank[225] = 'h00 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h00 ; mem_bank[229] = 'h00 ; 
       mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h00 ; mem_bank[237] = 'h00 ; mem_bank[238] = 'hff ; mem_bank[239] = 'h00 ; 
       mem_bank[240] = 'h00 ; mem_bank[241] = 'h80 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h20 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ; 
       mem_bank[250] = 'h00 ; mem_bank[251] = 'h00 ; mem_bank[252] = 'hff ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h80 ; mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ; 
       mem_bank[260] = 'h00 ; mem_bank[261] = 'h00 ; mem_bank[262] = 'h20 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'h00 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'hff ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h00 ; 
       mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ; mem_bank[272] = 'h00 ; mem_bank[273] = 'hff ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h00 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h80 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'h06 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h80 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ; mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'hff ; mem_bank[289] = 'h00 ; 
       mem_bank[290] = 'h00 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h80 ; mem_bank[293] = 'h00 ; mem_bank[294] = 'h00 ; mem_bank[295] = 'h00 ; mem_bank[296] = 'h00 ; mem_bank[297] = 'h00 ; mem_bank[298] = 'h00 ; mem_bank[299] = 'hff ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'hff ; mem_bank[302] = 'h00 ; mem_bank[303] = 'h80 ; mem_bank[304] = 'h00 ; mem_bank[305] = 'h00 ; mem_bank[306] = 'h00 ; mem_bank[307] = 'h01 ; mem_bank[308] = 'h00 ; mem_bank[309] = 'h80 ; 
       mem_bank[310] = 'h00 ; mem_bank[311] = 'h01 ; mem_bank[312] = 'h00 ; mem_bank[313] = 'h00 ; mem_bank[314] = 'h00 ; mem_bank[315] = 'h00 ; mem_bank[316] = 'h00 ; mem_bank[317] = 'h80 ; mem_bank[318] = 'h00 ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'hfe ; mem_bank[321] = 'h10 ; mem_bank[322] = 'h00 ; mem_bank[323] = 'h00 ; mem_bank[324] = 'hff ; mem_bank[325] = 'h10 ; mem_bank[326] = 'h00 ; mem_bank[327] = 'h00 ; mem_bank[328] = 'h80 ; mem_bank[329] = 'h00 ; 
       mem_bank[330] = 'h00 ; mem_bank[331] = 'h00 ; mem_bank[332] = 'h00 ; mem_bank[333] = 'h00 ; mem_bank[334] = 'h00 ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h00 ; mem_bank[337] = 'h00 ; mem_bank[338] = 'h00 ; mem_bank[339] = 'hff ; 
       mem_bank[340] = 'h10 ; mem_bank[341] = 'h00 ; mem_bank[342] = 'h00 ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h10 ; mem_bank[345] = 'h00 ; mem_bank[346] = 'h00 ; mem_bank[347] = 'h80 ; mem_bank[348] = 'h00 ; mem_bank[349] = 'h00 ; 
       mem_bank[350] = 'h00 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'h80 ; mem_bank[353] = 'h00 ; mem_bank[354] = 'h00 ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h00 ; mem_bank[357] = 'h00 ; mem_bank[358] = 'h00 ; mem_bank[359] = 'h80 ; 
       mem_bank[360] = 'h00 ; mem_bank[361] = 'h00 ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h10 ; mem_bank[364] = 'h00 ; mem_bank[365] = 'h00 ; mem_bank[366] = 'h00 ; mem_bank[367] = 'h80 ; mem_bank[368] = 'h00 ; mem_bank[369] = 'h00 ; 
       mem_bank[370] = 'hff ; mem_bank[371] = 'h18 ; mem_bank[372] = 'h00 ; mem_bank[373] = 'h00 ; mem_bank[374] = 'h80 ; mem_bank[375] = 'h00 ; mem_bank[376] = 'h00 ; mem_bank[377] = 'h00 ; mem_bank[378] = 'h00 ; mem_bank[379] = 'h00 ; 
       mem_bank[380] = 'h00 ; mem_bank[381] = 'h80 ; mem_bank[382] = 'h00 ; mem_bank[383] = 'h00 ; mem_bank[384] = 'hff ; mem_bank[385] = 'h18 ; mem_bank[386] = 'h00 ; mem_bank[387] = 'h00 ; mem_bank[388] = 'h80 ; mem_bank[389] = 'h00 ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h00 ; mem_bank[392] = 'h00 ; mem_bank[393] = 'h00 ; mem_bank[394] = 'h00 ; mem_bank[395] = 'h00 ; mem_bank[396] = 'h80 ; mem_bank[397] = 'h00 ; mem_bank[398] = 'h00 ; mem_bank[399] = 'h00 ; 
       mem_bank[400] = 'hff ; mem_bank[401] = 'h00 ; mem_bank[402] = 'h00 ; mem_bank[403] = 'h00 ; mem_bank[404] = 'h88 ; mem_bank[405] = 'h20 ; mem_bank[406] = 'h00 ; mem_bank[407] = 'h01 ; mem_bank[408] = 'h00 ; mem_bank[409] = 'h00 ; 
       mem_bank[410] = 'h00 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h01 ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'h00 ; mem_bank[416] = 'h01 ; mem_bank[417] = 'h00 ; mem_bank[418] = 'h00 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h00 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h01 ; mem_bank[423] = 'h00 ; mem_bank[424] = 'hff ; mem_bank[425] = 'h20 ; mem_bank[426] = 'h01 ; mem_bank[427] = 'h00 ; mem_bank[428] = 'hff ; mem_bank[429] = 'h20 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h69 ; mem_bank[437] = 'h73 ; mem_bank[438] = 'h50 ; mem_bank[439] = 'h39 ; 
       mem_bank[440] = 'h4f ; mem_bank[441] = 'h41 ; mem_bank[442] = 'h0a ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h00 ;     
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
    assign qa =(r_rdaddress_a<444)?mem_bank[r_rdaddress_a]:0;
    assign qb =(r_rdaddress_b<444)?mem_bank[r_rdaddress_b]:0;
endmodule



module sim_syn_ram2(
    input   [7:0]  data,
    input   [10:0]  wraddress,
    input   [10:0]  rdaddress_a,
    input   [10:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:2047]  ;
    
initial begin   
       mem_bank[0] = 'h1c ; mem_bank[1] = 'h9c ; mem_bank[2] = 'h04 ; mem_bank[3] = 'h84 ; mem_bank[4] = 'h05 ; mem_bank[5] = 'ha5 ; mem_bank[6] = 'h1d ; mem_bank[7] = 'hbd ; mem_bank[8] = 'h80 ; mem_bank[9] = 'h85 ; 
       mem_bank[10] = 'h60 ; mem_bank[11] = 'h84 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h80 ; mem_bank[16] = 'h83 ; mem_bank[17] = 'h04 ; mem_bank[18] = 'h02 ; mem_bank[19] = 'h42 ; 
       mem_bank[20] = 'h44 ; mem_bank[21] = 'h42 ; mem_bank[22] = 'h63 ; mem_bank[23] = 'h64 ; mem_bank[24] = 'h42 ; mem_bank[25] = 'he0 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h04 ; mem_bank[28] = 'h44 ; mem_bank[29] = 'h02 ; 
       mem_bank[30] = 'h44 ; mem_bank[31] = 'h02 ; mem_bank[32] = 'h63 ; mem_bank[33] = 'h02 ; mem_bank[34] = 'h62 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h40 ; mem_bank[37] = 'h02 ; mem_bank[38] = 'h42 ; mem_bank[39] = 'h44 ; 
       mem_bank[40] = 'h42 ; mem_bank[41] = 'h63 ; mem_bank[42] = 'h64 ; mem_bank[43] = 'h42 ; mem_bank[44] = 'he0 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h84 ; mem_bank[47] = 'h02 ; mem_bank[48] = 'h42 ; mem_bank[49] = 'h42 ; 
       mem_bank[50] = 'h00 ; mem_bank[51] = 'h42 ; mem_bank[52] = 'h40 ; mem_bank[53] = 'h02 ; mem_bank[54] = 'h03 ; mem_bank[55] = 'h63 ; mem_bank[56] = 'h62 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h42 ; mem_bank[59] = 'h40 ; 
       mem_bank[60] = 'h02 ; mem_bank[61] = 'h42 ; mem_bank[62] = 'he0 ; mem_bank[63] = 'h44 ; mem_bank[64] = 'h02 ; mem_bank[65] = 'h42 ; mem_bank[66] = 'h42 ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h42 ; mem_bank[69] = 'h40 ; 
       mem_bank[70] = 'h02 ; mem_bank[71] = 'h03 ; mem_bank[72] = 'h63 ; mem_bank[73] = 'h62 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h42 ; mem_bank[76] = 'h40 ; mem_bank[77] = 'h02 ; mem_bank[78] = 'h42 ; mem_bank[79] = 'h42 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h42 ; mem_bank[82] = 'h05 ; mem_bank[83] = 'ha5 ; mem_bank[84] = 'ha3 ; mem_bank[85] = 'h00 ; mem_bank[86] = 'h63 ; mem_bank[87] = 'ha3 ; mem_bank[88] = 'ha3 ; mem_bank[89] = 'h00 ; 
       mem_bank[90] = 'h63 ; mem_bank[91] = 'ha3 ; mem_bank[92] = 'ha3 ; mem_bank[93] = 'h04 ; mem_bank[94] = 'h64 ; mem_bank[95] = 'he0 ; mem_bank[96] = 'ha3 ; mem_bank[97] = 'h02 ; mem_bank[98] = 'h42 ; mem_bank[99] = 'h42 ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'h02 ; mem_bank[102] = 'he0 ; mem_bank[103] = 'h42 ; mem_bank[104] = 'hbd ; mem_bank[105] = 'hbf ; mem_bank[106] = 'hb1 ; mem_bank[107] = 'hb0 ; mem_bank[108] = 'h80 ; mem_bank[109] = 'h11 ; 
       mem_bank[110] = 'h02 ; mem_bank[111] = 'h00 ; mem_bank[112] = 'h40 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h51 ; mem_bank[115] = 'h00 ; mem_bank[116] = 'h00 ; mem_bank[117] = 'h04 ; mem_bank[118] = 'h04 ; mem_bank[119] = 'h00 ; 
       mem_bank[120] = 'h10 ; mem_bank[121] = 'h00 ; mem_bank[122] = 'h00 ; mem_bank[123] = 'hbf ; mem_bank[124] = 'hb1 ; mem_bank[125] = 'hb0 ; mem_bank[126] = 'he0 ; mem_bank[127] = 'hbd ; mem_bank[128] = 'hbd ; mem_bank[129] = 'hbf ; 
       mem_bank[130] = 'hb1 ; mem_bank[131] = 'hb0 ; mem_bank[132] = 'h00 ; mem_bank[133] = 'h04 ; mem_bank[134] = 'h10 ; mem_bank[135] = 'h11 ; mem_bank[136] = 'h00 ; mem_bank[137] = 'h04 ; mem_bank[138] = 'h04 ; mem_bank[139] = 'h00 ; 
       mem_bank[140] = 'h84 ; mem_bank[141] = 'h02 ; mem_bank[142] = 'h50 ; mem_bank[143] = 'h11 ; mem_bank[144] = 'h00 ; mem_bank[145] = 'h00 ; mem_bank[146] = 'h04 ; mem_bank[147] = 'h00 ; mem_bank[148] = 'h04 ; mem_bank[149] = 'h00 ; 
       mem_bank[150] = 'h04 ; mem_bank[151] = 'h00 ; mem_bank[152] = 'h04 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h04 ; mem_bank[155] = 'h00 ; mem_bank[156] = 'h04 ; mem_bank[157] = 'hbf ; mem_bank[158] = 'hb1 ; mem_bank[159] = 'hb0 ; 
       mem_bank[160] = 'he0 ; mem_bank[161] = 'hbd ; mem_bank[162] = 'hbd ; mem_bank[163] = 'hbf ; mem_bank[164] = 'hb0 ; mem_bank[165] = 'h84 ; mem_bank[166] = 'h02 ; mem_bank[167] = 'h42 ; mem_bank[168] = 'h44 ; mem_bank[169] = 'h10 ; 
       mem_bank[170] = 'h10 ; mem_bank[171] = 'h02 ; mem_bank[172] = 'h03 ; mem_bank[173] = 'h43 ; mem_bank[174] = 'h02 ; mem_bank[175] = 'h02 ; mem_bank[176] = 'h03 ; mem_bank[177] = 'h43 ; mem_bank[178] = 'h02 ; mem_bank[179] = 'h02 ; 
       mem_bank[180] = 'h03 ; mem_bank[181] = 'h43 ; mem_bank[182] = 'h02 ; mem_bank[183] = 'h00 ; mem_bank[184] = 'h04 ; mem_bank[185] = 'h02 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h42 ; mem_bank[188] = 'h02 ; mem_bank[189] = 'hbf ; 
       mem_bank[190] = 'hb0 ; mem_bank[191] = 'he0 ; mem_bank[192] = 'hbd ; mem_bank[193] = 'hbd ; mem_bank[194] = 'hbf ; mem_bank[195] = 'hb0 ; mem_bank[196] = 'h84 ; mem_bank[197] = 'h02 ; mem_bank[198] = 'h42 ; mem_bank[199] = 'h44 ; 
       mem_bank[200] = 'h10 ; mem_bank[201] = 'h10 ; mem_bank[202] = 'h02 ; mem_bank[203] = 'h00 ; mem_bank[204] = 'h42 ; mem_bank[205] = 'h02 ; mem_bank[206] = 'h02 ; mem_bank[207] = 'h03 ; mem_bank[208] = 'h43 ; mem_bank[209] = 'h02 ; 
       mem_bank[210] = 'h02 ; mem_bank[211] = 'h03 ; mem_bank[212] = 'h43 ; mem_bank[213] = 'h02 ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h04 ; mem_bank[216] = 'h02 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h42 ; mem_bank[219] = 'h02 ; 
       mem_bank[220] = 'hbf ; mem_bank[221] = 'hb0 ; mem_bank[222] = 'he0 ; mem_bank[223] = 'hbd ; mem_bank[224] = 'hbd ; mem_bank[225] = 'hbf ; mem_bank[226] = 'ha5 ; mem_bank[227] = 'ha0 ; mem_bank[228] = 'h82 ; mem_bank[229] = 'h00 ; 
       mem_bank[230] = 'h42 ; mem_bank[231] = 'h42 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h44 ; mem_bank[234] = 'hbf ; mem_bank[235] = 'h00 ; mem_bank[236] = 'he0 ; mem_bank[237] = 'hbd ; mem_bank[238] = 'hbd ; mem_bank[239] = 'hbf ; 
       mem_bank[240] = 'hb0 ; mem_bank[241] = 'hc0 ; mem_bank[242] = 'ha5 ; mem_bank[243] = 'h10 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h84 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ; mem_bank[248] = 'hbf ; mem_bank[249] = 'hb0 ; 
       mem_bank[250] = 'he0 ; mem_bank[251] = 'hbd ; mem_bank[252] = 'hbd ; mem_bank[253] = 'hbf ; mem_bank[254] = 'hb0 ; mem_bank[255] = 'hc0 ; mem_bank[256] = 'h84 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'ha5 ; mem_bank[259] = 'h02 ; 
       mem_bank[260] = 'h00 ; mem_bank[261] = 'h40 ; mem_bank[262] = 'h40 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h10 ; mem_bank[265] = 'h04 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h80 ; mem_bank[268] = 'h00 ; mem_bank[269] = 'hbf ; 
       mem_bank[270] = 'hb0 ; mem_bank[271] = 'he0 ; mem_bank[272] = 'hbd ; mem_bank[273] = 'hbd ; mem_bank[274] = 'hbf ; mem_bank[275] = 'hb1 ; mem_bank[276] = 'hb0 ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h04 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'h84 ; mem_bank[281] = 'h03 ; mem_bank[282] = 'h02 ; mem_bank[283] = 'h42 ; mem_bank[284] = 'h43 ; mem_bank[285] = 'h11 ; mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h51 ; mem_bank[289] = 'h00 ; 
       mem_bank[290] = 'h00 ; mem_bank[291] = 'h04 ; mem_bank[292] = 'h11 ; mem_bank[293] = 'h31 ; mem_bank[294] = 'h00 ; mem_bank[295] = 'h00 ; mem_bank[296] = 'h02 ; mem_bank[297] = 'h42 ; mem_bank[298] = 'h10 ; mem_bank[299] = 'h00 ; 
       mem_bank[300] = 'h22 ; mem_bank[301] = 'hbd ; mem_bank[302] = 'hbf ; mem_bank[303] = 'h03 ; mem_bank[304] = 'h63 ; mem_bank[305] = 'h62 ; mem_bank[306] = 'h00 ; mem_bank[307] = 'h42 ; mem_bank[308] = 'h62 ; mem_bank[309] = 'h02 ; 
       mem_bank[310] = 'h42 ; mem_bank[311] = 'h00 ; mem_bank[312] = 'h44 ; mem_bank[313] = 'hbf ; mem_bank[314] = 'h00 ; mem_bank[315] = 'he0 ; mem_bank[316] = 'hbd ; mem_bank[317] = 'h04 ; mem_bank[318] = 'h84 ; mem_bank[319] = 'h82 ; 
       mem_bank[320] = 'h03 ; mem_bank[321] = 'h43 ; mem_bank[322] = 'h82 ; mem_bank[323] = 'h82 ; mem_bank[324] = 'h03 ; mem_bank[325] = 'h43 ; mem_bank[326] = 'he0 ; mem_bank[327] = 'h82 ; mem_bank[328] = 'h03 ; mem_bank[329] = 'h63 ; 
       mem_bank[330] = 'h62 ; mem_bank[331] = 'h00 ; mem_bank[332] = 'h42 ; mem_bank[333] = 'h62 ; mem_bank[334] = 'h62 ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h42 ; mem_bank[337] = 'h62 ; mem_bank[338] = 'h62 ; mem_bank[339] = 'h04 ; 
       mem_bank[340] = 'h44 ; mem_bank[341] = 'h62 ; mem_bank[342] = 'h62 ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h44 ; mem_bank[345] = 'he0 ; mem_bank[346] = 'h62 ; mem_bank[347] = 'h02 ; mem_bank[348] = 'h42 ; mem_bank[349] = 'h42 ; 
       mem_bank[350] = 'he0 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'h02 ; mem_bank[353] = 'h42 ; mem_bank[354] = 'h42 ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h42 ; mem_bank[357] = 'he0 ; mem_bank[358] = 'h42 ; mem_bank[359] = 'h02 ; 
       mem_bank[360] = 'h42 ; mem_bank[361] = 'h42 ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h02 ; mem_bank[364] = 'h42 ; mem_bank[365] = 'he0 ; mem_bank[366] = 'h42 ; mem_bank[367] = 'h02 ; mem_bank[368] = 'h42 ; mem_bank[369] = 'h43 ; 
       mem_bank[370] = 'h04 ; mem_bank[371] = 'h64 ; mem_bank[372] = 'he0 ; mem_bank[373] = 'h43 ; mem_bank[374] = 'h03 ; mem_bank[375] = 'h63 ; mem_bank[376] = 'h62 ; mem_bank[377] = 'h00 ; mem_bank[378] = 'h42 ; mem_bank[379] = 'he0 ; 
       mem_bank[380] = 'h62 ; mem_bank[381] = 'h02 ; mem_bank[382] = 'h42 ; mem_bank[383] = 'h43 ; mem_bank[384] = 'h04 ; mem_bank[385] = 'h64 ; mem_bank[386] = 'he0 ; mem_bank[387] = 'h43 ; mem_bank[388] = 'h03 ; mem_bank[389] = 'h63 ; 
       mem_bank[390] = 'h62 ; mem_bank[391] = 'h00 ; mem_bank[392] = 'h42 ; mem_bank[393] = 'he0 ; mem_bank[394] = 'h62 ; mem_bank[395] = 'h84 ; mem_bank[396] = 'h02 ; mem_bank[397] = 'h42 ; mem_bank[398] = 'he0 ; mem_bank[399] = 'h44 ; 
       mem_bank[400] = 'hbd ; mem_bank[401] = 'hbf ; mem_bank[402] = 'hb1 ; mem_bank[403] = 'hb0 ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h20 ; mem_bank[406] = 'h30 ; mem_bank[407] = 'h00 ; mem_bank[408] = 'h11 ; mem_bank[409] = 'h10 ; 
       mem_bank[410] = 'h00 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h00 ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'h22 ; mem_bank[416] = 'h00 ; mem_bank[417] = 'h00 ; mem_bank[418] = 'h22 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h40 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h00 ; mem_bank[423] = 'h00 ; mem_bank[424] = 'h00 ; mem_bank[425] = 'h20 ; mem_bank[426] = 'h00 ; mem_bank[427] = 'h00 ; mem_bank[428] = 'h00 ; mem_bank[429] = 'h20 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h68 ; mem_bank[437] = 'h69 ; mem_bank[438] = 'h49 ; mem_bank[439] = 'h38 ; 
       mem_bank[440] = 'h4f ; mem_bank[441] = 'h4f ; mem_bank[442] = 'h52 ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h00 ;     
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
    assign qa =(r_rdaddress_a<444)?mem_bank[r_rdaddress_a]:0;
    assign qb =(r_rdaddress_b<444)?mem_bank[r_rdaddress_b]:0;
endmodule



module sim_syn_ram3(
    input   [7:0]  data,
    input   [10:0]  wraddress,
    input   [10:0]  rdaddress_a,
    input   [10:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [10:0]  r_wraddress;
    reg [10:0]  r_rdaddress_a;
    reg [10:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:2047]  ;
    
initial begin   
       mem_bank[0] = 'h3c ; mem_bank[1] = 'h37 ; mem_bank[2] = 'h3c ; mem_bank[3] = 'h34 ; mem_bank[4] = 'h3c ; mem_bank[5] = 'h34 ; mem_bank[6] = 'h3c ; mem_bank[7] = 'h37 ; mem_bank[8] = 'hac ; mem_bank[9] = 'h00 ; 
       mem_bank[10] = 'h14 ; mem_bank[11] = 'h24 ; mem_bank[12] = 'h0c ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h08 ; mem_bank[15] = 'h10 ; mem_bank[16] = 'h24 ; mem_bank[17] = 'h24 ; mem_bank[18] = 'h24 ; mem_bank[19] = 'h24 ; 
       mem_bank[20] = 'h14 ; mem_bank[21] = 'h24 ; mem_bank[22] = 'h24 ; mem_bank[23] = 'h14 ; mem_bank[24] = 'h24 ; mem_bank[25] = 'h03 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h00 ; mem_bank[29] = 'h00 ; 
       mem_bank[30] = 'h00 ; mem_bank[31] = 'h00 ; mem_bank[32] = 'h24 ; mem_bank[33] = 'h24 ; mem_bank[34] = 'h10 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h00 ; mem_bank[37] = 'h24 ; mem_bank[38] = 'h24 ; mem_bank[39] = 'h14 ; 
       mem_bank[40] = 'h24 ; mem_bank[41] = 'h24 ; mem_bank[42] = 'h14 ; mem_bank[43] = 'h24 ; mem_bank[44] = 'h03 ; mem_bank[45] = 'h00 ; mem_bank[46] = 'h30 ; mem_bank[47] = 'h3c ; mem_bank[48] = 'h34 ; mem_bank[49] = 'h8c ; 
       mem_bank[50] = 'h00 ; mem_bank[51] = 'h30 ; mem_bank[52] = 'h10 ; mem_bank[53] = 'h3c ; mem_bank[54] = 'h3c ; mem_bank[55] = 'h34 ; mem_bank[56] = 'h8c ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h30 ; mem_bank[59] = 'h14 ; 
       mem_bank[60] = 'h3c ; mem_bank[61] = 'h34 ; mem_bank[62] = 'h03 ; mem_bank[63] = 'ha0 ; mem_bank[64] = 'h3c ; mem_bank[65] = 'h34 ; mem_bank[66] = 'h8c ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h30 ; mem_bank[69] = 'h14 ; 
       mem_bank[70] = 'h3c ; mem_bank[71] = 'h3c ; mem_bank[72] = 'h34 ; mem_bank[73] = 'h8c ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h30 ; mem_bank[76] = 'h10 ; mem_bank[77] = 'h3c ; mem_bank[78] = 'h34 ; mem_bank[79] = 'h90 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h30 ; mem_bank[82] = 'h3c ; mem_bank[83] = 'h34 ; mem_bank[84] = 'h8c ; mem_bank[85] = 'h00 ; mem_bank[86] = 'h34 ; mem_bank[87] = 'hac ; mem_bank[88] = 'h8c ; mem_bank[89] = 'h00 ; 
       mem_bank[90] = 'h34 ; mem_bank[91] = 'hac ; mem_bank[92] = 'h8c ; mem_bank[93] = 'h24 ; mem_bank[94] = 'h00 ; mem_bank[95] = 'h03 ; mem_bank[96] = 'hac ; mem_bank[97] = 'h3c ; mem_bank[98] = 'h34 ; mem_bank[99] = 'h8c ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'h00 ; mem_bank[102] = 'h03 ; mem_bank[103] = 'h30 ; mem_bank[104] = 'h27 ; mem_bank[105] = 'haf ; mem_bank[106] = 'haf ; mem_bank[107] = 'haf ; mem_bank[108] = 'h00 ; mem_bank[109] = 'h24 ; 
       mem_bank[110] = 'h92 ; mem_bank[111] = 'h00 ; mem_bank[112] = 'h10 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h14 ; mem_bank[115] = 'h00 ; mem_bank[116] = 'h0c ; mem_bank[117] = 'h24 ; mem_bank[118] = 'h92 ; mem_bank[119] = 'h0c ; 
       mem_bank[120] = 'h26 ; mem_bank[121] = 'h10 ; mem_bank[122] = 'h00 ; mem_bank[123] = 'h8f ; mem_bank[124] = 'h8f ; mem_bank[125] = 'h8f ; mem_bank[126] = 'h03 ; mem_bank[127] = 'h27 ; mem_bank[128] = 'h27 ; mem_bank[129] = 'haf ; 
       mem_bank[130] = 'haf ; mem_bank[131] = 'haf ; mem_bank[132] = 'h0c ; mem_bank[133] = 'h24 ; mem_bank[134] = 'h24 ; mem_bank[135] = 'h24 ; mem_bank[136] = 'h0c ; mem_bank[137] = 'h24 ; mem_bank[138] = 'h3c ; mem_bank[139] = 'h0c ; 
       mem_bank[140] = 'h34 ; mem_bank[141] = 'h26 ; mem_bank[142] = 'h30 ; mem_bank[143] = 'h16 ; mem_bank[144] = 'h00 ; mem_bank[145] = 'h0c ; mem_bank[146] = 'h24 ; mem_bank[147] = 'h0c ; mem_bank[148] = 'h24 ; mem_bank[149] = 'h0c ; 
       mem_bank[150] = 'h24 ; mem_bank[151] = 'h0c ; mem_bank[152] = 'h24 ; mem_bank[153] = 'h0c ; mem_bank[154] = 'h24 ; mem_bank[155] = 'h0c ; mem_bank[156] = 'h24 ; mem_bank[157] = 'h8f ; mem_bank[158] = 'h8f ; mem_bank[159] = 'h8f ; 
       mem_bank[160] = 'h03 ; mem_bank[161] = 'h27 ; mem_bank[162] = 'h27 ; mem_bank[163] = 'haf ; mem_bank[164] = 'haf ; mem_bank[165] = 'h30 ; mem_bank[166] = 'h3c ; mem_bank[167] = 'h34 ; mem_bank[168] = 'ha0 ; mem_bank[169] = 'h3c ; 
       mem_bank[170] = 'h36 ; mem_bank[171] = 'h8e ; mem_bank[172] = 'h24 ; mem_bank[173] = 'h00 ; mem_bank[174] = 'hae ; mem_bank[175] = 'h8e ; mem_bank[176] = 'h24 ; mem_bank[177] = 'h00 ; mem_bank[178] = 'hae ; mem_bank[179] = 'h8e ; 
       mem_bank[180] = 'h24 ; mem_bank[181] = 'h00 ; mem_bank[182] = 'hae ; mem_bank[183] = 'h0c ; mem_bank[184] = 'h24 ; mem_bank[185] = 'h8e ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h34 ; mem_bank[188] = 'hae ; mem_bank[189] = 'h8f ; 
       mem_bank[190] = 'h8f ; mem_bank[191] = 'h03 ; mem_bank[192] = 'h27 ; mem_bank[193] = 'h27 ; mem_bank[194] = 'haf ; mem_bank[195] = 'haf ; mem_bank[196] = 'h30 ; mem_bank[197] = 'h3c ; mem_bank[198] = 'h34 ; mem_bank[199] = 'ha0 ; 
       mem_bank[200] = 'h3c ; mem_bank[201] = 'h36 ; mem_bank[202] = 'h8e ; mem_bank[203] = 'h00 ; mem_bank[204] = 'h34 ; mem_bank[205] = 'hae ; mem_bank[206] = 'h8e ; mem_bank[207] = 'h24 ; mem_bank[208] = 'h00 ; mem_bank[209] = 'hae ; 
       mem_bank[210] = 'h8e ; mem_bank[211] = 'h24 ; mem_bank[212] = 'h00 ; mem_bank[213] = 'hae ; mem_bank[214] = 'h0c ; mem_bank[215] = 'h24 ; mem_bank[216] = 'h8e ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h34 ; mem_bank[219] = 'hae ; 
       mem_bank[220] = 'h8f ; mem_bank[221] = 'h8f ; mem_bank[222] = 'h03 ; mem_bank[223] = 'h27 ; mem_bank[224] = 'h27 ; mem_bank[225] = 'haf ; mem_bank[226] = 'h30 ; mem_bank[227] = 'h14 ; mem_bank[228] = 'h30 ; mem_bank[229] = 'h10 ; 
       mem_bank[230] = 'h24 ; mem_bank[231] = 'h24 ; mem_bank[232] = 'h0c ; mem_bank[233] = 'h30 ; mem_bank[234] = 'h8f ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h03 ; mem_bank[237] = 'h27 ; mem_bank[238] = 'h27 ; mem_bank[239] = 'haf ; 
       mem_bank[240] = 'haf ; mem_bank[241] = 'h00 ; mem_bank[242] = 'h30 ; mem_bank[243] = 'h32 ; mem_bank[244] = 'h0c ; mem_bank[245] = 'h30 ; mem_bank[246] = 'h0c ; mem_bank[247] = 'h02 ; mem_bank[248] = 'h8f ; mem_bank[249] = 'h8f ; 
       mem_bank[250] = 'h03 ; mem_bank[251] = 'h27 ; mem_bank[252] = 'h27 ; mem_bank[253] = 'haf ; mem_bank[254] = 'haf ; mem_bank[255] = 'h00 ; mem_bank[256] = 'h30 ; mem_bank[257] = 'h0c ; mem_bank[258] = 'h30 ; mem_bank[259] = 'h92 ; 
       mem_bank[260] = 'h00 ; mem_bank[261] = 'h10 ; mem_bank[262] = 'h00 ; mem_bank[263] = 'h0c ; mem_bank[264] = 'h26 ; mem_bank[265] = 'h92 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h14 ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h8f ; 
       mem_bank[270] = 'h8f ; mem_bank[271] = 'h03 ; mem_bank[272] = 'h27 ; mem_bank[273] = 'h27 ; mem_bank[274] = 'haf ; mem_bank[275] = 'haf ; mem_bank[276] = 'haf ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h3c ; mem_bank[279] = 'h0c ; 
       mem_bank[280] = 'h24 ; mem_bank[281] = 'h24 ; mem_bank[282] = 'h3c ; mem_bank[283] = 'h34 ; mem_bank[284] = 'ha0 ; mem_bank[285] = 'h24 ; mem_bank[286] = 'h0c ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h14 ; mem_bank[289] = 'h00 ; 
       mem_bank[290] = 'h0c ; mem_bank[291] = 'h24 ; mem_bank[292] = 'h3c ; mem_bank[293] = 'h36 ; mem_bank[294] = 'h0c ; mem_bank[295] = 'h00 ; mem_bank[296] = 'ha2 ; mem_bank[297] = 'h30 ; mem_bank[298] = 'h26 ; mem_bank[299] = 'h10 ; 
       mem_bank[300] = 'ha2 ; mem_bank[301] = 'h27 ; mem_bank[302] = 'haf ; mem_bank[303] = 'h3c ; mem_bank[304] = 'h34 ; mem_bank[305] = 'h8c ; mem_bank[306] = 'h00 ; mem_bank[307] = 'h34 ; mem_bank[308] = 'hac ; mem_bank[309] = 'h3c ; 
       mem_bank[310] = 'h34 ; mem_bank[311] = 'h0c ; mem_bank[312] = 'hac ; mem_bank[313] = 'h8f ; mem_bank[314] = 'h00 ; mem_bank[315] = 'h03 ; mem_bank[316] = 'h27 ; mem_bank[317] = 'h3c ; mem_bank[318] = 'h34 ; mem_bank[319] = 'h8c ; 
       mem_bank[320] = 'h24 ; mem_bank[321] = 'h00 ; mem_bank[322] = 'hac ; mem_bank[323] = 'h8c ; mem_bank[324] = 'h24 ; mem_bank[325] = 'h00 ; mem_bank[326] = 'h03 ; mem_bank[327] = 'hac ; mem_bank[328] = 'h3c ; mem_bank[329] = 'h34 ; 
       mem_bank[330] = 'h8c ; mem_bank[331] = 'h00 ; mem_bank[332] = 'h34 ; mem_bank[333] = 'hac ; mem_bank[334] = 'h8c ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h34 ; mem_bank[337] = 'hac ; mem_bank[338] = 'h8c ; mem_bank[339] = 'h24 ; 
       mem_bank[340] = 'h00 ; mem_bank[341] = 'hac ; mem_bank[342] = 'h8c ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h00 ; mem_bank[345] = 'h03 ; mem_bank[346] = 'hac ; mem_bank[347] = 'h3c ; mem_bank[348] = 'h34 ; mem_bank[349] = 'h8c ; 
       mem_bank[350] = 'h03 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'h3c ; mem_bank[353] = 'h34 ; mem_bank[354] = 'h8c ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h38 ; mem_bank[357] = 'h03 ; mem_bank[358] = 'h30 ; mem_bank[359] = 'h3c ; 
       mem_bank[360] = 'h34 ; mem_bank[361] = 'h8c ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h00 ; mem_bank[364] = 'h38 ; mem_bank[365] = 'h03 ; mem_bank[366] = 'h30 ; mem_bank[367] = 'h3c ; mem_bank[368] = 'h34 ; mem_bank[369] = 'h8c ; 
       mem_bank[370] = 'h24 ; mem_bank[371] = 'h00 ; mem_bank[372] = 'h03 ; mem_bank[373] = 'hac ; mem_bank[374] = 'h3c ; mem_bank[375] = 'h34 ; mem_bank[376] = 'h8c ; mem_bank[377] = 'h00 ; mem_bank[378] = 'h34 ; mem_bank[379] = 'h03 ; 
       mem_bank[380] = 'hac ; mem_bank[381] = 'h3c ; mem_bank[382] = 'h34 ; mem_bank[383] = 'h8c ; mem_bank[384] = 'h24 ; mem_bank[385] = 'h00 ; mem_bank[386] = 'h03 ; mem_bank[387] = 'hac ; mem_bank[388] = 'h3c ; mem_bank[389] = 'h34 ; 
       mem_bank[390] = 'h8c ; mem_bank[391] = 'h00 ; mem_bank[392] = 'h34 ; mem_bank[393] = 'h03 ; mem_bank[394] = 'hac ; mem_bank[395] = 'h30 ; mem_bank[396] = 'h3c ; mem_bank[397] = 'h34 ; mem_bank[398] = 'h03 ; mem_bank[399] = 'ha0 ; 
       mem_bank[400] = 'h27 ; mem_bank[401] = 'haf ; mem_bank[402] = 'haf ; mem_bank[403] = 'haf ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h02 ; mem_bank[406] = 'h26 ; mem_bank[407] = 'h0c ; mem_bank[408] = 'h32 ; mem_bank[409] = 'h32 ; 
       mem_bank[410] = 'h12 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h0c ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h10 ; mem_bank[415] = 'h32 ; mem_bank[416] = 'h0c ; mem_bank[417] = 'h00 ; mem_bank[418] = 'h32 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h10 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h0c ; mem_bank[423] = 'h00 ; mem_bank[424] = 'h10 ; mem_bank[425] = 'h02 ; mem_bank[426] = 'h0c ; mem_bank[427] = 'h00 ; mem_bank[428] = 'h10 ; mem_bank[429] = 'h02 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h54 ; mem_bank[437] = 'h20 ; mem_bank[438] = 'h4d ; mem_bank[439] = 'h37 ; 
       mem_bank[440] = 'h42 ; mem_bank[441] = 'h4c ; mem_bank[442] = 'h45 ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h00 ;     
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
    assign qa =(r_rdaddress_a<444)?mem_bank[r_rdaddress_a]:0;
    assign qb =(r_rdaddress_b<444)?mem_bank[r_rdaddress_b]:0;
endmodule



