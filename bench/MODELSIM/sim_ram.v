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
       mem_bank[0] = 'h00 ; mem_bank[1] = 'h80 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h90 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h94 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h90 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h2a ; 
       mem_bank[10] = 'hfd ; mem_bank[11] = 'h04 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h9f ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h10 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'hc4 ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h09 ; mem_bank[29] = 'hff ; 
       mem_bank[30] = 'hff ; mem_bank[31] = 'h0d ; mem_bank[32] = 'hff ; mem_bank[33] = 'hff ; mem_bank[34] = 'hff ; mem_bank[35] = 'hff ; mem_bank[36] = 'hfa ; mem_bank[37] = 'h01 ; mem_bank[38] = 'h08 ; mem_bank[39] = 'h00 ; 
       mem_bank[40] = 'h40 ; mem_bank[41] = 'h23 ; mem_bank[42] = 'h80 ; mem_bank[43] = 'h21 ; mem_bank[44] = 'hc0 ; mem_bank[45] = 'hff ; mem_bank[46] = 'hff ; mem_bank[47] = 'h09 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h25 ; 
       mem_bank[50] = 'h0b ; mem_bank[51] = 'hff ; mem_bank[52] = 'hff ; mem_bank[53] = 'hff ; mem_bank[54] = 'hff ; mem_bank[55] = 'hfa ; mem_bank[56] = 'h01 ; mem_bank[57] = 'h08 ; mem_bank[58] = 'h00 ; mem_bank[59] = 'hff ; 
       mem_bank[60] = 'h00 ; mem_bank[61] = 'h18 ; mem_bank[62] = 'h00 ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h04 ; mem_bank[65] = 'h08 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h18 ; mem_bank[69] = 'h00 ; 
       mem_bank[70] = 'h00 ; mem_bank[71] = 'h04 ; mem_bank[72] = 'hfc ; mem_bank[73] = 'h00 ; mem_bank[74] = 'h28 ; mem_bank[75] = 'h08 ; mem_bank[76] = 'h00 ; mem_bank[77] = 'h00 ; mem_bank[78] = 'h18 ; mem_bank[79] = 'h00 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h08 ; mem_bank[82] = 'h08 ; mem_bank[83] = 'h00 ; mem_bank[84] = 'h00 ; mem_bank[85] = 'h18 ; mem_bank[86] = 'h00 ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h08 ; mem_bank[89] = 'hfc ; 
       mem_bank[90] = 'h00 ; mem_bank[91] = 'h28 ; mem_bank[92] = 'h00 ; mem_bank[93] = 'h00 ; mem_bank[94] = 'hff ; mem_bank[95] = 'h00 ; mem_bank[96] = 'h14 ; mem_bank[97] = 'h00 ; mem_bank[98] = 'h00 ; mem_bank[99] = 'h02 ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'h00 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h02 ; mem_bank[104] = 'h00 ; mem_bank[105] = 'h00 ; mem_bank[106] = 'hfd ; mem_bank[107] = 'h24 ; mem_bank[108] = 'h08 ; mem_bank[109] = 'h00 ; 
       mem_bank[110] = 'h00 ; mem_bank[111] = 'h18 ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'hc2 ; mem_bank[115] = 'h08 ; mem_bank[116] = 'h01 ; mem_bank[117] = 'he0 ; mem_bank[118] = 'h18 ; mem_bank[119] = 'h14 ; 
       mem_bank[120] = 'h10 ; mem_bank[121] = 'h25 ; mem_bank[122] = 'h0a ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h00 ; mem_bank[125] = 'h0a ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h03 ; mem_bank[128] = 'h00 ; mem_bank[129] = 'h3b ; 
       mem_bank[130] = 'h0d ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h3b ; mem_bank[133] = 'h01 ; mem_bank[134] = 'hf4 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h18 ; mem_bank[137] = 'h14 ; mem_bank[138] = 'h10 ; mem_bank[139] = 'h08 ; 
       mem_bank[140] = 'h20 ; mem_bank[141] = 'he0 ; mem_bank[142] = 'h18 ; mem_bank[143] = 'h14 ; mem_bank[144] = 'h10 ; mem_bank[145] = 'haf ; mem_bank[146] = 'h01 ; mem_bank[147] = 'h02 ; mem_bank[148] = 'hff ; mem_bank[149] = 'haf ; 
       mem_bank[150] = 'h38 ; mem_bank[151] = 'h07 ; mem_bank[152] = 'h1c ; mem_bank[153] = 'h20 ; mem_bank[154] = 'hff ; mem_bank[155] = 'hff ; mem_bank[156] = 'hf8 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'haf ; mem_bank[159] = 'h0c ; 
       mem_bank[160] = 'h1c ; mem_bank[161] = 'he8 ; mem_bank[162] = 'haf ; mem_bank[163] = 'h80 ; mem_bank[164] = 'h1c ; mem_bank[165] = 'he8 ; mem_bank[166] = 'haf ; mem_bank[167] = 'h01 ; mem_bank[168] = 'h1c ; mem_bank[169] = 'he8 ; 
       mem_bank[170] = 'h18 ; mem_bank[171] = 'h14 ; mem_bank[172] = 'h10 ; mem_bank[173] = 'h08 ; mem_bank[174] = 'h20 ; mem_bank[175] = 'he8 ; mem_bank[176] = 'h14 ; mem_bank[177] = 'h10 ; mem_bank[178] = 'hff ; mem_bank[179] = 'h00 ; 
       mem_bank[180] = 'h24 ; mem_bank[181] = 'h00 ; mem_bank[182] = 'h00 ; mem_bank[183] = 'h14 ; mem_bank[184] = 'h00 ; mem_bank[185] = 'hfb ; mem_bank[186] = 'h24 ; mem_bank[187] = 'h00 ; mem_bank[188] = 'h00 ; mem_bank[189] = 'hf7 ; 
       mem_bank[190] = 'h24 ; mem_bank[191] = 'h00 ; mem_bank[192] = 'h00 ; mem_bank[193] = 'hef ; mem_bank[194] = 'h24 ; mem_bank[195] = 'h00 ; mem_bank[196] = 'h1c ; mem_bank[197] = 'he8 ; mem_bank[198] = 'h00 ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h10 ; mem_bank[201] = 'h00 ; mem_bank[202] = 'h14 ; mem_bank[203] = 'h10 ; mem_bank[204] = 'h08 ; mem_bank[205] = 'h18 ; mem_bank[206] = 'he8 ; mem_bank[207] = 'h14 ; mem_bank[208] = 'h10 ; mem_bank[209] = 'hff ; 
       mem_bank[210] = 'h00 ; mem_bank[211] = 'h24 ; mem_bank[212] = 'h00 ; mem_bank[213] = 'h00 ; mem_bank[214] = 'h14 ; mem_bank[215] = 'h00 ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h04 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h00 ; 
       mem_bank[220] = 'hf7 ; mem_bank[221] = 'h24 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'hef ; mem_bank[225] = 'h24 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h1c ; mem_bank[228] = 'he8 ; mem_bank[229] = 'h00 ; 
       mem_bank[230] = 'h00 ; mem_bank[231] = 'h10 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h14 ; mem_bank[234] = 'h10 ; mem_bank[235] = 'h08 ; mem_bank[236] = 'h18 ; mem_bank[237] = 'he8 ; mem_bank[238] = 'h10 ; mem_bank[239] = 'hff ; 
       mem_bank[240] = 'h03 ; mem_bank[241] = 'hff ; mem_bank[242] = 'h02 ; mem_bank[243] = 'h80 ; mem_bank[244] = 'hc0 ; mem_bank[245] = 'haf ; mem_bank[246] = 'hff ; mem_bank[247] = 'h10 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h08 ; 
       mem_bank[250] = 'h18 ; mem_bank[251] = 'he8 ; mem_bank[252] = 'h14 ; mem_bank[253] = 'h10 ; mem_bank[254] = 'h25 ; mem_bank[255] = 'hff ; mem_bank[256] = 'hff ; mem_bank[257] = 'hed ; mem_bank[258] = 'hff ; mem_bank[259] = 'hce ; 
       mem_bank[260] = 'h25 ; mem_bank[261] = 'h14 ; mem_bank[262] = 'h10 ; mem_bank[263] = 'h08 ; mem_bank[264] = 'h18 ; mem_bank[265] = 'he8 ; mem_bank[266] = 'h14 ; mem_bank[267] = 'h10 ; mem_bank[268] = 'h25 ; mem_bank[269] = 'hff ; 
       mem_bank[270] = 'hed ; mem_bank[271] = 'hff ; mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h07 ; mem_bank[275] = 'h25 ; mem_bank[276] = 'hce ; mem_bank[277] = 'h01 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'hfb ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h14 ; mem_bank[283] = 'h10 ; mem_bank[284] = 'h08 ; mem_bank[285] = 'h18 ; mem_bank[286] = 'he0 ; mem_bank[287] = 'h18 ; mem_bank[288] = 'h14 ; mem_bank[289] = 'h10 ; 
       mem_bank[290] = 'h25 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h75 ; mem_bank[293] = 'h74 ; mem_bank[294] = 'hcc ; mem_bank[295] = 'h00 ; mem_bank[296] = 'h1c ; mem_bank[297] = 'h00 ; mem_bank[298] = 'h21 ; mem_bank[299] = 'h4d ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'hfd ; mem_bank[302] = 'h00 ; mem_bank[303] = 'h3b ; mem_bank[304] = 'h4f ; mem_bank[305] = 'h00 ; mem_bank[306] = 'h1c ; mem_bank[307] = 'h4d ; mem_bank[308] = 'h00 ; mem_bank[309] = 'h00 ; 
       mem_bank[310] = 'hff ; mem_bank[311] = 'h01 ; mem_bank[312] = 'hfa ; mem_bank[313] = 'h00 ; mem_bank[314] = 'he8 ; mem_bank[315] = 'h10 ; mem_bank[316] = 'h00 ; mem_bank[317] = 'h14 ; mem_bank[318] = 'h00 ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'h00 ; mem_bank[321] = 'h00 ; mem_bank[322] = 'h00 ; mem_bank[323] = 'h34 ; mem_bank[324] = 'h55 ; mem_bank[325] = 'h00 ; mem_bank[326] = 'h10 ; mem_bank[327] = 'h00 ; mem_bank[328] = 'h08 ; mem_bank[329] = 'h18 ; 
       mem_bank[330] = 'h00 ; mem_bank[331] = 'h14 ; mem_bank[332] = 'h00 ; mem_bank[333] = 'hff ; mem_bank[334] = 'h24 ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h00 ; mem_bank[337] = 'h7f ; mem_bank[338] = 'h24 ; mem_bank[339] = 'h08 ; 
       mem_bank[340] = 'h00 ; mem_bank[341] = 'h00 ; mem_bank[342] = 'h14 ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h00 ; mem_bank[345] = 'h80 ; mem_bank[346] = 'h00 ; mem_bank[347] = 'h00 ; mem_bank[348] = 'h00 ; mem_bank[349] = 'h80 ; 
       mem_bank[350] = 'h00 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'h7f ; mem_bank[353] = 'h24 ; mem_bank[354] = 'h00 ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h00 ; mem_bank[357] = 'h24 ; mem_bank[358] = 'h08 ; mem_bank[359] = 'h00 ; 
       mem_bank[360] = 'h00 ; mem_bank[361] = 'h34 ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h08 ; mem_bank[364] = 'h00 ; mem_bank[365] = 'h00 ; mem_bank[366] = 'h18 ; mem_bank[367] = 'h00 ; mem_bank[368] = 'h00 ; mem_bank[369] = 'h01 ; 
       mem_bank[370] = 'h08 ; mem_bank[371] = 'h01 ; mem_bank[372] = 'h00 ; mem_bank[373] = 'h18 ; mem_bank[374] = 'h00 ; mem_bank[375] = 'h00 ; mem_bank[376] = 'h42 ; mem_bank[377] = 'h01 ; mem_bank[378] = 'h08 ; mem_bank[379] = 'h01 ; 
       mem_bank[380] = 'h00 ; mem_bank[381] = 'h14 ; mem_bank[382] = 'h00 ; mem_bank[383] = 'hdf ; mem_bank[384] = 'h24 ; mem_bank[385] = 'h08 ; mem_bank[386] = 'h00 ; mem_bank[387] = 'h00 ; mem_bank[388] = 'h14 ; mem_bank[389] = 'h00 ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h20 ; mem_bank[392] = 'h08 ; mem_bank[393] = 'h00 ; mem_bank[394] = 'h00 ; mem_bank[395] = 'h14 ; mem_bank[396] = 'h00 ; mem_bank[397] = 'hbf ; mem_bank[398] = 'h24 ; mem_bank[399] = 'h08 ; 
       mem_bank[400] = 'h00 ; mem_bank[401] = 'h00 ; mem_bank[402] = 'h14 ; mem_bank[403] = 'h00 ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h40 ; mem_bank[406] = 'h08 ; mem_bank[407] = 'h00 ; mem_bank[408] = 'hff ; mem_bank[409] = 'h00 ; 
       mem_bank[410] = 'h1c ; mem_bank[411] = 'h08 ; mem_bank[412] = 'h00 ; mem_bank[413] = 'h08 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'he8 ; mem_bank[416] = 'h10 ; mem_bank[417] = 'h5c ; mem_bank[418] = 'h00 ; mem_bank[419] = 'h28 ; 
       mem_bank[420] = 'h00 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h2c ; mem_bank[423] = 'h00 ; mem_bank[424] = 'h00 ; mem_bank[425] = 'h30 ; mem_bank[426] = 'h83 ; mem_bank[427] = 'h00 ; mem_bank[428] = 'h00 ; mem_bank[429] = 'h14 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h01 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h25 ; mem_bank[437] = 'h00 ; mem_bank[438] = 'h00 ; mem_bank[439] = 'h00 ; 
       mem_bank[440] = 'h25 ; mem_bank[441] = 'h00 ; mem_bank[442] = 'h00 ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h25 ; mem_bank[445] = 'h00 ; mem_bank[446] = 'h8a ; mem_bank[447] = 'h00 ; mem_bank[448] = 'h91 ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'hfb ; mem_bank[451] = 'h00 ; mem_bank[452] = 'he0 ; mem_bank[453] = 'h18 ; mem_bank[454] = 'h14 ; mem_bank[455] = 'h10 ; mem_bank[456] = 'h63 ; mem_bank[457] = 'hff ; mem_bank[458] = 'h7c ; mem_bank[459] = 'hff ; 
       mem_bank[460] = 'h83 ; mem_bank[461] = 'h00 ; mem_bank[462] = 'hfb ; mem_bank[463] = 'h00 ; mem_bank[464] = 'h14 ; mem_bank[465] = 'h00 ; mem_bank[466] = 'h18 ; mem_bank[467] = 'h14 ; mem_bank[468] = 'h10 ; mem_bank[469] = 'h08 ; 
       mem_bank[470] = 'h20 ; mem_bank[471] = 'h00 ; mem_bank[472] = 'h00 ; mem_bank[473] = 'h00 ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h00 ; mem_bank[477] = 'h73 ; mem_bank[478] = 'h20 ; mem_bank[479] = 'h53 ; 
       mem_bank[480] = 'h20 ; mem_bank[481] = 'h54 ; mem_bank[482] = 'h44 ; mem_bank[483] = 'h00 ; mem_bank[484] = 'h00 ;     
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
    assign qa =(r_rdaddress_a>484)?0:mem_bank[r_rdaddress_a];
    assign qb =(r_rdaddress_b>484)?0:mem_bank[r_rdaddress_b];
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
       mem_bank[0] = 'h00 ; mem_bank[1] = 'h87 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h07 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h07 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h09 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h18 ; 
       mem_bank[10] = 'hff ; mem_bank[11] = 'h00 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h01 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h00 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'h01 ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h00 ; mem_bank[29] = 'hff ; 
       mem_bank[30] = 'hff ; mem_bank[31] = 'h00 ; mem_bank[32] = 'hff ; mem_bank[33] = 'hff ; mem_bank[34] = 'hff ; mem_bank[35] = 'hff ; mem_bank[36] = 'hff ; mem_bank[37] = 'h00 ; mem_bank[38] = 'h00 ; mem_bank[39] = 'h00 ; 
       mem_bank[40] = 'h11 ; mem_bank[41] = 'h10 ; mem_bank[42] = 'h10 ; mem_bank[43] = 'h10 ; mem_bank[44] = 'h18 ; mem_bank[45] = 'hff ; mem_bank[46] = 'hff ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h20 ; 
       mem_bank[50] = 'h00 ; mem_bank[51] = 'hff ; mem_bank[52] = 'hff ; mem_bank[53] = 'hff ; mem_bank[54] = 'hff ; mem_bank[55] = 'hff ; mem_bank[56] = 'h00 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h00 ; mem_bank[59] = 'h00 ; 
       mem_bank[60] = 'h80 ; mem_bank[61] = 'h00 ; mem_bank[62] = 'h00 ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h00 ; mem_bank[65] = 'h00 ; mem_bank[66] = 'h80 ; mem_bank[67] = 'h80 ; mem_bank[68] = 'h00 ; mem_bank[69] = 'h00 ; 
       mem_bank[70] = 'h00 ; mem_bank[71] = 'h00 ; mem_bank[72] = 'hff ; mem_bank[73] = 'h80 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h00 ; mem_bank[76] = 'h00 ; mem_bank[77] = 'h80 ; mem_bank[78] = 'h00 ; mem_bank[79] = 'h00 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h00 ; mem_bank[82] = 'h00 ; mem_bank[83] = 'h80 ; mem_bank[84] = 'h80 ; mem_bank[85] = 'h00 ; mem_bank[86] = 'h00 ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h00 ; mem_bank[89] = 'hff ; 
       mem_bank[90] = 'h80 ; mem_bank[91] = 'h00 ; mem_bank[92] = 'h00 ; mem_bank[93] = 'h00 ; mem_bank[94] = 'h00 ; mem_bank[95] = 'h80 ; mem_bank[96] = 'h00 ; mem_bank[97] = 'h00 ; mem_bank[98] = 'h00 ; mem_bank[99] = 'h00 ; 
       mem_bank[100] = 'h00 ; mem_bank[101] = 'h00 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h00 ; mem_bank[104] = 'h00 ; mem_bank[105] = 'h00 ; mem_bank[106] = 'hff ; mem_bank[107] = 'h18 ; mem_bank[108] = 'h00 ; mem_bank[109] = 'h00 ; 
       mem_bank[110] = 'h80 ; mem_bank[111] = 'h00 ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h10 ; mem_bank[115] = 'h00 ; mem_bank[116] = 'h00 ; mem_bank[117] = 'hff ; mem_bank[118] = 'h00 ; mem_bank[119] = 'h00 ; 
       mem_bank[120] = 'h00 ; mem_bank[121] = 'h80 ; mem_bank[122] = 'h00 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h00 ; mem_bank[125] = 'h00 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h00 ; mem_bank[128] = 'h00 ; mem_bank[129] = 'h00 ; 
       mem_bank[130] = 'h00 ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h00 ; mem_bank[133] = 'h00 ; mem_bank[134] = 'hff ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h00 ; mem_bank[137] = 'h00 ; mem_bank[138] = 'h00 ; mem_bank[139] = 'h00 ; 
       mem_bank[140] = 'h00 ; mem_bank[141] = 'hff ; mem_bank[142] = 'h00 ; mem_bank[143] = 'h00 ; mem_bank[144] = 'h00 ; mem_bank[145] = 'h00 ; mem_bank[146] = 'h00 ; mem_bank[147] = 'h00 ; mem_bank[148] = 'h00 ; mem_bank[149] = 'h00 ; 
       mem_bank[150] = 'h00 ; mem_bank[151] = 'h00 ; mem_bank[152] = 'h00 ; mem_bank[153] = 'ha1 ; mem_bank[154] = 'hff ; mem_bank[155] = 'h00 ; mem_bank[156] = 'hff ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h00 ; mem_bank[159] = 'h00 ; 
       mem_bank[160] = 'h00 ; mem_bank[161] = 'h03 ; mem_bank[162] = 'h00 ; mem_bank[163] = 'h00 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h03 ; mem_bank[166] = 'h00 ; mem_bank[167] = 'h00 ; mem_bank[168] = 'h00 ; mem_bank[169] = 'h03 ; 
       mem_bank[170] = 'h00 ; mem_bank[171] = 'h00 ; mem_bank[172] = 'h00 ; mem_bank[173] = 'h00 ; mem_bank[174] = 'h00 ; mem_bank[175] = 'hff ; mem_bank[176] = 'h00 ; mem_bank[177] = 'h00 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h80 ; 
       mem_bank[180] = 'h00 ; mem_bank[181] = 'h00 ; mem_bank[182] = 'h80 ; mem_bank[183] = 'h00 ; mem_bank[184] = 'h00 ; mem_bank[185] = 'hff ; mem_bank[186] = 'h10 ; mem_bank[187] = 'h00 ; mem_bank[188] = 'h00 ; mem_bank[189] = 'hff ; 
       mem_bank[190] = 'h10 ; mem_bank[191] = 'h00 ; mem_bank[192] = 'h00 ; mem_bank[193] = 'hff ; mem_bank[194] = 'h10 ; mem_bank[195] = 'h00 ; mem_bank[196] = 'h00 ; mem_bank[197] = 'h03 ; mem_bank[198] = 'h00 ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h00 ; mem_bank[201] = 'h00 ; mem_bank[202] = 'h00 ; mem_bank[203] = 'h00 ; mem_bank[204] = 'h00 ; mem_bank[205] = 'h00 ; mem_bank[206] = 'hff ; mem_bank[207] = 'h00 ; mem_bank[208] = 'h00 ; mem_bank[209] = 'h00 ; 
       mem_bank[210] = 'h80 ; mem_bank[211] = 'h00 ; mem_bank[212] = 'h00 ; mem_bank[213] = 'h80 ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h00 ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h00 ; 
       mem_bank[220] = 'hff ; mem_bank[221] = 'h10 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'hff ; mem_bank[225] = 'h10 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h03 ; mem_bank[229] = 'h00 ; 
       mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h00 ; mem_bank[237] = 'hff ; mem_bank[238] = 'h00 ; mem_bank[239] = 'h00 ; 
       mem_bank[240] = 'h00 ; mem_bank[241] = 'h00 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ; 
       mem_bank[250] = 'h00 ; mem_bank[251] = 'hff ; mem_bank[252] = 'h00 ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h80 ; mem_bank[255] = 'h00 ; mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ; 
       mem_bank[260] = 'h20 ; mem_bank[261] = 'h00 ; mem_bank[262] = 'h00 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'hff ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h00 ; mem_bank[268] = 'h80 ; mem_bank[269] = 'h00 ; 
       mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ; mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h20 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'hff ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h00 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ; mem_bank[286] = 'hff ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h00 ; mem_bank[289] = 'h00 ; 
       mem_bank[290] = 'h80 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h07 ; mem_bank[294] = 'h00 ; mem_bank[295] = 'h80 ; mem_bank[296] = 'h00 ; mem_bank[297] = 'h00 ; mem_bank[298] = 'h00 ; mem_bank[299] = 'h00 ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'hff ; mem_bank[302] = 'h00 ; mem_bank[303] = 'h00 ; mem_bank[304] = 'h00 ; mem_bank[305] = 'h80 ; mem_bank[306] = 'h00 ; mem_bank[307] = 'h00 ; mem_bank[308] = 'h00 ; mem_bank[309] = 'h00 ; 
       mem_bank[310] = 'h00 ; mem_bank[311] = 'h00 ; mem_bank[312] = 'hff ; mem_bank[313] = 'h00 ; mem_bank[314] = 'hff ; mem_bank[315] = 'h00 ; mem_bank[316] = 'h80 ; mem_bank[317] = 'h00 ; mem_bank[318] = 'h00 ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'h01 ; mem_bank[321] = 'h00 ; mem_bank[322] = 'h80 ; mem_bank[323] = 'h00 ; mem_bank[324] = 'h01 ; mem_bank[325] = 'h00 ; mem_bank[326] = 'h00 ; mem_bank[327] = 'h00 ; mem_bank[328] = 'h00 ; mem_bank[329] = 'h00 ; 
       mem_bank[330] = 'h80 ; mem_bank[331] = 'h00 ; mem_bank[332] = 'h00 ; mem_bank[333] = 'hfe ; mem_bank[334] = 'h10 ; mem_bank[335] = 'h00 ; mem_bank[336] = 'h00 ; mem_bank[337] = 'hff ; mem_bank[338] = 'h10 ; mem_bank[339] = 'h00 ; 
       mem_bank[340] = 'h00 ; mem_bank[341] = 'h80 ; mem_bank[342] = 'h00 ; mem_bank[343] = 'h00 ; mem_bank[344] = 'h00 ; mem_bank[345] = 'h00 ; mem_bank[346] = 'h00 ; mem_bank[347] = 'h00 ; mem_bank[348] = 'h00 ; mem_bank[349] = 'h00 ; 
       mem_bank[350] = 'h00 ; mem_bank[351] = 'h00 ; mem_bank[352] = 'hff ; mem_bank[353] = 'h10 ; mem_bank[354] = 'h00 ; mem_bank[355] = 'h00 ; mem_bank[356] = 'h00 ; mem_bank[357] = 'h10 ; mem_bank[358] = 'h00 ; mem_bank[359] = 'h00 ; 
       mem_bank[360] = 'h80 ; mem_bank[361] = 'h00 ; mem_bank[362] = 'h00 ; mem_bank[363] = 'h00 ; mem_bank[364] = 'h00 ; mem_bank[365] = 'h80 ; mem_bank[366] = 'h00 ; mem_bank[367] = 'h00 ; mem_bank[368] = 'h00 ; mem_bank[369] = 'h00 ; 
       mem_bank[370] = 'h00 ; mem_bank[371] = 'h00 ; mem_bank[372] = 'h80 ; mem_bank[373] = 'h00 ; mem_bank[374] = 'h00 ; mem_bank[375] = 'h00 ; mem_bank[376] = 'h10 ; mem_bank[377] = 'h00 ; mem_bank[378] = 'h00 ; mem_bank[379] = 'h00 ; 
       mem_bank[380] = 'h80 ; mem_bank[381] = 'h00 ; mem_bank[382] = 'h00 ; mem_bank[383] = 'hff ; mem_bank[384] = 'h18 ; mem_bank[385] = 'h00 ; mem_bank[386] = 'h00 ; mem_bank[387] = 'h80 ; mem_bank[388] = 'h00 ; mem_bank[389] = 'h00 ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h00 ; mem_bank[392] = 'h00 ; mem_bank[393] = 'h00 ; mem_bank[394] = 'h80 ; mem_bank[395] = 'h00 ; mem_bank[396] = 'h00 ; mem_bank[397] = 'hff ; mem_bank[398] = 'h18 ; mem_bank[399] = 'h00 ; 
       mem_bank[400] = 'h00 ; mem_bank[401] = 'h80 ; mem_bank[402] = 'h00 ; mem_bank[403] = 'h00 ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h00 ; mem_bank[406] = 'h00 ; mem_bank[407] = 'h00 ; mem_bank[408] = 'h00 ; mem_bank[409] = 'h80 ; 
       mem_bank[410] = 'h00 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h00 ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'hff ; mem_bank[416] = 'h00 ; mem_bank[417] = 'h00 ; mem_bank[418] = 'h80 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h00 ; mem_bank[421] = 'h80 ; mem_bank[422] = 'h00 ; mem_bank[423] = 'h00 ; mem_bank[424] = 'h80 ; mem_bank[425] = 'h00 ; mem_bank[426] = 'h01 ; mem_bank[427] = 'h00 ; mem_bank[428] = 'h80 ; mem_bank[429] = 'h00 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h00 ; mem_bank[435] = 'h80 ; mem_bank[436] = 'h10 ; mem_bank[437] = 'h00 ; mem_bank[438] = 'h00 ; mem_bank[439] = 'h20 ; 
       mem_bank[440] = 'h10 ; mem_bank[441] = 'h00 ; mem_bank[442] = 'h00 ; mem_bank[443] = 'h40 ; mem_bank[444] = 'h10 ; mem_bank[445] = 'h00 ; mem_bank[446] = 'h01 ; mem_bank[447] = 'h00 ; mem_bank[448] = 'h01 ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'hff ; mem_bank[451] = 'h00 ; mem_bank[452] = 'hff ; mem_bank[453] = 'h00 ; mem_bank[454] = 'h00 ; mem_bank[455] = 'h00 ; mem_bank[456] = 'h00 ; mem_bank[457] = 'hff ; mem_bank[458] = 'h01 ; mem_bank[459] = 'hff ; 
       mem_bank[460] = 'h01 ; mem_bank[461] = 'h00 ; mem_bank[462] = 'hff ; mem_bank[463] = 'h80 ; mem_bank[464] = 'h00 ; mem_bank[465] = 'h00 ; mem_bank[466] = 'h00 ; mem_bank[467] = 'h00 ; mem_bank[468] = 'h00 ; mem_bank[469] = 'h00 ; 
       mem_bank[470] = 'h00 ; mem_bank[471] = 'h00 ; mem_bank[472] = 'h00 ; mem_bank[473] = 'h00 ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h00 ; mem_bank[477] = 'h69 ; mem_bank[478] = 'h73 ; mem_bank[479] = 'h50 ; 
       mem_bank[480] = 'h39 ; mem_bank[481] = 'h4f ; mem_bank[482] = 'h41 ; mem_bank[483] = 'h0a ; mem_bank[484] = 'h00 ;     
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
    assign qa =(r_rdaddress_a>484)?0:mem_bank[r_rdaddress_a];
    assign qb =(r_rdaddress_b>484)?0:mem_bank[r_rdaddress_b];
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
       mem_bank[10] = 'h60 ; mem_bank[11] = 'h84 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h00 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'h00 ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h80 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h80 ; mem_bank[29] = 'h83 ; 
       mem_bank[30] = 'h04 ; mem_bank[31] = 'h02 ; mem_bank[32] = 'h42 ; mem_bank[33] = 'h44 ; mem_bank[34] = 'h42 ; mem_bank[35] = 'h63 ; mem_bank[36] = 'h64 ; mem_bank[37] = 'h42 ; mem_bank[38] = 'he0 ; mem_bank[39] = 'h00 ; 
       mem_bank[40] = 'h04 ; mem_bank[41] = 'h44 ; mem_bank[42] = 'h02 ; mem_bank[43] = 'h44 ; mem_bank[44] = 'h02 ; mem_bank[45] = 'h63 ; mem_bank[46] = 'h02 ; mem_bank[47] = 'h62 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h40 ; 
       mem_bank[50] = 'h02 ; mem_bank[51] = 'h42 ; mem_bank[52] = 'h44 ; mem_bank[53] = 'h42 ; mem_bank[54] = 'h63 ; mem_bank[55] = 'h64 ; mem_bank[56] = 'h42 ; mem_bank[57] = 'he0 ; mem_bank[58] = 'h00 ; mem_bank[59] = 'h84 ; 
       mem_bank[60] = 'h02 ; mem_bank[61] = 'h42 ; mem_bank[62] = 'h42 ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h42 ; mem_bank[65] = 'h40 ; mem_bank[66] = 'h02 ; mem_bank[67] = 'h03 ; mem_bank[68] = 'h63 ; mem_bank[69] = 'h62 ; 
       mem_bank[70] = 'h00 ; mem_bank[71] = 'h42 ; mem_bank[72] = 'h40 ; mem_bank[73] = 'h02 ; mem_bank[74] = 'h42 ; mem_bank[75] = 'he0 ; mem_bank[76] = 'h44 ; mem_bank[77] = 'h02 ; mem_bank[78] = 'h42 ; mem_bank[79] = 'h42 ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h42 ; mem_bank[82] = 'h40 ; mem_bank[83] = 'h02 ; mem_bank[84] = 'h03 ; mem_bank[85] = 'h63 ; mem_bank[86] = 'h62 ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h42 ; mem_bank[89] = 'h40 ; 
       mem_bank[90] = 'h02 ; mem_bank[91] = 'h42 ; mem_bank[92] = 'h42 ; mem_bank[93] = 'h00 ; mem_bank[94] = 'h42 ; mem_bank[95] = 'h05 ; mem_bank[96] = 'ha5 ; mem_bank[97] = 'ha3 ; mem_bank[98] = 'h00 ; mem_bank[99] = 'h63 ; 
       mem_bank[100] = 'ha3 ; mem_bank[101] = 'ha3 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h63 ; mem_bank[104] = 'ha3 ; mem_bank[105] = 'ha3 ; mem_bank[106] = 'h04 ; mem_bank[107] = 'h64 ; mem_bank[108] = 'he0 ; mem_bank[109] = 'ha3 ; 
       mem_bank[110] = 'h02 ; mem_bank[111] = 'h42 ; mem_bank[112] = 'h42 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h02 ; mem_bank[115] = 'he0 ; mem_bank[116] = 'h42 ; mem_bank[117] = 'hbd ; mem_bank[118] = 'hbf ; mem_bank[119] = 'hb1 ; 
       mem_bank[120] = 'hb0 ; mem_bank[121] = 'h80 ; mem_bank[122] = 'h11 ; mem_bank[123] = 'h02 ; mem_bank[124] = 'h00 ; mem_bank[125] = 'h40 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h51 ; mem_bank[128] = 'h00 ; mem_bank[129] = 'h00 ; 
       mem_bank[130] = 'h04 ; mem_bank[131] = 'h04 ; mem_bank[132] = 'h00 ; mem_bank[133] = 'h10 ; mem_bank[134] = 'h00 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'hbf ; mem_bank[137] = 'hb1 ; mem_bank[138] = 'hb0 ; mem_bank[139] = 'he0 ; 
       mem_bank[140] = 'hbd ; mem_bank[141] = 'hbd ; mem_bank[142] = 'hbf ; mem_bank[143] = 'hb1 ; mem_bank[144] = 'hb0 ; mem_bank[145] = 'h00 ; mem_bank[146] = 'h04 ; mem_bank[147] = 'h10 ; mem_bank[148] = 'h11 ; mem_bank[149] = 'h00 ; 
       mem_bank[150] = 'h04 ; mem_bank[151] = 'h04 ; mem_bank[152] = 'h00 ; mem_bank[153] = 'h84 ; mem_bank[154] = 'h02 ; mem_bank[155] = 'h50 ; mem_bank[156] = 'h11 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h00 ; mem_bank[159] = 'h04 ; 
       mem_bank[160] = 'h00 ; mem_bank[161] = 'h04 ; mem_bank[162] = 'h00 ; mem_bank[163] = 'h04 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h04 ; mem_bank[166] = 'h00 ; mem_bank[167] = 'h04 ; mem_bank[168] = 'h00 ; mem_bank[169] = 'h04 ; 
       mem_bank[170] = 'hbf ; mem_bank[171] = 'hb1 ; mem_bank[172] = 'hb0 ; mem_bank[173] = 'he0 ; mem_bank[174] = 'hbd ; mem_bank[175] = 'hbd ; mem_bank[176] = 'hbf ; mem_bank[177] = 'hb0 ; mem_bank[178] = 'h84 ; mem_bank[179] = 'h02 ; 
       mem_bank[180] = 'h42 ; mem_bank[181] = 'h44 ; mem_bank[182] = 'h10 ; mem_bank[183] = 'h10 ; mem_bank[184] = 'h02 ; mem_bank[185] = 'h03 ; mem_bank[186] = 'h43 ; mem_bank[187] = 'h02 ; mem_bank[188] = 'h02 ; mem_bank[189] = 'h03 ; 
       mem_bank[190] = 'h43 ; mem_bank[191] = 'h02 ; mem_bank[192] = 'h02 ; mem_bank[193] = 'h03 ; mem_bank[194] = 'h43 ; mem_bank[195] = 'h02 ; mem_bank[196] = 'h00 ; mem_bank[197] = 'h04 ; mem_bank[198] = 'h02 ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h42 ; mem_bank[201] = 'h02 ; mem_bank[202] = 'hbf ; mem_bank[203] = 'hb0 ; mem_bank[204] = 'he0 ; mem_bank[205] = 'hbd ; mem_bank[206] = 'hbd ; mem_bank[207] = 'hbf ; mem_bank[208] = 'hb0 ; mem_bank[209] = 'h84 ; 
       mem_bank[210] = 'h02 ; mem_bank[211] = 'h42 ; mem_bank[212] = 'h44 ; mem_bank[213] = 'h10 ; mem_bank[214] = 'h10 ; mem_bank[215] = 'h02 ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h42 ; mem_bank[218] = 'h02 ; mem_bank[219] = 'h02 ; 
       mem_bank[220] = 'h03 ; mem_bank[221] = 'h43 ; mem_bank[222] = 'h02 ; mem_bank[223] = 'h02 ; mem_bank[224] = 'h03 ; mem_bank[225] = 'h43 ; mem_bank[226] = 'h02 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h04 ; mem_bank[229] = 'h02 ; 
       mem_bank[230] = 'h00 ; mem_bank[231] = 'h42 ; mem_bank[232] = 'h02 ; mem_bank[233] = 'hbf ; mem_bank[234] = 'hb0 ; mem_bank[235] = 'he0 ; mem_bank[236] = 'hbd ; mem_bank[237] = 'hbd ; mem_bank[238] = 'hbf ; mem_bank[239] = 'ha5 ; 
       mem_bank[240] = 'ha0 ; mem_bank[241] = 'h82 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h42 ; mem_bank[244] = 'h42 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h44 ; mem_bank[247] = 'hbf ; mem_bank[248] = 'h00 ; mem_bank[249] = 'he0 ; 
       mem_bank[250] = 'hbd ; mem_bank[251] = 'hbd ; mem_bank[252] = 'hbf ; mem_bank[253] = 'hb0 ; mem_bank[254] = 'hc0 ; mem_bank[255] = 'ha5 ; mem_bank[256] = 'h10 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h84 ; mem_bank[259] = 'h00 ; 
       mem_bank[260] = 'h00 ; mem_bank[261] = 'hbf ; mem_bank[262] = 'hb0 ; mem_bank[263] = 'he0 ; mem_bank[264] = 'hbd ; mem_bank[265] = 'hbd ; mem_bank[266] = 'hbf ; mem_bank[267] = 'hb0 ; mem_bank[268] = 'hc0 ; mem_bank[269] = 'h84 ; 
       mem_bank[270] = 'h00 ; mem_bank[271] = 'ha5 ; mem_bank[272] = 'h02 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h40 ; mem_bank[275] = 'h40 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h10 ; mem_bank[278] = 'h04 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'h80 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'hbf ; mem_bank[283] = 'hb0 ; mem_bank[284] = 'he0 ; mem_bank[285] = 'hbd ; mem_bank[286] = 'hbd ; mem_bank[287] = 'hbf ; mem_bank[288] = 'hb1 ; mem_bank[289] = 'hb0 ; 
       mem_bank[290] = 'h00 ; mem_bank[291] = 'h04 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h84 ; mem_bank[294] = 'h03 ; mem_bank[295] = 'h02 ; mem_bank[296] = 'h42 ; mem_bank[297] = 'h43 ; mem_bank[298] = 'h11 ; mem_bank[299] = 'h00 ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'h51 ; mem_bank[302] = 'h00 ; mem_bank[303] = 'h00 ; mem_bank[304] = 'h04 ; mem_bank[305] = 'h11 ; mem_bank[306] = 'h31 ; mem_bank[307] = 'h00 ; mem_bank[308] = 'h00 ; mem_bank[309] = 'h02 ; 
       mem_bank[310] = 'h42 ; mem_bank[311] = 'h10 ; mem_bank[312] = 'h00 ; mem_bank[313] = 'h22 ; mem_bank[314] = 'hbd ; mem_bank[315] = 'hbf ; mem_bank[316] = 'h03 ; mem_bank[317] = 'h63 ; mem_bank[318] = 'h62 ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'h42 ; mem_bank[321] = 'h62 ; mem_bank[322] = 'h02 ; mem_bank[323] = 'h42 ; mem_bank[324] = 'h00 ; mem_bank[325] = 'h44 ; mem_bank[326] = 'hbf ; mem_bank[327] = 'h00 ; mem_bank[328] = 'he0 ; mem_bank[329] = 'hbd ; 
       mem_bank[330] = 'h04 ; mem_bank[331] = 'h84 ; mem_bank[332] = 'h82 ; mem_bank[333] = 'h03 ; mem_bank[334] = 'h43 ; mem_bank[335] = 'h82 ; mem_bank[336] = 'h82 ; mem_bank[337] = 'h03 ; mem_bank[338] = 'h43 ; mem_bank[339] = 'he0 ; 
       mem_bank[340] = 'h82 ; mem_bank[341] = 'h03 ; mem_bank[342] = 'h63 ; mem_bank[343] = 'h62 ; mem_bank[344] = 'h00 ; mem_bank[345] = 'h42 ; mem_bank[346] = 'h62 ; mem_bank[347] = 'h62 ; mem_bank[348] = 'h00 ; mem_bank[349] = 'h42 ; 
       mem_bank[350] = 'h62 ; mem_bank[351] = 'h62 ; mem_bank[352] = 'h04 ; mem_bank[353] = 'h44 ; mem_bank[354] = 'h62 ; mem_bank[355] = 'h62 ; mem_bank[356] = 'h00 ; mem_bank[357] = 'h44 ; mem_bank[358] = 'he0 ; mem_bank[359] = 'h62 ; 
       mem_bank[360] = 'h02 ; mem_bank[361] = 'h42 ; mem_bank[362] = 'h42 ; mem_bank[363] = 'he0 ; mem_bank[364] = 'h00 ; mem_bank[365] = 'h02 ; mem_bank[366] = 'h42 ; mem_bank[367] = 'h42 ; mem_bank[368] = 'h00 ; mem_bank[369] = 'h42 ; 
       mem_bank[370] = 'he0 ; mem_bank[371] = 'h42 ; mem_bank[372] = 'h02 ; mem_bank[373] = 'h42 ; mem_bank[374] = 'h42 ; mem_bank[375] = 'h00 ; mem_bank[376] = 'h02 ; mem_bank[377] = 'h42 ; mem_bank[378] = 'he0 ; mem_bank[379] = 'h42 ; 
       mem_bank[380] = 'h02 ; mem_bank[381] = 'h42 ; mem_bank[382] = 'h43 ; mem_bank[383] = 'h04 ; mem_bank[384] = 'h64 ; mem_bank[385] = 'he0 ; mem_bank[386] = 'h43 ; mem_bank[387] = 'h03 ; mem_bank[388] = 'h63 ; mem_bank[389] = 'h62 ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h42 ; mem_bank[392] = 'he0 ; mem_bank[393] = 'h62 ; mem_bank[394] = 'h02 ; mem_bank[395] = 'h42 ; mem_bank[396] = 'h43 ; mem_bank[397] = 'h04 ; mem_bank[398] = 'h64 ; mem_bank[399] = 'he0 ; 
       mem_bank[400] = 'h43 ; mem_bank[401] = 'h03 ; mem_bank[402] = 'h63 ; mem_bank[403] = 'h62 ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h42 ; mem_bank[406] = 'he0 ; mem_bank[407] = 'h62 ; mem_bank[408] = 'h84 ; mem_bank[409] = 'h02 ; 
       mem_bank[410] = 'h42 ; mem_bank[411] = 'he0 ; mem_bank[412] = 'h44 ; mem_bank[413] = 'he0 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'hbd ; mem_bank[416] = 'hbf ; mem_bank[417] = 'h03 ; mem_bank[418] = 'h02 ; mem_bank[419] = 'h42 ; 
       mem_bank[420] = 'h43 ; mem_bank[421] = 'h02 ; mem_bank[422] = 'h42 ; mem_bank[423] = 'h43 ; mem_bank[424] = 'h02 ; mem_bank[425] = 'h42 ; mem_bank[426] = 'h00 ; mem_bank[427] = 'h43 ; mem_bank[428] = 'h04 ; mem_bank[429] = 'h84 ; 
       mem_bank[430] = 'h82 ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h42 ; mem_bank[433] = 'h82 ; mem_bank[434] = 'h82 ; mem_bank[435] = 'h03 ; mem_bank[436] = 'h43 ; mem_bank[437] = 'h82 ; mem_bank[438] = 'h82 ; mem_bank[439] = 'h03 ; 
       mem_bank[440] = 'h43 ; mem_bank[441] = 'h82 ; mem_bank[442] = 'h82 ; mem_bank[443] = 'h03 ; mem_bank[444] = 'h43 ; mem_bank[445] = 'h82 ; mem_bank[446] = 'h00 ; mem_bank[447] = 'h00 ; mem_bank[448] = 'h00 ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'h00 ; mem_bank[451] = 'h00 ; mem_bank[452] = 'hbd ; mem_bank[453] = 'hbf ; mem_bank[454] = 'hb1 ; mem_bank[455] = 'hb0 ; mem_bank[456] = 'h10 ; mem_bank[457] = 'h11 ; mem_bank[458] = 'h00 ; mem_bank[459] = 'h10 ; 
       mem_bank[460] = 'h00 ; mem_bank[461] = 'h00 ; mem_bank[462] = 'h11 ; mem_bank[463] = 'h02 ; mem_bank[464] = 'h42 ; mem_bank[465] = 'h40 ; mem_bank[466] = 'hbf ; mem_bank[467] = 'hb1 ; mem_bank[468] = 'hb0 ; mem_bank[469] = 'he0 ; 
       mem_bank[470] = 'hbd ; mem_bank[471] = 'h00 ; mem_bank[472] = 'h00 ; mem_bank[473] = 'h00 ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h00 ; mem_bank[477] = 'h68 ; mem_bank[478] = 'h69 ; mem_bank[479] = 'h49 ; 
       mem_bank[480] = 'h38 ; mem_bank[481] = 'h4f ; mem_bank[482] = 'h4f ; mem_bank[483] = 'h52 ; mem_bank[484] = 'h00 ;     
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
    assign qa =(r_rdaddress_a>484)?0:mem_bank[r_rdaddress_a];
    assign qb =(r_rdaddress_b>484)?0:mem_bank[r_rdaddress_b];
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
       mem_bank[10] = 'h14 ; mem_bank[11] = 'h24 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h0c ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h08 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'h0c ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h40 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h10 ; mem_bank[29] = 'h24 ; 
       mem_bank[30] = 'h24 ; mem_bank[31] = 'h24 ; mem_bank[32] = 'h24 ; mem_bank[33] = 'h14 ; mem_bank[34] = 'h24 ; mem_bank[35] = 'h24 ; mem_bank[36] = 'h14 ; mem_bank[37] = 'h24 ; mem_bank[38] = 'h03 ; mem_bank[39] = 'h00 ; 
       mem_bank[40] = 'h00 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h24 ; mem_bank[46] = 'h24 ; mem_bank[47] = 'h10 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h00 ; 
       mem_bank[50] = 'h24 ; mem_bank[51] = 'h24 ; mem_bank[52] = 'h14 ; mem_bank[53] = 'h24 ; mem_bank[54] = 'h24 ; mem_bank[55] = 'h14 ; mem_bank[56] = 'h24 ; mem_bank[57] = 'h03 ; mem_bank[58] = 'h00 ; mem_bank[59] = 'h30 ; 
       mem_bank[60] = 'h3c ; mem_bank[61] = 'h34 ; mem_bank[62] = 'h8c ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h30 ; mem_bank[65] = 'h10 ; mem_bank[66] = 'h3c ; mem_bank[67] = 'h3c ; mem_bank[68] = 'h34 ; mem_bank[69] = 'h8c ; 
       mem_bank[70] = 'h00 ; mem_bank[71] = 'h30 ; mem_bank[72] = 'h14 ; mem_bank[73] = 'h3c ; mem_bank[74] = 'h34 ; mem_bank[75] = 'h03 ; mem_bank[76] = 'ha0 ; mem_bank[77] = 'h3c ; mem_bank[78] = 'h34 ; mem_bank[79] = 'h8c ; 
       mem_bank[80] = 'h00 ; mem_bank[81] = 'h30 ; mem_bank[82] = 'h14 ; mem_bank[83] = 'h3c ; mem_bank[84] = 'h3c ; mem_bank[85] = 'h34 ; mem_bank[86] = 'h8c ; mem_bank[87] = 'h00 ; mem_bank[88] = 'h30 ; mem_bank[89] = 'h10 ; 
       mem_bank[90] = 'h3c ; mem_bank[91] = 'h34 ; mem_bank[92] = 'h90 ; mem_bank[93] = 'h00 ; mem_bank[94] = 'h30 ; mem_bank[95] = 'h3c ; mem_bank[96] = 'h34 ; mem_bank[97] = 'h8c ; mem_bank[98] = 'h00 ; mem_bank[99] = 'h34 ; 
       mem_bank[100] = 'hac ; mem_bank[101] = 'h8c ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h34 ; mem_bank[104] = 'hac ; mem_bank[105] = 'h8c ; mem_bank[106] = 'h24 ; mem_bank[107] = 'h00 ; mem_bank[108] = 'h03 ; mem_bank[109] = 'hac ; 
       mem_bank[110] = 'h3c ; mem_bank[111] = 'h34 ; mem_bank[112] = 'h8c ; mem_bank[113] = 'h00 ; mem_bank[114] = 'h00 ; mem_bank[115] = 'h03 ; mem_bank[116] = 'h30 ; mem_bank[117] = 'h27 ; mem_bank[118] = 'haf ; mem_bank[119] = 'haf ; 
       mem_bank[120] = 'haf ; mem_bank[121] = 'h00 ; mem_bank[122] = 'h24 ; mem_bank[123] = 'h92 ; mem_bank[124] = 'h00 ; mem_bank[125] = 'h10 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h14 ; mem_bank[128] = 'h00 ; mem_bank[129] = 'h0c ; 
       mem_bank[130] = 'h24 ; mem_bank[131] = 'h92 ; mem_bank[132] = 'h0c ; mem_bank[133] = 'h26 ; mem_bank[134] = 'h10 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h8f ; mem_bank[137] = 'h8f ; mem_bank[138] = 'h8f ; mem_bank[139] = 'h03 ; 
       mem_bank[140] = 'h27 ; mem_bank[141] = 'h27 ; mem_bank[142] = 'haf ; mem_bank[143] = 'haf ; mem_bank[144] = 'haf ; mem_bank[145] = 'h0c ; mem_bank[146] = 'h24 ; mem_bank[147] = 'h24 ; mem_bank[148] = 'h24 ; mem_bank[149] = 'h0c ; 
       mem_bank[150] = 'h24 ; mem_bank[151] = 'h3c ; mem_bank[152] = 'h0c ; mem_bank[153] = 'h34 ; mem_bank[154] = 'h26 ; mem_bank[155] = 'h30 ; mem_bank[156] = 'h16 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h0c ; mem_bank[159] = 'h24 ; 
       mem_bank[160] = 'h0c ; mem_bank[161] = 'h24 ; mem_bank[162] = 'h0c ; mem_bank[163] = 'h24 ; mem_bank[164] = 'h0c ; mem_bank[165] = 'h24 ; mem_bank[166] = 'h0c ; mem_bank[167] = 'h24 ; mem_bank[168] = 'h0c ; mem_bank[169] = 'h24 ; 
       mem_bank[170] = 'h8f ; mem_bank[171] = 'h8f ; mem_bank[172] = 'h8f ; mem_bank[173] = 'h03 ; mem_bank[174] = 'h27 ; mem_bank[175] = 'h27 ; mem_bank[176] = 'haf ; mem_bank[177] = 'haf ; mem_bank[178] = 'h30 ; mem_bank[179] = 'h3c ; 
       mem_bank[180] = 'h34 ; mem_bank[181] = 'ha0 ; mem_bank[182] = 'h3c ; mem_bank[183] = 'h36 ; mem_bank[184] = 'h8e ; mem_bank[185] = 'h24 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'hae ; mem_bank[188] = 'h8e ; mem_bank[189] = 'h24 ; 
       mem_bank[190] = 'h00 ; mem_bank[191] = 'hae ; mem_bank[192] = 'h8e ; mem_bank[193] = 'h24 ; mem_bank[194] = 'h00 ; mem_bank[195] = 'hae ; mem_bank[196] = 'h0c ; mem_bank[197] = 'h24 ; mem_bank[198] = 'h8e ; mem_bank[199] = 'h00 ; 
       mem_bank[200] = 'h34 ; mem_bank[201] = 'hae ; mem_bank[202] = 'h8f ; mem_bank[203] = 'h8f ; mem_bank[204] = 'h03 ; mem_bank[205] = 'h27 ; mem_bank[206] = 'h27 ; mem_bank[207] = 'haf ; mem_bank[208] = 'haf ; mem_bank[209] = 'h30 ; 
       mem_bank[210] = 'h3c ; mem_bank[211] = 'h34 ; mem_bank[212] = 'ha0 ; mem_bank[213] = 'h3c ; mem_bank[214] = 'h36 ; mem_bank[215] = 'h8e ; mem_bank[216] = 'h00 ; mem_bank[217] = 'h34 ; mem_bank[218] = 'hae ; mem_bank[219] = 'h8e ; 
       mem_bank[220] = 'h24 ; mem_bank[221] = 'h00 ; mem_bank[222] = 'hae ; mem_bank[223] = 'h8e ; mem_bank[224] = 'h24 ; mem_bank[225] = 'h00 ; mem_bank[226] = 'hae ; mem_bank[227] = 'h0c ; mem_bank[228] = 'h24 ; mem_bank[229] = 'h8e ; 
       mem_bank[230] = 'h00 ; mem_bank[231] = 'h34 ; mem_bank[232] = 'hae ; mem_bank[233] = 'h8f ; mem_bank[234] = 'h8f ; mem_bank[235] = 'h03 ; mem_bank[236] = 'h27 ; mem_bank[237] = 'h27 ; mem_bank[238] = 'haf ; mem_bank[239] = 'h30 ; 
       mem_bank[240] = 'h14 ; mem_bank[241] = 'h30 ; mem_bank[242] = 'h10 ; mem_bank[243] = 'h24 ; mem_bank[244] = 'h24 ; mem_bank[245] = 'h0c ; mem_bank[246] = 'h30 ; mem_bank[247] = 'h8f ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h03 ; 
       mem_bank[250] = 'h27 ; mem_bank[251] = 'h27 ; mem_bank[252] = 'haf ; mem_bank[253] = 'haf ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h30 ; mem_bank[256] = 'h32 ; mem_bank[257] = 'h0c ; mem_bank[258] = 'h30 ; mem_bank[259] = 'h0c ; 
       mem_bank[260] = 'h02 ; mem_bank[261] = 'h8f ; mem_bank[262] = 'h8f ; mem_bank[263] = 'h03 ; mem_bank[264] = 'h27 ; mem_bank[265] = 'h27 ; mem_bank[266] = 'haf ; mem_bank[267] = 'haf ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h30 ; 
       mem_bank[270] = 'h0c ; mem_bank[271] = 'h30 ; mem_bank[272] = 'h92 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h10 ; mem_bank[275] = 'h00 ; mem_bank[276] = 'h0c ; mem_bank[277] = 'h26 ; mem_bank[278] = 'h92 ; mem_bank[279] = 'h00 ; 
       mem_bank[280] = 'h14 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h8f ; mem_bank[283] = 'h8f ; mem_bank[284] = 'h03 ; mem_bank[285] = 'h27 ; mem_bank[286] = 'h27 ; mem_bank[287] = 'haf ; mem_bank[288] = 'haf ; mem_bank[289] = 'haf ; 
       mem_bank[290] = 'h00 ; mem_bank[291] = 'h3c ; mem_bank[292] = 'h0c ; mem_bank[293] = 'h24 ; mem_bank[294] = 'h24 ; mem_bank[295] = 'h3c ; mem_bank[296] = 'h34 ; mem_bank[297] = 'ha0 ; mem_bank[298] = 'h24 ; mem_bank[299] = 'h0c ; 
       mem_bank[300] = 'h00 ; mem_bank[301] = 'h14 ; mem_bank[302] = 'h00 ; mem_bank[303] = 'h0c ; mem_bank[304] = 'h24 ; mem_bank[305] = 'h3c ; mem_bank[306] = 'h36 ; mem_bank[307] = 'h0c ; mem_bank[308] = 'h00 ; mem_bank[309] = 'ha2 ; 
       mem_bank[310] = 'h30 ; mem_bank[311] = 'h26 ; mem_bank[312] = 'h10 ; mem_bank[313] = 'ha2 ; mem_bank[314] = 'h27 ; mem_bank[315] = 'haf ; mem_bank[316] = 'h3c ; mem_bank[317] = 'h34 ; mem_bank[318] = 'h8c ; mem_bank[319] = 'h00 ; 
       mem_bank[320] = 'h34 ; mem_bank[321] = 'hac ; mem_bank[322] = 'h3c ; mem_bank[323] = 'h34 ; mem_bank[324] = 'h0c ; mem_bank[325] = 'hac ; mem_bank[326] = 'h8f ; mem_bank[327] = 'h00 ; mem_bank[328] = 'h03 ; mem_bank[329] = 'h27 ; 
       mem_bank[330] = 'h3c ; mem_bank[331] = 'h34 ; mem_bank[332] = 'h8c ; mem_bank[333] = 'h24 ; mem_bank[334] = 'h00 ; mem_bank[335] = 'hac ; mem_bank[336] = 'h8c ; mem_bank[337] = 'h24 ; mem_bank[338] = 'h00 ; mem_bank[339] = 'h03 ; 
       mem_bank[340] = 'hac ; mem_bank[341] = 'h3c ; mem_bank[342] = 'h34 ; mem_bank[343] = 'h8c ; mem_bank[344] = 'h00 ; mem_bank[345] = 'h34 ; mem_bank[346] = 'hac ; mem_bank[347] = 'h8c ; mem_bank[348] = 'h00 ; mem_bank[349] = 'h34 ; 
       mem_bank[350] = 'hac ; mem_bank[351] = 'h8c ; mem_bank[352] = 'h24 ; mem_bank[353] = 'h00 ; mem_bank[354] = 'hac ; mem_bank[355] = 'h8c ; mem_bank[356] = 'h00 ; mem_bank[357] = 'h00 ; mem_bank[358] = 'h03 ; mem_bank[359] = 'hac ; 
       mem_bank[360] = 'h3c ; mem_bank[361] = 'h34 ; mem_bank[362] = 'h8c ; mem_bank[363] = 'h03 ; mem_bank[364] = 'h00 ; mem_bank[365] = 'h3c ; mem_bank[366] = 'h34 ; mem_bank[367] = 'h8c ; mem_bank[368] = 'h00 ; mem_bank[369] = 'h38 ; 
       mem_bank[370] = 'h03 ; mem_bank[371] = 'h30 ; mem_bank[372] = 'h3c ; mem_bank[373] = 'h34 ; mem_bank[374] = 'h8c ; mem_bank[375] = 'h00 ; mem_bank[376] = 'h00 ; mem_bank[377] = 'h38 ; mem_bank[378] = 'h03 ; mem_bank[379] = 'h30 ; 
       mem_bank[380] = 'h3c ; mem_bank[381] = 'h34 ; mem_bank[382] = 'h8c ; mem_bank[383] = 'h24 ; mem_bank[384] = 'h00 ; mem_bank[385] = 'h03 ; mem_bank[386] = 'hac ; mem_bank[387] = 'h3c ; mem_bank[388] = 'h34 ; mem_bank[389] = 'h8c ; 
       mem_bank[390] = 'h00 ; mem_bank[391] = 'h34 ; mem_bank[392] = 'h03 ; mem_bank[393] = 'hac ; mem_bank[394] = 'h3c ; mem_bank[395] = 'h34 ; mem_bank[396] = 'h8c ; mem_bank[397] = 'h24 ; mem_bank[398] = 'h00 ; mem_bank[399] = 'h03 ; 
       mem_bank[400] = 'hac ; mem_bank[401] = 'h3c ; mem_bank[402] = 'h34 ; mem_bank[403] = 'h8c ; mem_bank[404] = 'h00 ; mem_bank[405] = 'h34 ; mem_bank[406] = 'h03 ; mem_bank[407] = 'hac ; mem_bank[408] = 'h30 ; mem_bank[409] = 'h3c ; 
       mem_bank[410] = 'h34 ; mem_bank[411] = 'h03 ; mem_bank[412] = 'ha0 ; mem_bank[413] = 'h03 ; mem_bank[414] = 'h00 ; mem_bank[415] = 'h27 ; mem_bank[416] = 'haf ; mem_bank[417] = 'h24 ; mem_bank[418] = 'h3c ; mem_bank[419] = 'h34 ; 
       mem_bank[420] = 'hac ; mem_bank[421] = 'h3c ; mem_bank[422] = 'h34 ; mem_bank[423] = 'hac ; mem_bank[424] = 'h3c ; mem_bank[425] = 'h34 ; mem_bank[426] = 'h0c ; mem_bank[427] = 'hac ; mem_bank[428] = 'h3c ; mem_bank[429] = 'h34 ; 
       mem_bank[430] = 'h8c ; mem_bank[431] = 'h00 ; mem_bank[432] = 'h34 ; mem_bank[433] = 'hac ; mem_bank[434] = 'h8c ; mem_bank[435] = 'h3c ; mem_bank[436] = 'h00 ; mem_bank[437] = 'hac ; mem_bank[438] = 'h8c ; mem_bank[439] = 'h3c ; 
       mem_bank[440] = 'h00 ; mem_bank[441] = 'hac ; mem_bank[442] = 'h8c ; mem_bank[443] = 'h3c ; mem_bank[444] = 'h00 ; mem_bank[445] = 'hac ; mem_bank[446] = 'h0c ; mem_bank[447] = 'h00 ; mem_bank[448] = 'h0c ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'h10 ; mem_bank[451] = 'h00 ; mem_bank[452] = 'h27 ; mem_bank[453] = 'haf ; mem_bank[454] = 'haf ; mem_bank[455] = 'haf ; mem_bank[456] = 'h24 ; mem_bank[457] = 'h24 ; mem_bank[458] = 'h0c ; mem_bank[459] = 'h26 ; 
       mem_bank[460] = 'h0c ; mem_bank[461] = 'h00 ; mem_bank[462] = 'h16 ; mem_bank[463] = 'h3c ; mem_bank[464] = 'h34 ; mem_bank[465] = 'hac ; mem_bank[466] = 'h8f ; mem_bank[467] = 'h8f ; mem_bank[468] = 'h8f ; mem_bank[469] = 'h03 ; 
       mem_bank[470] = 'h27 ; mem_bank[471] = 'h00 ; mem_bank[472] = 'h00 ; mem_bank[473] = 'h00 ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h00 ; mem_bank[477] = 'h54 ; mem_bank[478] = 'h20 ; mem_bank[479] = 'h4d ; 
       mem_bank[480] = 'h37 ; mem_bank[481] = 'h42 ; mem_bank[482] = 'h4c ; mem_bank[483] = 'h45 ; mem_bank[484] = 'h00 ;     
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
    assign qa =(r_rdaddress_a>484)?0:mem_bank[r_rdaddress_a];
    assign qb =(r_rdaddress_b>484)?0:mem_bank[r_rdaddress_b];
endmodule



