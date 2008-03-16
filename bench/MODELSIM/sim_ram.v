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
    input   [29:0]  wraddress,
    input   [29:0]  rdaddress_a,
    input   [29:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [29:0]  r_wraddress;
    reg [29:0]  r_rdaddress_a;
    reg [29:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:12345]  ;
    
initial begin   
       mem_bank[0] = 'h00 ; mem_bank[1] = 'hc8 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'hd8 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'hdc ; mem_bank[6] = 'h00 ; mem_bank[7] = 'hd8 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h2a ; 
       mem_bank[10] = 'hfd ; mem_bank[11] = 'h04 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'hf5 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h10 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'hfe ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h09 ; mem_bank[29] = 'hff ; 
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
       mem_bank[290] = 'h25 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h75 ; mem_bank[293] = 'h18 ; mem_bank[294] = 'hcc ; mem_bank[295] = 'h00 ; mem_bank[296] = 'h1c ; mem_bank[297] = 'h00 ; mem_bank[298] = 'h21 ; mem_bank[299] = 'h4d ; 
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
       mem_bank[410] = 'h1c ; mem_bank[411] = 'h08 ; mem_bank[412] = 'h00 ; mem_bank[413] = 'h00 ; mem_bank[414] = 'he0 ; mem_bank[415] = 'h07 ; mem_bank[416] = 'h00 ; mem_bank[417] = 'hd8 ; mem_bank[418] = 'h0f ; mem_bank[419] = 'h0a ; 
       mem_bank[420] = 'h03 ; mem_bank[421] = 'h21 ; mem_bank[422] = 'h02 ; mem_bank[423] = 'h30 ; mem_bank[424] = 'h37 ; mem_bank[425] = 'h00 ; mem_bank[426] = 'hff ; mem_bank[427] = 'hf6 ; mem_bank[428] = 'h02 ; mem_bank[429] = 'h00 ; 
       mem_bank[430] = 'h08 ; mem_bank[431] = 'hd8 ; mem_bank[432] = 'h25 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'hf2 ; mem_bank[435] = 'h09 ; mem_bank[436] = 'h00 ; mem_bank[437] = 'he8 ; mem_bank[438] = 'hcc ; mem_bank[439] = 'hcd ; 
       mem_bank[440] = 'h21 ; mem_bank[441] = 'h19 ; mem_bank[442] = 'h10 ; mem_bank[443] = 'hc2 ; mem_bank[444] = 'h80 ; mem_bank[445] = 'h21 ; mem_bank[446] = 'h40 ; mem_bank[447] = 'h23 ; mem_bank[448] = 'h30 ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'hff ; mem_bank[451] = 'hf4 ; mem_bank[452] = 'h25 ; mem_bank[453] = 'h00 ; mem_bank[454] = 'h08 ; mem_bank[455] = 'he8 ; mem_bank[456] = 'he0 ; mem_bank[457] = 'h18 ; mem_bank[458] = 'h14 ; mem_bank[459] = 'h10 ; 
       mem_bank[460] = 'hb0 ; mem_bank[461] = 'h25 ; mem_bank[462] = 'h75 ; mem_bank[463] = 'h25 ; mem_bank[464] = 'h00 ; mem_bank[465] = 'h75 ; mem_bank[466] = 'h14 ; mem_bank[467] = 'h9a ; mem_bank[468] = 'hff ; mem_bank[469] = 'h2b ; 
       mem_bank[470] = 'h1e ; mem_bank[471] = 'h42 ; mem_bank[472] = 'h04 ; mem_bank[473] = 'h83 ; mem_bank[474] = 'h19 ; mem_bank[475] = 'h10 ; mem_bank[476] = 'hc2 ; mem_bank[477] = 'h00 ; mem_bank[478] = 'h60 ; mem_bank[479] = 'h80 ; 
       mem_bank[480] = 'h21 ; mem_bank[481] = 'h00 ; mem_bank[482] = 'h75 ; mem_bank[483] = 'h00 ; mem_bank[484] = 'h00 ; mem_bank[485] = 'h75 ; mem_bank[486] = 'h18 ; mem_bank[487] = 'h40 ; mem_bank[488] = 'h23 ; mem_bank[489] = 'h80 ; 
       mem_bank[490] = 'h23 ; mem_bank[491] = 'h00 ; mem_bank[492] = 'h21 ; mem_bank[493] = 'hc0 ; mem_bank[494] = 'h23 ; mem_bank[495] = 'h40 ; mem_bank[496] = 'h23 ; mem_bank[497] = 'h80 ; mem_bank[498] = 'h21 ; mem_bank[499] = 'h40 ; 
       mem_bank[500] = 'h23 ; mem_bank[501] = 'hf5 ; mem_bank[502] = 'hff ; mem_bank[503] = 'h2b ; mem_bank[504] = 'h23 ; mem_bank[505] = 'he6 ; mem_bank[506] = 'h89 ; mem_bank[507] = 'h19 ; mem_bank[508] = 'h10 ; mem_bank[509] = 'h42 ; 
       mem_bank[510] = 'h00 ; mem_bank[511] = 'h60 ; mem_bank[512] = 'h80 ; mem_bank[513] = 'h21 ; mem_bank[514] = 'h00 ; mem_bank[515] = 'h75 ; mem_bank[516] = 'h00 ; mem_bank[517] = 'h00 ; mem_bank[518] = 'h75 ; mem_bank[519] = 'h24 ; 
       mem_bank[520] = 'h40 ; mem_bank[521] = 'h21 ; mem_bank[522] = 'h80 ; mem_bank[523] = 'h23 ; mem_bank[524] = 'h80 ; mem_bank[525] = 'h23 ; mem_bank[526] = 'h00 ; mem_bank[527] = 'h23 ; mem_bank[528] = 'h40 ; mem_bank[529] = 'h21 ; 
       mem_bank[530] = 'h00 ; mem_bank[531] = 'h23 ; mem_bank[532] = 'h0f ; mem_bank[533] = 'h3f ; mem_bank[534] = 'h2b ; mem_bank[535] = 'h05 ; mem_bank[536] = 'h31 ; mem_bank[537] = 'h00 ; mem_bank[538] = 'h75 ; mem_bank[539] = 'h30 ; 
       mem_bank[540] = 'h31 ; mem_bank[541] = 'hff ; mem_bank[542] = 'h2b ; mem_bank[543] = 'h21 ; mem_bank[544] = 'h5f ; mem_bank[545] = 'h6b ; mem_bank[546] = 'h19 ; mem_bank[547] = 'h10 ; mem_bank[548] = 'h82 ; mem_bank[549] = 'h00 ; 
       mem_bank[550] = 'h60 ; mem_bank[551] = 'h14 ; mem_bank[552] = 'h80 ; mem_bank[553] = 'h21 ; mem_bank[554] = 'h00 ; mem_bank[555] = 'h75 ; mem_bank[556] = 'h00 ; mem_bank[557] = 'h3b ; mem_bank[558] = 'h20 ; mem_bank[559] = 'h40 ; 
       mem_bank[560] = 'h23 ; mem_bank[561] = 'h80 ; mem_bank[562] = 'h23 ; mem_bank[563] = 'hc0 ; mem_bank[564] = 'h21 ; mem_bank[565] = 'h80 ; mem_bank[566] = 'h21 ; mem_bank[567] = 'hc0 ; mem_bank[568] = 'h23 ; mem_bank[569] = 'h0f ; 
       mem_bank[570] = 'h3f ; mem_bank[571] = 'h2b ; mem_bank[572] = 'h09 ; mem_bank[573] = 'h1b ; mem_bank[574] = 'h00 ; mem_bank[575] = 'h75 ; mem_bank[576] = 'h30 ; mem_bank[577] = 'h0f ; mem_bank[578] = 'h3f ; mem_bank[579] = 'h2b ; 
       mem_bank[580] = 'h17 ; mem_bank[581] = 'h1b ; mem_bank[582] = 'h83 ; mem_bank[583] = 'h19 ; mem_bank[584] = 'h10 ; mem_bank[585] = 'h82 ; mem_bank[586] = 'h00 ; mem_bank[587] = 'h60 ; mem_bank[588] = 'h80 ; mem_bank[589] = 'h21 ; 
       mem_bank[590] = 'h00 ; mem_bank[591] = 'h75 ; mem_bank[592] = 'h00 ; mem_bank[593] = 'h00 ; mem_bank[594] = 'h75 ; mem_bank[595] = 'h3c ; mem_bank[596] = 'h40 ; mem_bank[597] = 'h23 ; mem_bank[598] = 'h80 ; mem_bank[599] = 'h23 ; 
       mem_bank[600] = 'hc0 ; mem_bank[601] = 'h21 ; mem_bank[602] = 'h80 ; mem_bank[603] = 'h23 ; mem_bank[604] = 'h01 ; mem_bank[605] = 'h9f ; mem_bank[606] = 'h2b ; mem_bank[607] = 'h20 ; mem_bank[608] = 'h42 ; mem_bank[609] = 'h7c ; 
       mem_bank[610] = 'hc5 ; mem_bank[611] = 'h19 ; mem_bank[612] = 'h10 ; mem_bank[613] = 'hc2 ; mem_bank[614] = 'h00 ; mem_bank[615] = 'h60 ; mem_bank[616] = 'h80 ; mem_bank[617] = 'h21 ; mem_bank[618] = 'h00 ; mem_bank[619] = 'h75 ; 
       mem_bank[620] = 'h00 ; mem_bank[621] = 'h00 ; mem_bank[622] = 'h75 ; mem_bank[623] = 'h24 ; mem_bank[624] = 'h40 ; mem_bank[625] = 'h21 ; mem_bank[626] = 'h80 ; mem_bank[627] = 'h21 ; mem_bank[628] = 'h80 ; mem_bank[629] = 'h21 ; 
       mem_bank[630] = 'h80 ; mem_bank[631] = 'h21 ; mem_bank[632] = 'h40 ; mem_bank[633] = 'h23 ; mem_bank[634] = 'he8 ; mem_bank[635] = 'h05 ; mem_bank[636] = 'h20 ; mem_bank[637] = 'h00 ; mem_bank[638] = 'h75 ; mem_bank[639] = 'h48 ; 
       mem_bank[640] = 'h20 ; mem_bank[641] = 'h1f ; mem_bank[642] = 'he8 ; mem_bank[643] = 'hb7 ; mem_bank[644] = 'h59 ; mem_bank[645] = 'h19 ; mem_bank[646] = 'h10 ; mem_bank[647] = 'h42 ; mem_bank[648] = 'h00 ; mem_bank[649] = 'h60 ; 
       mem_bank[650] = 'h14 ; mem_bank[651] = 'h80 ; mem_bank[652] = 'h21 ; mem_bank[653] = 'h00 ; mem_bank[654] = 'h75 ; mem_bank[655] = 'h00 ; mem_bank[656] = 'h3b ; mem_bank[657] = 'h20 ; mem_bank[658] = 'h80 ; mem_bank[659] = 'h21 ; 
       mem_bank[660] = 'hc0 ; mem_bank[661] = 'h23 ; mem_bank[662] = 'h00 ; mem_bank[663] = 'h21 ; mem_bank[664] = 'h00 ; mem_bank[665] = 'h23 ; mem_bank[666] = 'he8 ; mem_bank[667] = 'h08 ; mem_bank[668] = 'h62 ; mem_bank[669] = 'h00 ; 
       mem_bank[670] = 'h75 ; mem_bank[671] = 'h48 ; mem_bank[672] = 'he8 ; mem_bank[673] = 'h17 ; mem_bank[674] = 'h64 ; mem_bank[675] = 'h62 ; mem_bank[676] = 'hd3 ; mem_bank[677] = 'h19 ; mem_bank[678] = 'h10 ; mem_bank[679] = 'h82 ; 
       mem_bank[680] = 'h00 ; mem_bank[681] = 'h60 ; mem_bank[682] = 'h80 ; mem_bank[683] = 'h21 ; mem_bank[684] = 'h00 ; mem_bank[685] = 'h75 ; mem_bank[686] = 'h00 ; mem_bank[687] = 'h00 ; mem_bank[688] = 'h75 ; mem_bank[689] = 'h54 ; 
       mem_bank[690] = 'h40 ; mem_bank[691] = 'h23 ; mem_bank[692] = 'h80 ; mem_bank[693] = 'h21 ; mem_bank[694] = 'hc0 ; mem_bank[695] = 'h23 ; mem_bank[696] = 'h64 ; mem_bank[697] = 'h17 ; mem_bank[698] = 'h14 ; mem_bank[699] = 'heb ; 
       mem_bank[700] = 'h1f ; mem_bank[701] = 'h19 ; mem_bank[702] = 'h10 ; mem_bank[703] = 'h42 ; mem_bank[704] = 'h00 ; mem_bank[705] = 'h60 ; mem_bank[706] = 'h80 ; mem_bank[707] = 'h21 ; mem_bank[708] = 'h00 ; mem_bank[709] = 'h75 ; 
       mem_bank[710] = 'h00 ; mem_bank[711] = 'h00 ; mem_bank[712] = 'h75 ; mem_bank[713] = 'h24 ; mem_bank[714] = 'h40 ; mem_bank[715] = 'h21 ; mem_bank[716] = 'hc0 ; mem_bank[717] = 'h21 ; mem_bank[718] = 'h80 ; mem_bank[719] = 'h23 ; 
       mem_bank[720] = 'h14 ; mem_bank[721] = 'h14 ; mem_bank[722] = 'h00 ; mem_bank[723] = 'hcc ; mem_bank[724] = 'hcd ; mem_bank[725] = 'h19 ; mem_bank[726] = 'h10 ; mem_bank[727] = 'hc2 ; mem_bank[728] = 'h60 ; mem_bank[729] = 'h14 ; 
       mem_bank[730] = 'h80 ; mem_bank[731] = 'h21 ; mem_bank[732] = 'h00 ; mem_bank[733] = 'h75 ; mem_bank[734] = 'h00 ; mem_bank[735] = 'h3b ; mem_bank[736] = 'h20 ; mem_bank[737] = 'h80 ; mem_bank[738] = 'h21 ; mem_bank[739] = 'h40 ; 
       mem_bank[740] = 'h23 ; mem_bank[741] = 'h00 ; mem_bank[742] = 'h60 ; mem_bank[743] = 'h80 ; mem_bank[744] = 'h21 ; mem_bank[745] = 'h00 ; mem_bank[746] = 'h75 ; mem_bank[747] = 'h00 ; mem_bank[748] = 'h3b ; mem_bank[749] = 'h0d ; 
       mem_bank[750] = 'h3b ; mem_bank[751] = 'h0a ; mem_bank[752] = 'h18 ; mem_bank[753] = 'h14 ; mem_bank[754] = 'h10 ; mem_bank[755] = 'h08 ; mem_bank[756] = 'h20 ; mem_bank[757] = 'he8 ; mem_bank[758] = 'h14 ; mem_bank[759] = 'h10 ; 
       mem_bank[760] = 'h03 ; mem_bank[761] = 'hc8 ; mem_bank[762] = 'h25 ; mem_bank[763] = 'h40 ; mem_bank[764] = 'hfc ; mem_bank[765] = 'h21 ; mem_bank[766] = 'h08 ; mem_bank[767] = 'h00 ; mem_bank[768] = 'h00 ; mem_bank[769] = 'h00 ; 
       mem_bank[770] = 'h00 ; mem_bank[771] = 'h00 ; mem_bank[772] = 'h00 ; mem_bank[773] = 'h00 ; mem_bank[774] = 'h73 ; mem_bank[775] = 'h20 ; mem_bank[776] = 'h53 ; mem_bank[777] = 'h20 ; mem_bank[778] = 'h54 ; mem_bank[779] = 'h44 ; 
       mem_bank[780] = 'h00 ; mem_bank[781] = 'h65 ; mem_bank[782] = 'h00 ; mem_bank[783] = 'h68 ; mem_bank[784] = 'h00 ; mem_bank[785] = 'h65 ; mem_bank[786] = 'h00 ; mem_bank[787] = 'h74 ; mem_bank[788] = 'h00 ; mem_bank[789] = 'h74 ; 
       mem_bank[790] = 'h00 ; mem_bank[791] = 'h74 ; mem_bank[792] = 'h00 ; mem_bank[793] = 'h72 ; mem_bank[794] = 'h00 ; mem_bank[795] = 'h6e ; mem_bank[796] = 'h00 ; mem_bank[797] = 'h65 ; mem_bank[798] = 'h6e ; mem_bank[799] = 'h00 ; 
       mem_bank[800] = 'h68 ; mem_bank[801] = 'h6e ; mem_bank[802] = 'h00 ; mem_bank[803] = 'h65 ; mem_bank[804] = 'h65 ; mem_bank[805] = 'h00 ; mem_bank[806] = 'h74 ; mem_bank[807] = 'h00 ; mem_bank[808] = 'h74 ; mem_bank[809] = 'h00 ; 
       mem_bank[810] = 'h72 ; mem_bank[811] = 'h6e ; mem_bank[812] = 'h00 ; mem_bank[813] = 'h72 ; mem_bank[814] = 'h6e ; mem_bank[815] = 'h00 ; mem_bank[816] = 'h6c ; mem_bank[817] = 'h00 ; mem_bank[818] = 'h76 ; mem_bank[819] = 'h00 ; 
       mem_bank[820] = 'h00 ; mem_bank[821] = 'h65 ; mem_bank[822] = 'h00 ; mem_bank[823] = 'h68 ; mem_bank[824] = 'h00 ; mem_bank[825] = 'h65 ; mem_bank[826] = 'h00 ; mem_bank[827] = 'h00 ; mem_bank[828] = 'h65 ; mem_bank[829] = 'h00 ; 
       mem_bank[830] = 'h72 ; mem_bank[831] = 'h00 ; mem_bank[832] = 'h65 ; mem_bank[833] = 'h00 ; mem_bank[834] = 'h00 ; mem_bank[835] = 'h00 ; mem_bank[836] = 'h00 ; mem_bank[837] = 'h00 ; mem_bank[838] = 'h6c ; mem_bank[839] = 'h6e ; 
       mem_bank[840] = 'h00 ; mem_bank[841] = 'h6e ; mem_bank[842] = 'h64 ; mem_bank[843] = 'h00 ; mem_bank[844] = 'h6c ; mem_bank[845] = 'h20 ; mem_bank[846] = 'h00 ; mem_bank[847] = 'h6c ; mem_bank[848] = 'h6e ; mem_bank[849] = 'h00 ; 
       mem_bank[850] = 'h75 ; mem_bank[851] = 'h64 ; mem_bank[852] = 'h00 ; mem_bank[853] = 'h6f ; mem_bank[854] = 'h6e ; mem_bank[855] = 'h00 ; mem_bank[856] = 'h10 ; mem_bank[857] = 'h0c ; mem_bank[858] = 'h08 ; mem_bank[859] = 'h00 ; 
       mem_bank[860] = 'hf8 ; mem_bank[861] = 'hf0 ; mem_bank[862] = 'hec ; mem_bank[863] = 'he4 ; mem_bank[864] = 'hdc ; mem_bank[865] = 'hd4 ; mem_bank[866] = 'hd0 ; mem_bank[867] = 'hc8 ; mem_bank[868] = 'hc0 ; mem_bank[869] = 'hb4 ; 
       mem_bank[870] = 'ha8 ; mem_bank[871] = 'ha0 ; mem_bank[872] = 'h98 ; mem_bank[873] = 'h8c ; mem_bank[874] = 'h80 ; mem_bank[875] = 'h74 ; mem_bank[876] = 'h10 ; mem_bank[877] = 'hd0 ; mem_bank[878] = 'h6c ; mem_bank[879] = 'h64 ; 
       mem_bank[880] = 'h5c ; mem_bank[881] = 'h54 ; mem_bank[882] = 'h4c ; mem_bank[883] = 'h44 ; mem_bank[884] = 'h3c ; mem_bank[885] = 'h34 ; mem_bank[886] = 'h00 ;     
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
    input   [7:0]  data,
    input   [29:0]  wraddress,
    input   [29:0]  rdaddress_a,
    input   [29:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [29:0]  r_wraddress;
    reg [29:0]  r_rdaddress_a;
    reg [29:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:12345]  ;
    
initial begin   
       mem_bank[0] = 'h00 ; mem_bank[1] = 'h8d ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h0d ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h0d ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h0f ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h18 ; 
       mem_bank[10] = 'hff ; mem_bank[11] = 'h00 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h02 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'h00 ; mem_bank[17] = 'h00 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; 
       mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h00 ; mem_bank[23] = 'h02 ; mem_bank[24] = 'h00 ; mem_bank[25] = 'h00 ; mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h00 ; mem_bank[29] = 'hff ; 
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
       mem_bank[290] = 'h80 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h0c ; mem_bank[294] = 'h00 ; mem_bank[295] = 'h80 ; mem_bank[296] = 'h00 ; mem_bank[297] = 'h00 ; mem_bank[298] = 'h00 ; mem_bank[299] = 'h00 ; 
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
       mem_bank[410] = 'h00 ; mem_bank[411] = 'h00 ; mem_bank[412] = 'h00 ; mem_bank[413] = 'h00 ; mem_bank[414] = 'h0d ; mem_bank[415] = 'h00 ; mem_bank[416] = 'h00 ; mem_bank[417] = 'h0d ; mem_bank[418] = 'h00 ; mem_bank[419] = 'h00 ; 
       mem_bank[420] = 'h00 ; mem_bank[421] = 'h28 ; mem_bank[422] = 'h00 ; mem_bank[423] = 'h00 ; mem_bank[424] = 'h00 ; mem_bank[425] = 'h00 ; mem_bank[426] = 'hff ; mem_bank[427] = 'hff ; mem_bank[428] = 'h21 ; mem_bank[429] = 'h00 ; 
       mem_bank[430] = 'h00 ; mem_bank[431] = 'h0d ; mem_bank[432] = 'h30 ; mem_bank[433] = 'h00 ; mem_bank[434] = 'h0d ; mem_bank[435] = 'h00 ; mem_bank[436] = 'h00 ; mem_bank[437] = 'h0d ; mem_bank[438] = 'hcc ; mem_bank[439] = 'hcc ; 
       mem_bank[440] = 'h20 ; mem_bank[441] = 'h00 ; mem_bank[442] = 'h48 ; mem_bank[443] = 'h18 ; mem_bank[444] = 'h10 ; mem_bank[445] = 'h10 ; mem_bank[446] = 'h10 ; mem_bank[447] = 'h10 ; mem_bank[448] = 'h00 ; mem_bank[449] = 'h00 ; 
       mem_bank[450] = 'hff ; mem_bank[451] = 'hff ; mem_bank[452] = 'h30 ; mem_bank[453] = 'h00 ; mem_bank[454] = 'h00 ; mem_bank[455] = 'h0d ; mem_bank[456] = 'hff ; mem_bank[457] = 'h00 ; mem_bank[458] = 'h00 ; mem_bank[459] = 'h00 ; 
       mem_bank[460] = 'h01 ; mem_bank[461] = 'h88 ; mem_bank[462] = 'h00 ; mem_bank[463] = 'h20 ; mem_bank[464] = 'h00 ; mem_bank[465] = 'h00 ; mem_bank[466] = 'h0d ; mem_bank[467] = 'h3b ; mem_bank[468] = 'hc9 ; mem_bank[469] = 'h10 ; 
       mem_bank[470] = 'h00 ; mem_bank[471] = 'h1a ; mem_bank[472] = 'h00 ; mem_bank[473] = 'h4b ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h28 ; mem_bank[476] = 'h81 ; mem_bank[477] = 'h00 ; mem_bank[478] = 'h0d ; mem_bank[479] = 'h10 ; 
       mem_bank[480] = 'h10 ; mem_bank[481] = 'h00 ; mem_bank[482] = 'h00 ; mem_bank[483] = 'h00 ; mem_bank[484] = 'h00 ; mem_bank[485] = 'h00 ; mem_bank[486] = 'h0d ; mem_bank[487] = 'h11 ; mem_bank[488] = 'h10 ; mem_bank[489] = 'h10 ; 
       mem_bank[490] = 'h10 ; mem_bank[491] = 'h11 ; mem_bank[492] = 'h10 ; mem_bank[493] = 'h10 ; mem_bank[494] = 'h10 ; mem_bank[495] = 'h19 ; mem_bank[496] = 'h18 ; mem_bank[497] = 'h18 ; mem_bank[498] = 'h18 ; mem_bank[499] = 'h1a ; 
       mem_bank[500] = 'h88 ; mem_bank[501] = 'h05 ; mem_bank[502] = 'he0 ; mem_bank[503] = 'h10 ; mem_bank[504] = 'h00 ; mem_bank[505] = 'h55 ; mem_bank[506] = 'h3b ; mem_bank[507] = 'h00 ; mem_bank[508] = 'h28 ; mem_bank[509] = 'h86 ; 
       mem_bank[510] = 'h00 ; mem_bank[511] = 'h0d ; mem_bank[512] = 'h10 ; mem_bank[513] = 'h10 ; mem_bank[514] = 'h00 ; mem_bank[515] = 'h00 ; mem_bank[516] = 'h00 ; mem_bank[517] = 'h00 ; mem_bank[518] = 'h00 ; mem_bank[519] = 'h0d ; 
       mem_bank[520] = 'h10 ; mem_bank[521] = 'h10 ; mem_bank[522] = 'h11 ; mem_bank[523] = 'h10 ; mem_bank[524] = 'h10 ; mem_bank[525] = 'h10 ; mem_bank[526] = 'h11 ; mem_bank[527] = 'h10 ; mem_bank[528] = 'h11 ; mem_bank[529] = 'h10 ; 
       mem_bank[530] = 'h12 ; mem_bank[531] = 'h88 ; mem_bank[532] = 'h00 ; mem_bank[533] = 'h42 ; mem_bank[534] = 'h10 ; mem_bank[535] = 'h00 ; mem_bank[536] = 'h01 ; mem_bank[537] = 'h00 ; mem_bank[538] = 'h00 ; mem_bank[539] = 'h0d ; 
       mem_bank[540] = 'h01 ; mem_bank[541] = 'h2c ; mem_bank[542] = 'h10 ; mem_bank[543] = 'h00 ; mem_bank[544] = 'h6b ; mem_bank[545] = 'hca ; mem_bank[546] = 'h00 ; mem_bank[547] = 'h28 ; mem_bank[548] = 'h85 ; mem_bank[549] = 'h00 ; 
       mem_bank[550] = 'h0d ; mem_bank[551] = 'h00 ; mem_bank[552] = 'h10 ; mem_bank[553] = 'h10 ; mem_bank[554] = 'h00 ; mem_bank[555] = 'h00 ; mem_bank[556] = 'h00 ; mem_bank[557] = 'h00 ; mem_bank[558] = 'h00 ; mem_bank[559] = 'h19 ; 
       mem_bank[560] = 'h18 ; mem_bank[561] = 'h11 ; mem_bank[562] = 'h10 ; mem_bank[563] = 'h10 ; mem_bank[564] = 'h10 ; mem_bank[565] = 'h18 ; mem_bank[566] = 'h10 ; mem_bank[567] = 'h11 ; mem_bank[568] = 'h88 ; mem_bank[569] = 'h00 ; 
       mem_bank[570] = 'h42 ; mem_bank[571] = 'h10 ; mem_bank[572] = 'h00 ; mem_bank[573] = 'h43 ; mem_bank[574] = 'h00 ; mem_bank[575] = 'h00 ; mem_bank[576] = 'h0d ; mem_bank[577] = 'h00 ; mem_bank[578] = 'h42 ; mem_bank[579] = 'h10 ; 
       mem_bank[580] = 'h00 ; mem_bank[581] = 'h43 ; mem_bank[582] = 'hde ; mem_bank[583] = 'h00 ; mem_bank[584] = 'h28 ; mem_bank[585] = 'h84 ; mem_bank[586] = 'h00 ; mem_bank[587] = 'h0d ; mem_bank[588] = 'h10 ; mem_bank[589] = 'h10 ; 
       mem_bank[590] = 'h00 ; mem_bank[591] = 'h00 ; mem_bank[592] = 'h00 ; mem_bank[593] = 'h00 ; mem_bank[594] = 'h00 ; mem_bank[595] = 'h0d ; mem_bank[596] = 'h19 ; mem_bank[597] = 'h18 ; mem_bank[598] = 'h11 ; mem_bank[599] = 'h10 ; 
       mem_bank[600] = 'h10 ; mem_bank[601] = 'h10 ; mem_bank[602] = 'h11 ; mem_bank[603] = 'h88 ; mem_bank[604] = 'h00 ; mem_bank[605] = 'h86 ; mem_bank[606] = 'h10 ; mem_bank[607] = 'h00 ; mem_bank[608] = 'h19 ; mem_bank[609] = 'h0a ; 
       mem_bank[610] = 'h5a ; mem_bank[611] = 'h00 ; mem_bank[612] = 'h28 ; mem_bank[613] = 'h81 ; mem_bank[614] = 'h00 ; mem_bank[615] = 'h0d ; mem_bank[616] = 'h10 ; mem_bank[617] = 'h10 ; mem_bank[618] = 'h00 ; mem_bank[619] = 'h00 ; 
       mem_bank[620] = 'h00 ; mem_bank[621] = 'h00 ; mem_bank[622] = 'h00 ; mem_bank[623] = 'h0d ; mem_bank[624] = 'h10 ; mem_bank[625] = 'h10 ; mem_bank[626] = 'h19 ; mem_bank[627] = 'h10 ; mem_bank[628] = 'h10 ; mem_bank[629] = 'h10 ; 
       mem_bank[630] = 'h10 ; mem_bank[631] = 'h10 ; mem_bank[632] = 'h11 ; mem_bank[633] = 'h88 ; mem_bank[634] = 'h03 ; mem_bank[635] = 'h00 ; mem_bank[636] = 'h4e ; mem_bank[637] = 'h00 ; mem_bank[638] = 'h00 ; mem_bank[639] = 'h0d ; 
       mem_bank[640] = 'h4e ; mem_bank[641] = 'h00 ; mem_bank[642] = 'h03 ; mem_bank[643] = 'hd1 ; mem_bank[644] = 'h17 ; mem_bank[645] = 'h00 ; mem_bank[646] = 'h28 ; mem_bank[647] = 'h83 ; mem_bank[648] = 'h00 ; mem_bank[649] = 'h0d ; 
       mem_bank[650] = 'h00 ; mem_bank[651] = 'h10 ; mem_bank[652] = 'h10 ; mem_bank[653] = 'h00 ; mem_bank[654] = 'h00 ; mem_bank[655] = 'h00 ; mem_bank[656] = 'h00 ; mem_bank[657] = 'h00 ; mem_bank[658] = 'h10 ; mem_bank[659] = 'h10 ; 
       mem_bank[660] = 'h10 ; mem_bank[661] = 'h10 ; mem_bank[662] = 'h11 ; mem_bank[663] = 'h10 ; mem_bank[664] = 'h11 ; mem_bank[665] = 'h88 ; mem_bank[666] = 'h03 ; mem_bank[667] = 'h00 ; mem_bank[668] = 'h10 ; mem_bank[669] = 'h00 ; 
       mem_bank[670] = 'h00 ; mem_bank[671] = 'h0d ; mem_bank[672] = 'h03 ; mem_bank[673] = 'h00 ; mem_bank[674] = 'h00 ; mem_bank[675] = 'h10 ; mem_bank[676] = 'h4d ; mem_bank[677] = 'h00 ; mem_bank[678] = 'h28 ; mem_bank[679] = 'h81 ; 
       mem_bank[680] = 'h00 ; mem_bank[681] = 'h0d ; mem_bank[682] = 'h10 ; mem_bank[683] = 'h10 ; mem_bank[684] = 'h00 ; mem_bank[685] = 'h00 ; mem_bank[686] = 'h00 ; mem_bank[687] = 'h00 ; mem_bank[688] = 'h00 ; mem_bank[689] = 'h0d ; 
       mem_bank[690] = 'h11 ; mem_bank[691] = 'h10 ; mem_bank[692] = 'h10 ; mem_bank[693] = 'h10 ; mem_bank[694] = 'h10 ; mem_bank[695] = 'h88 ; mem_bank[696] = 'h00 ; mem_bank[697] = 'h00 ; mem_bank[698] = 'h00 ; mem_bank[699] = 'h51 ; 
       mem_bank[700] = 'h85 ; mem_bank[701] = 'h00 ; mem_bank[702] = 'h28 ; mem_bank[703] = 'h81 ; mem_bank[704] = 'h00 ; mem_bank[705] = 'h0d ; mem_bank[706] = 'h10 ; mem_bank[707] = 'h10 ; mem_bank[708] = 'h00 ; mem_bank[709] = 'h00 ; 
       mem_bank[710] = 'h00 ; mem_bank[711] = 'h00 ; mem_bank[712] = 'h00 ; mem_bank[713] = 'h0d ; mem_bank[714] = 'h10 ; mem_bank[715] = 'h10 ; mem_bank[716] = 'h10 ; mem_bank[717] = 'h10 ; mem_bank[718] = 'h10 ; mem_bank[719] = 'h88 ; 
       mem_bank[720] = 'h00 ; mem_bank[721] = 'h00 ; mem_bank[722] = 'h00 ; mem_bank[723] = 'hcc ; mem_bank[724] = 'hcc ; mem_bank[725] = 'h00 ; mem_bank[726] = 'h28 ; mem_bank[727] = 'h80 ; mem_bank[728] = 'h0d ; mem_bank[729] = 'h00 ; 
       mem_bank[730] = 'h10 ; mem_bank[731] = 'h10 ; mem_bank[732] = 'h00 ; mem_bank[733] = 'h00 ; mem_bank[734] = 'h00 ; mem_bank[735] = 'h00 ; mem_bank[736] = 'h00 ; mem_bank[737] = 'h10 ; mem_bank[738] = 'h10 ; mem_bank[739] = 'h10 ; 
       mem_bank[740] = 'h88 ; mem_bank[741] = 'h00 ; mem_bank[742] = 'h0d ; mem_bank[743] = 'h10 ; mem_bank[744] = 'h10 ; mem_bank[745] = 'h00 ; mem_bank[746] = 'h00 ; mem_bank[747] = 'h00 ; mem_bank[748] = 'h00 ; mem_bank[749] = 'h00 ; 
       mem_bank[750] = 'h00 ; mem_bank[751] = 'h00 ; mem_bank[752] = 'h00 ; mem_bank[753] = 'h00 ; mem_bank[754] = 'h00 ; mem_bank[755] = 'h00 ; mem_bank[756] = 'h00 ; mem_bank[757] = 'hff ; mem_bank[758] = 'h00 ; mem_bank[759] = 'h00 ; 
       mem_bank[760] = 'h00 ; mem_bank[761] = 'h01 ; mem_bank[762] = 'h20 ; mem_bank[763] = 'h10 ; mem_bank[764] = 'hff ; mem_bank[765] = 'h80 ; mem_bank[766] = 'h00 ; mem_bank[767] = 'h00 ; mem_bank[768] = 'h00 ; mem_bank[769] = 'h00 ; 
       mem_bank[770] = 'h00 ; mem_bank[771] = 'h00 ; mem_bank[772] = 'h00 ; mem_bank[773] = 'h00 ; mem_bank[774] = 'h69 ; mem_bank[775] = 'h73 ; mem_bank[776] = 'h50 ; mem_bank[777] = 'h39 ; mem_bank[778] = 'h4f ; mem_bank[779] = 'h41 ; 
       mem_bank[780] = 'h0a ; mem_bank[781] = 'h6e ; mem_bank[782] = 'h00 ; mem_bank[783] = 'h67 ; mem_bank[784] = 'h00 ; mem_bank[785] = 'h76 ; mem_bank[786] = 'h79 ; mem_bank[787] = 'h78 ; mem_bank[788] = 'h00 ; mem_bank[789] = 'h66 ; 
       mem_bank[790] = 'h00 ; mem_bank[791] = 'h72 ; mem_bank[792] = 'h00 ; mem_bank[793] = 'h69 ; mem_bank[794] = 'h00 ; mem_bank[795] = 'h65 ; mem_bank[796] = 'h00 ; mem_bank[797] = 'h6e ; mem_bank[798] = 'h65 ; mem_bank[799] = 'h00 ; 
       mem_bank[800] = 'h67 ; mem_bank[801] = 'h65 ; mem_bank[802] = 'h00 ; mem_bank[803] = 'h76 ; mem_bank[804] = 'h65 ; mem_bank[805] = 'h00 ; mem_bank[806] = 'h78 ; mem_bank[807] = 'h6e ; mem_bank[808] = 'h66 ; mem_bank[809] = 'h6e ; 
       mem_bank[810] = 'h75 ; mem_bank[811] = 'h65 ; mem_bank[812] = 'h00 ; mem_bank[813] = 'h69 ; mem_bank[814] = 'h65 ; mem_bank[815] = 'h00 ; mem_bank[816] = 'h65 ; mem_bank[817] = 'h00 ; mem_bank[818] = 'h65 ; mem_bank[819] = 'h00 ; 
       mem_bank[820] = 'h6e ; mem_bank[821] = 'h6e ; mem_bank[822] = 'h00 ; mem_bank[823] = 'h67 ; mem_bank[824] = 'h00 ; mem_bank[825] = 'h76 ; mem_bank[826] = 'h00 ; mem_bank[827] = 'h78 ; mem_bank[828] = 'h76 ; mem_bank[829] = 'h00 ; 
       mem_bank[830] = 'h75 ; mem_bank[831] = 'h00 ; mem_bank[832] = 'h72 ; mem_bank[833] = 'h00 ; mem_bank[834] = 'h6f ; mem_bank[835] = 'h65 ; mem_bank[836] = 'h00 ; mem_bank[837] = 'h00 ; mem_bank[838] = 'h69 ; mem_bank[839] = 'h6f ; 
       mem_bank[840] = 'h00 ; mem_bank[841] = 'h75 ; mem_bank[842] = 'h65 ; mem_bank[843] = 'h00 ; mem_bank[844] = 'h6c ; mem_bank[845] = 'h6e ; mem_bank[846] = 'h00 ; mem_bank[847] = 'h69 ; mem_bank[848] = 'h6f ; mem_bank[849] = 'h00 ; 
       mem_bank[850] = 'h6f ; mem_bank[851] = 'h6e ; mem_bank[852] = 'h00 ; mem_bank[853] = 'h68 ; mem_bank[854] = 'h61 ; mem_bank[855] = 'h00 ; mem_bank[856] = 'h0d ; mem_bank[857] = 'h0d ; mem_bank[858] = 'h0d ; mem_bank[859] = 'h0d ; 
       mem_bank[860] = 'h0c ; mem_bank[861] = 'h0c ; mem_bank[862] = 'h0c ; mem_bank[863] = 'h0c ; mem_bank[864] = 'h0c ; mem_bank[865] = 'h0c ; mem_bank[866] = 'h0c ; mem_bank[867] = 'h0c ; mem_bank[868] = 'h0c ; mem_bank[869] = 'h0c ; 
       mem_bank[870] = 'h0c ; mem_bank[871] = 'h0c ; mem_bank[872] = 'h0c ; mem_bank[873] = 'h0c ; mem_bank[874] = 'h0c ; mem_bank[875] = 'h0c ; mem_bank[876] = 'h0d ; mem_bank[877] = 'h0c ; mem_bank[878] = 'h0c ; mem_bank[879] = 'h0c ; 
       mem_bank[880] = 'h0c ; mem_bank[881] = 'h0c ; mem_bank[882] = 'h0c ; mem_bank[883] = 'h0c ; mem_bank[884] = 'h0c ; mem_bank[885] = 'h0c ; mem_bank[886] = 'h00 ;     
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
    input   [7:0]  data,
    input   [29:0]  wraddress,
    input   [29:0]  rdaddress_a,
    input   [29:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [29:0]  r_wraddress;
    reg [29:0]  r_rdaddress_a;
    reg [29:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:12345]  ;
    
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
       mem_bank[410] = 'h42 ; mem_bank[411] = 'he0 ; mem_bank[412] = 'h44 ; mem_bank[413] = 'h02 ; mem_bank[414] = 'h40 ; mem_bank[415] = 'h06 ; mem_bank[416] = 'h02 ; mem_bank[417] = 'h47 ; mem_bank[418] = 'h83 ; mem_bank[419] = 'h62 ; 
       mem_bank[420] = 'h40 ; mem_bank[421] = 'hc7 ; mem_bank[422] = 'h00 ; mem_bank[423] = 'h62 ; mem_bank[424] = 'h62 ; mem_bank[425] = 'ha2 ; mem_bank[426] = 'hc6 ; mem_bank[427] = 'hc1 ; mem_bank[428] = 'h04 ; mem_bank[429] = 'h02 ; 
       mem_bank[430] = 'he0 ; mem_bank[431] = 'h42 ; mem_bank[432] = 'h80 ; mem_bank[433] = 'h02 ; mem_bank[434] = 'h40 ; mem_bank[435] = 'h05 ; mem_bank[436] = 'h02 ; mem_bank[437] = 'h48 ; mem_bank[438] = 'h07 ; mem_bank[439] = 'he7 ; 
       mem_bank[440] = 'ha8 ; mem_bank[441] = 'hc7 ; mem_bank[442] = 'h00 ; mem_bank[443] = 'h09 ; mem_bank[444] = 'h03 ; mem_bank[445] = 'h43 ; mem_bank[446] = 'h02 ; mem_bank[447] = 'hc2 ; mem_bank[448] = 'h42 ; mem_bank[449] = 'h82 ; 
       mem_bank[450] = 'ha5 ; mem_bank[451] = 'ha1 ; mem_bank[452] = 'h60 ; mem_bank[453] = 'h02 ; mem_bank[454] = 'he0 ; mem_bank[455] = 'h42 ; mem_bank[456] = 'hbd ; mem_bank[457] = 'hbf ; mem_bank[458] = 'hb1 ; mem_bank[459] = 'hb0 ; 
       mem_bank[460] = 'h00 ; mem_bank[461] = 'h80 ; mem_bank[462] = 'h00 ; mem_bank[463] = 'h40 ; mem_bank[464] = 'h04 ; mem_bank[465] = 'h00 ; mem_bank[466] = 'h84 ; mem_bank[467] = 'h02 ; mem_bank[468] = 'h42 ; mem_bank[469] = 'h51 ; 
       mem_bank[470] = 'h40 ; mem_bank[471] = 'h11 ; mem_bank[472] = 'h02 ; mem_bank[473] = 'h42 ; mem_bank[474] = 'h62 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h05 ; mem_bank[477] = 'h03 ; mem_bank[478] = 'h63 ; mem_bank[479] = 'h10 ; 
       mem_bank[480] = 'h43 ; mem_bank[481] = 'h44 ; mem_bank[482] = 'h00 ; mem_bank[483] = 'h00 ; mem_bank[484] = 'h04 ; mem_bank[485] = 'h00 ; mem_bank[486] = 'h84 ; mem_bank[487] = 'h10 ; mem_bank[488] = 'h50 ; mem_bank[489] = 'h02 ; 
       mem_bank[490] = 'h50 ; mem_bank[491] = 'h02 ; mem_bank[492] = 'h50 ; mem_bank[493] = 'h02 ; mem_bank[494] = 'h50 ; mem_bank[495] = 'h02 ; mem_bank[496] = 'h62 ; mem_bank[497] = 'h03 ; mem_bank[498] = 'h70 ; mem_bank[499] = 'h03 ; 
       mem_bank[500] = 'h23 ; mem_bank[501] = 'h02 ; mem_bank[502] = 'h42 ; mem_bank[503] = 'h51 ; mem_bank[504] = 'h40 ; mem_bank[505] = 'h02 ; mem_bank[506] = 'h42 ; mem_bank[507] = 'h22 ; mem_bank[508] = 'h00 ; mem_bank[509] = 'h05 ; 
       mem_bank[510] = 'h03 ; mem_bank[511] = 'h63 ; mem_bank[512] = 'h10 ; mem_bank[513] = 'h43 ; mem_bank[514] = 'h44 ; mem_bank[515] = 'h00 ; mem_bank[516] = 'h00 ; mem_bank[517] = 'h04 ; mem_bank[518] = 'h00 ; mem_bank[519] = 'h84 ; 
       mem_bank[520] = 'h10 ; mem_bank[521] = 'h50 ; mem_bank[522] = 'h02 ; mem_bank[523] = 'h50 ; mem_bank[524] = 'h02 ; mem_bank[525] = 'h50 ; mem_bank[526] = 'h02 ; mem_bank[527] = 'h50 ; mem_bank[528] = 'h02 ; mem_bank[529] = 'h50 ; 
       mem_bank[530] = 'h02 ; mem_bank[531] = 'h22 ; mem_bank[532] = 'h02 ; mem_bank[533] = 'h42 ; mem_bank[534] = 'h51 ; mem_bank[535] = 'h40 ; mem_bank[536] = 'h02 ; mem_bank[537] = 'h04 ; mem_bank[538] = 'h00 ; mem_bank[539] = 'h84 ; 
       mem_bank[540] = 'h02 ; mem_bank[541] = 'h42 ; mem_bank[542] = 'h51 ; mem_bank[543] = 'h40 ; mem_bank[544] = 'h02 ; mem_bank[545] = 'h42 ; mem_bank[546] = 'h22 ; mem_bank[547] = 'h00 ; mem_bank[548] = 'h05 ; mem_bank[549] = 'h03 ; 
       mem_bank[550] = 'h63 ; mem_bank[551] = 'h02 ; mem_bank[552] = 'h02 ; mem_bank[553] = 'h43 ; mem_bank[554] = 'h44 ; mem_bank[555] = 'h00 ; mem_bank[556] = 'h00 ; mem_bank[557] = 'h00 ; mem_bank[558] = 'h04 ; mem_bank[559] = 'h10 ; 
       mem_bank[560] = 'h70 ; mem_bank[561] = 'h03 ; mem_bank[562] = 'h43 ; mem_bank[563] = 'h02 ; mem_bank[564] = 'h50 ; mem_bank[565] = 'h02 ; mem_bank[566] = 'h43 ; mem_bank[567] = 'h02 ; mem_bank[568] = 'h22 ; mem_bank[569] = 'h02 ; 
       mem_bank[570] = 'h42 ; mem_bank[571] = 'h51 ; mem_bank[572] = 'h40 ; mem_bank[573] = 'h02 ; mem_bank[574] = 'h04 ; mem_bank[575] = 'h00 ; mem_bank[576] = 'h84 ; mem_bank[577] = 'h02 ; mem_bank[578] = 'h42 ; mem_bank[579] = 'h51 ; 
       mem_bank[580] = 'h40 ; mem_bank[581] = 'h02 ; mem_bank[582] = 'h42 ; mem_bank[583] = 'h22 ; mem_bank[584] = 'h00 ; mem_bank[585] = 'h05 ; mem_bank[586] = 'h03 ; mem_bank[587] = 'h63 ; mem_bank[588] = 'h10 ; mem_bank[589] = 'h43 ; 
       mem_bank[590] = 'h44 ; mem_bank[591] = 'h00 ; mem_bank[592] = 'h00 ; mem_bank[593] = 'h04 ; mem_bank[594] = 'h00 ; mem_bank[595] = 'h84 ; mem_bank[596] = 'h10 ; mem_bank[597] = 'h70 ; mem_bank[598] = 'h03 ; mem_bank[599] = 'h43 ; 
       mem_bank[600] = 'h02 ; mem_bank[601] = 'h50 ; mem_bank[602] = 'h02 ; mem_bank[603] = 'h22 ; mem_bank[604] = 'h02 ; mem_bank[605] = 'h42 ; mem_bank[606] = 'h51 ; mem_bank[607] = 'h40 ; mem_bank[608] = 'h11 ; mem_bank[609] = 'h02 ; 
       mem_bank[610] = 'h42 ; mem_bank[611] = 'h62 ; mem_bank[612] = 'h00 ; mem_bank[613] = 'h05 ; mem_bank[614] = 'h03 ; mem_bank[615] = 'h63 ; mem_bank[616] = 'h10 ; mem_bank[617] = 'h43 ; mem_bank[618] = 'h44 ; mem_bank[619] = 'h00 ; 
       mem_bank[620] = 'h00 ; mem_bank[621] = 'h04 ; mem_bank[622] = 'h00 ; mem_bank[623] = 'h84 ; mem_bank[624] = 'h10 ; mem_bank[625] = 'h50 ; mem_bank[626] = 'h02 ; mem_bank[627] = 'h43 ; mem_bank[628] = 'h02 ; mem_bank[629] = 'h50 ; 
       mem_bank[630] = 'h02 ; mem_bank[631] = 'h50 ; mem_bank[632] = 'h02 ; mem_bank[633] = 'h22 ; mem_bank[634] = 'h22 ; mem_bank[635] = 'h40 ; mem_bank[636] = 'h22 ; mem_bank[637] = 'h04 ; mem_bank[638] = 'h00 ; mem_bank[639] = 'h84 ; 
       mem_bank[640] = 'h22 ; mem_bank[641] = 'h40 ; mem_bank[642] = 'h22 ; mem_bank[643] = 'h02 ; mem_bank[644] = 'h42 ; mem_bank[645] = 'h22 ; mem_bank[646] = 'h00 ; mem_bank[647] = 'h05 ; mem_bank[648] = 'h03 ; mem_bank[649] = 'h63 ; 
       mem_bank[650] = 'h02 ; mem_bank[651] = 'h02 ; mem_bank[652] = 'h43 ; mem_bank[653] = 'h44 ; mem_bank[654] = 'h00 ; mem_bank[655] = 'h00 ; mem_bank[656] = 'h00 ; mem_bank[657] = 'h04 ; mem_bank[658] = 'h10 ; mem_bank[659] = 'h50 ; 
       mem_bank[660] = 'h02 ; mem_bank[661] = 'h50 ; mem_bank[662] = 'h02 ; mem_bank[663] = 'h50 ; mem_bank[664] = 'h02 ; mem_bank[665] = 'h22 ; mem_bank[666] = 'h22 ; mem_bank[667] = 'h40 ; mem_bank[668] = 'h02 ; mem_bank[669] = 'h04 ; 
       mem_bank[670] = 'h00 ; mem_bank[671] = 'h84 ; mem_bank[672] = 'h22 ; mem_bank[673] = 'h40 ; mem_bank[674] = 'h22 ; mem_bank[675] = 'h02 ; mem_bank[676] = 'h42 ; mem_bank[677] = 'h22 ; mem_bank[678] = 'h00 ; mem_bank[679] = 'h05 ; 
       mem_bank[680] = 'h03 ; mem_bank[681] = 'h63 ; mem_bank[682] = 'h10 ; mem_bank[683] = 'h43 ; mem_bank[684] = 'h44 ; mem_bank[685] = 'h00 ; mem_bank[686] = 'h00 ; mem_bank[687] = 'h04 ; mem_bank[688] = 'h00 ; mem_bank[689] = 'h84 ; 
       mem_bank[690] = 'h10 ; mem_bank[691] = 'h50 ; mem_bank[692] = 'h02 ; mem_bank[693] = 'h50 ; mem_bank[694] = 'h02 ; mem_bank[695] = 'h22 ; mem_bank[696] = 'h22 ; mem_bank[697] = 'h40 ; mem_bank[698] = 'h22 ; mem_bank[699] = 'h02 ; 
       mem_bank[700] = 'h42 ; mem_bank[701] = 'h22 ; mem_bank[702] = 'h00 ; mem_bank[703] = 'h05 ; mem_bank[704] = 'h03 ; mem_bank[705] = 'h63 ; mem_bank[706] = 'h10 ; mem_bank[707] = 'h43 ; mem_bank[708] = 'h44 ; mem_bank[709] = 'h00 ; 
       mem_bank[710] = 'h00 ; mem_bank[711] = 'h04 ; mem_bank[712] = 'h00 ; mem_bank[713] = 'h84 ; mem_bank[714] = 'h10 ; mem_bank[715] = 'h50 ; mem_bank[716] = 'h02 ; mem_bank[717] = 'h50 ; mem_bank[718] = 'h02 ; mem_bank[719] = 'h22 ; 
       mem_bank[720] = 'h22 ; mem_bank[721] = 'h40 ; mem_bank[722] = 'h03 ; mem_bank[723] = 'h02 ; mem_bank[724] = 'h42 ; mem_bank[725] = 'h22 ; mem_bank[726] = 'h00 ; mem_bank[727] = 'h05 ; mem_bank[728] = 'h63 ; mem_bank[729] = 'h02 ; 
       mem_bank[730] = 'h02 ; mem_bank[731] = 'h43 ; mem_bank[732] = 'h44 ; mem_bank[733] = 'h00 ; mem_bank[734] = 'h00 ; mem_bank[735] = 'h00 ; mem_bank[736] = 'h04 ; mem_bank[737] = 'h10 ; mem_bank[738] = 'h50 ; mem_bank[739] = 'h02 ; 
       mem_bank[740] = 'h22 ; mem_bank[741] = 'h03 ; mem_bank[742] = 'h63 ; mem_bank[743] = 'h11 ; mem_bank[744] = 'h43 ; mem_bank[745] = 'h44 ; mem_bank[746] = 'h00 ; mem_bank[747] = 'h00 ; mem_bank[748] = 'h00 ; mem_bank[749] = 'h04 ; 
       mem_bank[750] = 'h00 ; mem_bank[751] = 'h04 ; mem_bank[752] = 'hbf ; mem_bank[753] = 'hb1 ; mem_bank[754] = 'hb0 ; mem_bank[755] = 'he0 ; mem_bank[756] = 'hbd ; mem_bank[757] = 'hbd ; mem_bank[758] = 'hbf ; mem_bank[759] = 'hb0 ; 
       mem_bank[760] = 'h10 ; mem_bank[761] = 'h00 ; mem_bank[762] = 'h00 ; mem_bank[763] = 'h10 ; mem_bank[764] = 'h00 ; mem_bank[765] = 'h02 ; mem_bank[766] = 'he0 ; mem_bank[767] = 'h00 ; mem_bank[768] = 'h00 ; mem_bank[769] = 'h00 ; 
       mem_bank[770] = 'h00 ; mem_bank[771] = 'h00 ; mem_bank[772] = 'h00 ; mem_bank[773] = 'h00 ; mem_bank[774] = 'h68 ; mem_bank[775] = 'h69 ; mem_bank[776] = 'h49 ; mem_bank[777] = 'h38 ; mem_bank[778] = 'h4f ; mem_bank[779] = 'h4f ; 
       mem_bank[780] = 'h52 ; mem_bank[781] = 'h69 ; mem_bank[782] = 'h79 ; mem_bank[783] = 'h69 ; mem_bank[784] = 'h79 ; mem_bank[785] = 'h65 ; mem_bank[786] = 'h74 ; mem_bank[787] = 'h69 ; mem_bank[788] = 'h00 ; mem_bank[789] = 'h69 ; 
       mem_bank[790] = 'h00 ; mem_bank[791] = 'h6f ; mem_bank[792] = 'h00 ; mem_bank[793] = 'h68 ; mem_bank[794] = 'h79 ; mem_bank[795] = 'h77 ; mem_bank[796] = 'h79 ; mem_bank[797] = 'h69 ; mem_bank[798] = 'h65 ; mem_bank[799] = 'h00 ; 
       mem_bank[800] = 'h69 ; mem_bank[801] = 'h65 ; mem_bank[802] = 'h00 ; mem_bank[803] = 'h65 ; mem_bank[804] = 'h74 ; mem_bank[805] = 'h00 ; mem_bank[806] = 'h69 ; mem_bank[807] = 'h65 ; mem_bank[808] = 'h69 ; mem_bank[809] = 'h65 ; 
       mem_bank[810] = 'h6f ; mem_bank[811] = 'h65 ; mem_bank[812] = 'h00 ; mem_bank[813] = 'h68 ; mem_bank[814] = 'h65 ; mem_bank[815] = 'h00 ; mem_bank[816] = 'h77 ; mem_bank[817] = 'h65 ; mem_bank[818] = 'h6c ; mem_bank[819] = 'h6e ; 
       mem_bank[820] = 'h65 ; mem_bank[821] = 'h69 ; mem_bank[822] = 'h00 ; mem_bank[823] = 'h69 ; mem_bank[824] = 'h00 ; mem_bank[825] = 'h65 ; mem_bank[826] = 'h00 ; mem_bank[827] = 'h69 ; mem_bank[828] = 'h69 ; mem_bank[829] = 'h00 ; 
       mem_bank[830] = 'h6f ; mem_bank[831] = 'h00 ; mem_bank[832] = 'h68 ; mem_bank[833] = 'h00 ; mem_bank[834] = 'h77 ; mem_bank[835] = 'h6e ; mem_bank[836] = 'h00 ; mem_bank[837] = 'h20 ; mem_bank[838] = 'h62 ; mem_bank[839] = 'h69 ; 
       mem_bank[840] = 'h00 ; mem_bank[841] = 'h68 ; mem_bank[842] = 'h72 ; mem_bank[843] = 'h00 ; mem_bank[844] = 'h69 ; mem_bank[845] = 'h6f ; mem_bank[846] = 'h00 ; mem_bank[847] = 'h6d ; mem_bank[848] = 'h69 ; mem_bank[849] = 'h00 ; 
       mem_bank[850] = 'h68 ; mem_bank[851] = 'h61 ; mem_bank[852] = 'h00 ; mem_bank[853] = 'h74 ; mem_bank[854] = 'h73 ; mem_bank[855] = 'h20 ; mem_bank[856] = 'h00 ; mem_bank[857] = 'h00 ; mem_bank[858] = 'h00 ; mem_bank[859] = 'h00 ; 
       mem_bank[860] = 'h00 ; mem_bank[861] = 'h00 ; mem_bank[862] = 'h00 ; mem_bank[863] = 'h00 ; mem_bank[864] = 'h00 ; mem_bank[865] = 'h00 ; mem_bank[866] = 'h00 ; mem_bank[867] = 'h00 ; mem_bank[868] = 'h00 ; mem_bank[869] = 'h00 ; 
       mem_bank[870] = 'h00 ; mem_bank[871] = 'h00 ; mem_bank[872] = 'h00 ; mem_bank[873] = 'h00 ; mem_bank[874] = 'h00 ; mem_bank[875] = 'h00 ; mem_bank[876] = 'h00 ; mem_bank[877] = 'h00 ; mem_bank[878] = 'h00 ; mem_bank[879] = 'h00 ; 
       mem_bank[880] = 'h00 ; mem_bank[881] = 'h00 ; mem_bank[882] = 'h00 ; mem_bank[883] = 'h00 ; mem_bank[884] = 'h00 ; mem_bank[885] = 'h00 ; mem_bank[886] = 'h00 ;     
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
    input   [7:0]  data,
    input   [29:0]  wraddress,
    input   [29:0]  rdaddress_a,
    input   [29:0]  rdaddress_b,
    input     wren,
    input     clock,
    output  [7:0]  qa,
    output  [7:0]  qb
    );

    reg [7:0]  r_data;
    reg [29:0]  r_wraddress;
    reg [29:0]  r_rdaddress_a;
    reg [29:0]  r_rdaddress_b;
    reg   r_wren;
    reg [7:0] mem_bank  [0:12345]  ;
    
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
       mem_bank[410] = 'h34 ; mem_bank[411] = 'h03 ; mem_bank[412] = 'ha0 ; mem_bank[413] = 'h3c ; mem_bank[414] = 'ha0 ; mem_bank[415] = 'h24 ; mem_bank[416] = 'h3c ; mem_bank[417] = 'h24 ; mem_bank[418] = 'h30 ; mem_bank[419] = 'h28 ; 
       mem_bank[420] = 'h10 ; mem_bank[421] = 'h00 ; mem_bank[422] = 'h10 ; mem_bank[423] = 'h24 ; mem_bank[424] = 'h24 ; mem_bank[425] = 'ha0 ; mem_bank[426] = 'h24 ; mem_bank[427] = 'h04 ; mem_bank[428] = 'h00 ; mem_bank[429] = 'h3c ; 
       mem_bank[430] = 'h03 ; mem_bank[431] = 'h24 ; mem_bank[432] = 'h00 ; mem_bank[433] = 'h3c ; mem_bank[434] = 'ha0 ; mem_bank[435] = 'h24 ; mem_bank[436] = 'h3c ; mem_bank[437] = 'h24 ; mem_bank[438] = 'h3c ; mem_bank[439] = 'h34 ; 
       mem_bank[440] = 'h00 ; mem_bank[441] = 'h00 ; mem_bank[442] = 'h00 ; mem_bank[443] = 'h00 ; mem_bank[444] = 'h00 ; mem_bank[445] = 'h00 ; mem_bank[446] = 'h00 ; mem_bank[447] = 'h00 ; mem_bank[448] = 'h24 ; mem_bank[449] = 'ha0 ; 
       mem_bank[450] = 'h24 ; mem_bank[451] = 'h04 ; mem_bank[452] = 'h00 ; mem_bank[453] = 'h3c ; mem_bank[454] = 'h03 ; mem_bank[455] = 'h24 ; mem_bank[456] = 'h27 ; mem_bank[457] = 'haf ; mem_bank[458] = 'haf ; mem_bank[459] = 'haf ; 
       mem_bank[460] = 'h0c ; mem_bank[461] = 'h00 ; mem_bank[462] = 'h0c ; mem_bank[463] = 'h00 ; mem_bank[464] = 'h3c ; mem_bank[465] = 'h0c ; mem_bank[466] = 'h24 ; mem_bank[467] = 'h3c ; mem_bank[468] = 'h34 ; mem_bank[469] = 'h00 ; 
       mem_bank[470] = 'h10 ; mem_bank[471] = 'h00 ; mem_bank[472] = 'h3c ; mem_bank[473] = 'h34 ; mem_bank[474] = 'h00 ; mem_bank[475] = 'h00 ; mem_bank[476] = 'h00 ; mem_bank[477] = 'h3c ; mem_bank[478] = 'h24 ; mem_bank[479] = 'h00 ; 
       mem_bank[480] = 'h00 ; mem_bank[481] = 'h8c ; mem_bank[482] = 'h0c ; mem_bank[483] = 'h00 ; mem_bank[484] = 'h3c ; mem_bank[485] = 'h0c ; mem_bank[486] = 'h24 ; mem_bank[487] = 'h00 ; mem_bank[488] = 'h00 ; mem_bank[489] = 'h00 ; 
       mem_bank[490] = 'h00 ; mem_bank[491] = 'h00 ; mem_bank[492] = 'h00 ; mem_bank[493] = 'h00 ; mem_bank[494] = 'h00 ; mem_bank[495] = 'h00 ; mem_bank[496] = 'h00 ; mem_bank[497] = 'h00 ; mem_bank[498] = 'h00 ; mem_bank[499] = 'h00 ; 
       mem_bank[500] = 'h02 ; mem_bank[501] = 'h3c ; mem_bank[502] = 'h34 ; mem_bank[503] = 'h00 ; mem_bank[504] = 'h10 ; mem_bank[505] = 'h3c ; mem_bank[506] = 'h34 ; mem_bank[507] = 'h02 ; mem_bank[508] = 'h00 ; mem_bank[509] = 'h00 ; 
       mem_bank[510] = 'h3c ; mem_bank[511] = 'h24 ; mem_bank[512] = 'h00 ; mem_bank[513] = 'h00 ; mem_bank[514] = 'h8c ; mem_bank[515] = 'h0c ; mem_bank[516] = 'h00 ; mem_bank[517] = 'h3c ; mem_bank[518] = 'h0c ; mem_bank[519] = 'h24 ; 
       mem_bank[520] = 'h00 ; mem_bank[521] = 'h00 ; mem_bank[522] = 'h00 ; mem_bank[523] = 'h00 ; mem_bank[524] = 'h00 ; mem_bank[525] = 'h00 ; mem_bank[526] = 'h00 ; mem_bank[527] = 'h00 ; mem_bank[528] = 'h00 ; mem_bank[529] = 'h00 ; 
       mem_bank[530] = 'h00 ; mem_bank[531] = 'h02 ; mem_bank[532] = 'h3c ; mem_bank[533] = 'h34 ; mem_bank[534] = 'h00 ; mem_bank[535] = 'h14 ; mem_bank[536] = 'h3c ; mem_bank[537] = 'h3c ; mem_bank[538] = 'h0c ; mem_bank[539] = 'h24 ; 
       mem_bank[540] = 'h3c ; mem_bank[541] = 'h34 ; mem_bank[542] = 'h00 ; mem_bank[543] = 'h10 ; mem_bank[544] = 'h3c ; mem_bank[545] = 'h34 ; mem_bank[546] = 'h02 ; mem_bank[547] = 'h00 ; mem_bank[548] = 'h00 ; mem_bank[549] = 'h3c ; 
       mem_bank[550] = 'h24 ; mem_bank[551] = 'h26 ; mem_bank[552] = 'h00 ; mem_bank[553] = 'h00 ; mem_bank[554] = 'h8c ; mem_bank[555] = 'h0c ; mem_bank[556] = 'h00 ; mem_bank[557] = 'h0c ; mem_bank[558] = 'h24 ; mem_bank[559] = 'h00 ; 
       mem_bank[560] = 'h00 ; mem_bank[561] = 'h00 ; mem_bank[562] = 'h00 ; mem_bank[563] = 'h00 ; mem_bank[564] = 'h00 ; mem_bank[565] = 'h00 ; mem_bank[566] = 'h00 ; mem_bank[567] = 'h00 ; mem_bank[568] = 'h02 ; mem_bank[569] = 'h3c ; 
       mem_bank[570] = 'h34 ; mem_bank[571] = 'h00 ; mem_bank[572] = 'h14 ; mem_bank[573] = 'h3c ; mem_bank[574] = 'h3c ; mem_bank[575] = 'h0c ; mem_bank[576] = 'h24 ; mem_bank[577] = 'h3c ; mem_bank[578] = 'h34 ; mem_bank[579] = 'h00 ; 
       mem_bank[580] = 'h10 ; mem_bank[581] = 'h3c ; mem_bank[582] = 'h34 ; mem_bank[583] = 'h02 ; mem_bank[584] = 'h00 ; mem_bank[585] = 'h00 ; mem_bank[586] = 'h3c ; mem_bank[587] = 'h24 ; mem_bank[588] = 'h00 ; mem_bank[589] = 'h00 ; 
       mem_bank[590] = 'h8c ; mem_bank[591] = 'h0c ; mem_bank[592] = 'h00 ; mem_bank[593] = 'h3c ; mem_bank[594] = 'h0c ; mem_bank[595] = 'h24 ; mem_bank[596] = 'h00 ; mem_bank[597] = 'h00 ; mem_bank[598] = 'h00 ; mem_bank[599] = 'h00 ; 
       mem_bank[600] = 'h00 ; mem_bank[601] = 'h00 ; mem_bank[602] = 'h00 ; mem_bank[603] = 'h02 ; mem_bank[604] = 'h3c ; mem_bank[605] = 'h34 ; mem_bank[606] = 'h00 ; mem_bank[607] = 'h10 ; mem_bank[608] = 'h00 ; mem_bank[609] = 'h3c ; 
       mem_bank[610] = 'h34 ; mem_bank[611] = 'h00 ; mem_bank[612] = 'h00 ; mem_bank[613] = 'h00 ; mem_bank[614] = 'h3c ; mem_bank[615] = 'h24 ; mem_bank[616] = 'h00 ; mem_bank[617] = 'h00 ; mem_bank[618] = 'h8c ; mem_bank[619] = 'h0c ; 
       mem_bank[620] = 'h00 ; mem_bank[621] = 'h3c ; mem_bank[622] = 'h0c ; mem_bank[623] = 'h24 ; mem_bank[624] = 'h00 ; mem_bank[625] = 'h00 ; mem_bank[626] = 'h00 ; mem_bank[627] = 'h00 ; mem_bank[628] = 'h00 ; mem_bank[629] = 'h00 ; 
       mem_bank[630] = 'h00 ; mem_bank[631] = 'h00 ; mem_bank[632] = 'h00 ; mem_bank[633] = 'h02 ; mem_bank[634] = 'h2e ; mem_bank[635] = 'h10 ; mem_bank[636] = 'h2e ; mem_bank[637] = 'h3c ; mem_bank[638] = 'h0c ; mem_bank[639] = 'h24 ; 
       mem_bank[640] = 'h2e ; mem_bank[641] = 'h14 ; mem_bank[642] = 'h2e ; mem_bank[643] = 'h3c ; mem_bank[644] = 'h34 ; mem_bank[645] = 'h02 ; mem_bank[646] = 'h00 ; mem_bank[647] = 'h00 ; mem_bank[648] = 'h3c ; mem_bank[649] = 'h24 ; 
       mem_bank[650] = 'h26 ; mem_bank[651] = 'h00 ; mem_bank[652] = 'h00 ; mem_bank[653] = 'h8c ; mem_bank[654] = 'h0c ; mem_bank[655] = 'h00 ; mem_bank[656] = 'h0c ; mem_bank[657] = 'h24 ; mem_bank[658] = 'h00 ; mem_bank[659] = 'h00 ; 
       mem_bank[660] = 'h00 ; mem_bank[661] = 'h00 ; mem_bank[662] = 'h00 ; mem_bank[663] = 'h00 ; mem_bank[664] = 'h00 ; mem_bank[665] = 'h02 ; mem_bank[666] = 'h2e ; mem_bank[667] = 'h10 ; mem_bank[668] = 'h3c ; mem_bank[669] = 'h3c ; 
       mem_bank[670] = 'h0c ; mem_bank[671] = 'h24 ; mem_bank[672] = 'h2e ; mem_bank[673] = 'h14 ; mem_bank[674] = 'h2e ; mem_bank[675] = 'h3c ; mem_bank[676] = 'h34 ; mem_bank[677] = 'h02 ; mem_bank[678] = 'h00 ; mem_bank[679] = 'h00 ; 
       mem_bank[680] = 'h3c ; mem_bank[681] = 'h24 ; mem_bank[682] = 'h00 ; mem_bank[683] = 'h00 ; mem_bank[684] = 'h8c ; mem_bank[685] = 'h0c ; mem_bank[686] = 'h00 ; mem_bank[687] = 'h3c ; mem_bank[688] = 'h0c ; mem_bank[689] = 'h24 ; 
       mem_bank[690] = 'h00 ; mem_bank[691] = 'h00 ; mem_bank[692] = 'h00 ; mem_bank[693] = 'h00 ; mem_bank[694] = 'h00 ; mem_bank[695] = 'h02 ; mem_bank[696] = 'h2e ; mem_bank[697] = 'h14 ; mem_bank[698] = 'h2e ; mem_bank[699] = 'h3c ; 
       mem_bank[700] = 'h34 ; mem_bank[701] = 'h02 ; mem_bank[702] = 'h00 ; mem_bank[703] = 'h00 ; mem_bank[704] = 'h3c ; mem_bank[705] = 'h24 ; mem_bank[706] = 'h00 ; mem_bank[707] = 'h00 ; mem_bank[708] = 'h8c ; mem_bank[709] = 'h0c ; 
       mem_bank[710] = 'h00 ; mem_bank[711] = 'h3c ; mem_bank[712] = 'h0c ; mem_bank[713] = 'h24 ; mem_bank[714] = 'h00 ; mem_bank[715] = 'h00 ; mem_bank[716] = 'h00 ; mem_bank[717] = 'h00 ; mem_bank[718] = 'h00 ; mem_bank[719] = 'h02 ; 
       mem_bank[720] = 'h2e ; mem_bank[721] = 'h14 ; mem_bank[722] = 'h3c ; mem_bank[723] = 'h3c ; mem_bank[724] = 'h34 ; mem_bank[725] = 'h02 ; mem_bank[726] = 'h00 ; mem_bank[727] = 'h00 ; mem_bank[728] = 'h24 ; mem_bank[729] = 'h26 ; 
       mem_bank[730] = 'h00 ; mem_bank[731] = 'h00 ; mem_bank[732] = 'h8c ; mem_bank[733] = 'h0c ; mem_bank[734] = 'h00 ; mem_bank[735] = 'h0c ; mem_bank[736] = 'h24 ; mem_bank[737] = 'h00 ; mem_bank[738] = 'h00 ; mem_bank[739] = 'h00 ; 
       mem_bank[740] = 'h02 ; mem_bank[741] = 'h3c ; mem_bank[742] = 'h24 ; mem_bank[743] = 'h00 ; mem_bank[744] = 'h00 ; mem_bank[745] = 'h8c ; mem_bank[746] = 'h0c ; mem_bank[747] = 'h00 ; mem_bank[748] = 'h0c ; mem_bank[749] = 'h24 ; 
       mem_bank[750] = 'h0c ; mem_bank[751] = 'h24 ; mem_bank[752] = 'h8f ; mem_bank[753] = 'h8f ; mem_bank[754] = 'h8f ; mem_bank[755] = 'h03 ; mem_bank[756] = 'h27 ; mem_bank[757] = 'h27 ; mem_bank[758] = 'haf ; mem_bank[759] = 'haf ; 
       mem_bank[760] = 'h24 ; mem_bank[761] = 'h0c ; mem_bank[762] = 'h02 ; mem_bank[763] = 'h00 ; mem_bank[764] = 'h10 ; mem_bank[765] = 'h02 ; mem_bank[766] = 'h03 ; mem_bank[767] = 'h00 ; mem_bank[768] = 'h00 ; mem_bank[769] = 'h00 ; 
       mem_bank[770] = 'h00 ; mem_bank[771] = 'h00 ; mem_bank[772] = 'h00 ; mem_bank[773] = 'h00 ; mem_bank[774] = 'h54 ; mem_bank[775] = 'h20 ; mem_bank[776] = 'h4d ; mem_bank[777] = 'h37 ; mem_bank[778] = 'h42 ; mem_bank[779] = 'h4c ; 
       mem_bank[780] = 'h45 ; mem_bank[781] = 'h6e ; mem_bank[782] = 'h74 ; mem_bank[783] = 'h65 ; mem_bank[784] = 'h74 ; mem_bank[785] = 'h73 ; mem_bank[786] = 'h6e ; mem_bank[787] = 'h73 ; mem_bank[788] = 'h79 ; mem_bank[789] = 'h66 ; 
       mem_bank[790] = 'h79 ; mem_bank[791] = 'h66 ; mem_bank[792] = 'h79 ; mem_bank[793] = 'h74 ; mem_bank[794] = 'h74 ; mem_bank[795] = 'h74 ; mem_bank[796] = 'h74 ; mem_bank[797] = 'h6e ; mem_bank[798] = 'h74 ; mem_bank[799] = 'h00 ; 
       mem_bank[800] = 'h65 ; mem_bank[801] = 'h74 ; mem_bank[802] = 'h00 ; mem_bank[803] = 'h73 ; mem_bank[804] = 'h6e ; mem_bank[805] = 'h6e ; mem_bank[806] = 'h73 ; mem_bank[807] = 'h65 ; mem_bank[808] = 'h66 ; mem_bank[809] = 'h65 ; 
       mem_bank[810] = 'h66 ; mem_bank[811] = 'h74 ; mem_bank[812] = 'h00 ; mem_bank[813] = 'h74 ; mem_bank[814] = 'h74 ; mem_bank[815] = 'h00 ; mem_bank[816] = 'h74 ; mem_bank[817] = 'h76 ; mem_bank[818] = 'h65 ; mem_bank[819] = 'h65 ; 
       mem_bank[820] = 'h74 ; mem_bank[821] = 'h6e ; mem_bank[822] = 'h00 ; mem_bank[823] = 'h65 ; mem_bank[824] = 'h74 ; mem_bank[825] = 'h73 ; mem_bank[826] = 'h6e ; mem_bank[827] = 'h73 ; mem_bank[828] = 'h66 ; mem_bank[829] = 'h00 ; 
       mem_bank[830] = 'h66 ; mem_bank[831] = 'h00 ; mem_bank[832] = 'h74 ; mem_bank[833] = 'h65 ; mem_bank[834] = 'h74 ; mem_bank[835] = 'h6f ; mem_bank[836] = 'h00 ; mem_bank[837] = 'h3a ; mem_bank[838] = 'h20 ; mem_bank[839] = 'h6c ; 
       mem_bank[840] = 'h20 ; mem_bank[841] = 'h20 ; mem_bank[842] = 'h64 ; mem_bank[843] = 'h20 ; mem_bank[844] = 'h6d ; mem_bank[845] = 'h69 ; mem_bank[846] = 'h00 ; mem_bank[847] = 'h20 ; mem_bank[848] = 'h6c ; mem_bank[849] = 'h20 ; 
       mem_bank[850] = 'h74 ; mem_bank[851] = 'h73 ; mem_bank[852] = 'h20 ; mem_bank[853] = 'h20 ; mem_bank[854] = 'h75 ; mem_bank[855] = 'h64 ; mem_bank[856] = 'h00 ; mem_bank[857] = 'h00 ; mem_bank[858] = 'h00 ; mem_bank[859] = 'h00 ; 
       mem_bank[860] = 'h00 ; mem_bank[861] = 'h00 ; mem_bank[862] = 'h00 ; mem_bank[863] = 'h00 ; mem_bank[864] = 'h00 ; mem_bank[865] = 'h00 ; mem_bank[866] = 'h00 ; mem_bank[867] = 'h00 ; mem_bank[868] = 'h00 ; mem_bank[869] = 'h00 ; 
       mem_bank[870] = 'h00 ; mem_bank[871] = 'h00 ; mem_bank[872] = 'h00 ; mem_bank[873] = 'h00 ; mem_bank[874] = 'h00 ; mem_bank[875] = 'h00 ; mem_bank[876] = 'h00 ; mem_bank[877] = 'h00 ; mem_bank[878] = 'h00 ; mem_bank[879] = 'h00 ; 
       mem_bank[880] = 'h00 ; mem_bank[881] = 'h00 ; mem_bank[882] = 'h00 ; mem_bank[883] = 'h00 ; mem_bank[884] = 'h00 ; mem_bank[885] = 'h00 ; mem_bank[886] = 'h00 ;     
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



