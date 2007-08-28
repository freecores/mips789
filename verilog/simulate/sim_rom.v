/////////////////////////////////////////////////////////////////////
////  Author: Liwei                                              ////
////                                                             ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: mcupro@yahoo.com or mcupro@opencores.org            ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/mips789    ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2006-2007 Liwei                               ////
////                         mcupro@yahoo.com                    ////
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

//this file is genated by a software written in C language...
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
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    initial begin
        mem_bank[0] = 'h00 ; mem_bank[1] = 'h80 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h98 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h94 ; mem_bank[6] = 'h00 ; mem_bank[7] = 'h94 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h2a ;
        mem_bank[10] = 'hfd ; mem_bank[11] = 'h04 ; mem_bank[12] = 'hd1 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h0e ; mem_bank[16] = 'hd8 ; mem_bank[17] = 'h20 ; mem_bank[18] = 'h1c ; mem_bank[19] = 'h18 ;
        mem_bank[20] = 'h14 ; mem_bank[21] = 'h10 ; mem_bank[22] = 'h25 ; mem_bank[23] = 'he8 ; mem_bank[24] = 'hcc ; mem_bank[25] = 'hcd ; mem_bank[26] = 'h02 ; mem_bank[27] = 'h1b ; mem_bank[28] = 'h0d ; mem_bank[29] = 'h12 ;
        mem_bank[30] = 'h30 ; mem_bank[31] = 'h30 ; mem_bank[32] = 'h18 ; mem_bank[33] = 'h12 ; mem_bank[34] = 'h23 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h19 ; mem_bank[37] = 'h10 ; mem_bank[38] = 'hc2 ; mem_bank[39] = 'hf2 ;
        mem_bank[40] = 'h00 ; mem_bank[41] = 'h20 ; mem_bank[42] = 'h1c ; mem_bank[43] = 'h18 ; mem_bank[44] = 'h14 ; mem_bank[45] = 'h10 ; mem_bank[46] = 'h08 ; mem_bank[47] = 'h28 ; mem_bank[48] = 'hff ; mem_bank[49] = 'h00 ;
        mem_bank[50] = 'h10 ; mem_bank[51] = 'h00 ; mem_bank[52] = 'h00 ; mem_bank[53] = 'h14 ; mem_bank[54] = 'h00 ; mem_bank[55] = 'h00 ; mem_bank[56] = 'h04 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h15 ; mem_bank[59] = 'hff ;
        mem_bank[60] = 'hff ; mem_bank[61] = 'hff ; mem_bank[62] = 'hff ; mem_bank[63] = 'h00 ; mem_bank[64] = 'h14 ; mem_bank[65] = 'h00 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'hfb ; mem_bank[68] = 'h08 ; mem_bank[69] = 'h00 ;
        mem_bank[70] = 'he8 ; mem_bank[71] = 'h14 ; mem_bank[72] = 'h10 ; mem_bank[73] = 'h25 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'hb0 ; mem_bank[76] = 'h80 ; mem_bank[77] = 'h21 ; mem_bank[78] = 'h00 ; mem_bank[79] = 'h01 ;
        mem_bank[80] = 'h39 ; mem_bank[81] = 'hfb ; mem_bank[82] = 'h80 ; mem_bank[83] = 'h10 ; mem_bank[84] = 'h10 ; mem_bank[85] = 'h18 ; mem_bank[86] = 'h38 ; mem_bank[87] = 'h14 ; mem_bank[88] = 'h24 ; mem_bank[89] = 'h20 ;
        mem_bank[90] = 'h00 ; mem_bank[91] = 'hb0 ; mem_bank[92] = 'h10 ; mem_bank[93] = 'h66 ; mem_bank[94] = 'h67 ; mem_bank[95] = 'h18 ; mem_bank[96] = 'h10 ; mem_bank[97] = 'h43 ; mem_bank[98] = 'hc3 ; mem_bank[99] = 'h23 ;
        mem_bank[100] = 'h14 ; mem_bank[101] = 'h18 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h80 ; mem_bank[104] = 'h21 ; mem_bank[105] = 'h00 ; mem_bank[106] = 'h01 ; mem_bank[107] = 'h18 ; mem_bank[108] = 'hf8 ; mem_bank[109] = 'h00 ;
        mem_bank[110] = 'h20 ; mem_bank[111] = 'h14 ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h40 ; mem_bank[114] = 'h1c ; mem_bank[115] = 'h59 ; mem_bank[116] = 'h00 ; mem_bank[117] = 'hb0 ; mem_bank[118] = 'h14 ; mem_bank[119] = 'h00 ;
        mem_bank[120] = 'h18 ; mem_bank[121] = 'h10 ; mem_bank[122] = 'h07 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h20 ; mem_bank[125] = 'h18 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h18 ; mem_bank[128] = 'h12 ; mem_bank[129] = 'h20 ;
        mem_bank[130] = 'h18 ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h80 ; mem_bank[133] = 'h21 ; mem_bank[134] = 'h00 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h18 ; mem_bank[137] = 'h12 ; mem_bank[138] = 'h20 ; mem_bank[139] = 'h00 ;
        mem_bank[140] = 'h21 ; mem_bank[141] = 'h20 ; mem_bank[142] = 'h1c ; mem_bank[143] = 'h00 ; mem_bank[144] = 'hff ; mem_bank[145] = 'h1c ; mem_bank[146] = 'h02 ; mem_bank[147] = 'h1a ; mem_bank[148] = 'h0d ; mem_bank[149] = 'hff ;
        mem_bank[150] = 'h04 ; mem_bank[151] = 'h00 ; mem_bank[152] = 'h02 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h0d ; mem_bank[155] = 'h12 ; mem_bank[156] = 'h10 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h20 ; mem_bank[159] = 'hfe ;
        mem_bank[160] = 'h1c ; mem_bank[161] = 'hff ; mem_bank[162] = 'h18 ; mem_bank[163] = 'hd8 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h14 ; mem_bank[166] = 'h00 ; mem_bank[167] = 'hf2 ; mem_bank[168] = 'h14 ; mem_bank[169] = 'h10 ;
        mem_bank[170] = 'h00 ; mem_bank[171] = 'h02 ; mem_bank[172] = 'h1a ; mem_bank[173] = 'h0d ; mem_bank[174] = 'hff ; mem_bank[175] = 'h04 ; mem_bank[176] = 'h00 ; mem_bank[177] = 'h02 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h0d ;
        mem_bank[180] = 'h12 ; mem_bank[181] = 'h24 ; mem_bank[182] = 'h10 ; mem_bank[183] = 'h21 ; mem_bank[184] = 'h20 ; mem_bank[185] = 'h10 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h02 ; mem_bank[188] = 'h1a ; mem_bank[189] = 'h0d ;
        mem_bank[190] = 'hff ; mem_bank[191] = 'h04 ; mem_bank[192] = 'h00 ; mem_bank[193] = 'h02 ; mem_bank[194] = 'h00 ; mem_bank[195] = 'h0d ; mem_bank[196] = 'h10 ; mem_bank[197] = 'h24 ; mem_bank[198] = 'h20 ; mem_bank[199] = 'h14 ;
        mem_bank[200] = 'h00 ; mem_bank[201] = 'h40 ; mem_bank[202] = 'h1c ; mem_bank[203] = 'haa ; mem_bank[204] = 'h00 ; mem_bank[205] = 'h14 ; mem_bank[206] = 'h10 ; mem_bank[207] = 'h08 ; mem_bank[208] = 'h18 ; mem_bank[209] = 'he8 ;
        mem_bank[210] = 'h10 ; mem_bank[211] = 'h46 ; mem_bank[212] = 'h00 ; mem_bank[213] = 'hfd ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h00 ; mem_bank[216] = 'h14 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h03 ;
        mem_bank[220] = 'h08 ; mem_bank[221] = 'h00 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'h00 ; mem_bank[225] = 'h00 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h10 ; mem_bank[229] = 'h38 ;
        mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h00 ; mem_bank[237] = 'h00 ; mem_bank[238] = 'h00 ; mem_bank[239] = 'h00 ;
        mem_bank[240] = 'h00 ; mem_bank[241] = 'h00 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ;
        mem_bank[250] = 'h00 ; mem_bank[251] = 'h00 ; mem_bank[252] = 'h00 ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h00 ; mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ;
        mem_bank[260] = 'h00 ; mem_bank[261] = 'h00 ; mem_bank[262] = 'h00 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'h00 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h00 ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h00 ;
        mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ; mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h00 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ;
        mem_bank[280] = 'h00 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h00 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ; mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h00 ; mem_bank[289] = 'h00 ;
        mem_bank[290] = 'h00 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h00 ;
    end
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
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    initial begin
        mem_bank[0] = 'h00 ; mem_bank[1] = 'h83 ; mem_bank[2] = 'h00 ; mem_bank[3] = 'h03 ; mem_bank[4] = 'h00 ; mem_bank[5] = 'h04 ;
        mem_bank[6] = 'h00 ; mem_bank[7] = 'h06 ; mem_bank[8] = 'h00 ; mem_bank[9] = 'h18 ; mem_bank[10] = 'hff ; mem_bank[11] = 'h00 ; mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h00 ;
        mem_bank[16] = 'hff ; mem_bank[17] = 'h00 ; mem_bank[18] = 'h00 ; mem_bank[19] = 'h00 ; mem_bank[20] = 'h00 ; mem_bank[21] = 'h00 ; mem_bank[22] = 'h90 ; mem_bank[23] = 'h03 ; mem_bank[24] = 'hcc ; mem_bank[25] = 'hcc ;
        mem_bank[26] = 'h00 ; mem_bank[27] = 'h00 ; mem_bank[28] = 'h00 ; mem_bank[29] = 'h80 ; mem_bank[30] = 'h00 ; mem_bank[31] = 'h00 ; mem_bank[32] = 'h00 ; mem_bank[33] = 'h28 ; mem_bank[34] = 'h90 ; mem_bank[35] = 'h00 ;
        mem_bank[36] = 'h00 ; mem_bank[37] = 'h28 ; mem_bank[38] = 'h88 ; mem_bank[39] = 'hff ; mem_bank[40] = 'h00 ; mem_bank[41] = 'h00 ; mem_bank[42] = 'h00 ; mem_bank[43] = 'h00 ; mem_bank[44] = 'h00 ; mem_bank[45] = 'h00 ;
        mem_bank[46] = 'h00 ; mem_bank[47] = 'h00 ; mem_bank[48] = 'h00 ; mem_bank[49] = 'h80 ; mem_bank[50] = 'h00 ; mem_bank[51] = 'h00 ; mem_bank[52] = 'h80 ; mem_bank[53] = 'h00 ; mem_bank[54] = 'h00 ; mem_bank[55] = 'h00 ;
        mem_bank[56] = 'h00 ; mem_bank[57] = 'h00 ; mem_bank[58] = 'h05 ; mem_bank[59] = 'hff ; mem_bank[60] = 'hff ; mem_bank[61] = 'hff ; mem_bank[62] = 'hff ; mem_bank[63] = 'h80 ; mem_bank[64] = 'h00 ; mem_bank[65] = 'h00 ;
        mem_bank[66] = 'h00 ; mem_bank[67] = 'h00 ; mem_bank[68] = 'h00 ; mem_bank[69] = 'h00 ; mem_bank[70] = 'hff ; mem_bank[71] = 'h00 ; mem_bank[72] = 'h00 ; mem_bank[73] = 'h18 ; mem_bank[74] = 'h00 ; mem_bank[75] = 'h03 ;
        mem_bank[76] = 'h10 ; mem_bank[77] = 'h10 ; mem_bank[78] = 'h00 ; mem_bank[79] = 'h00 ; mem_bank[80] = 'h00 ; mem_bank[81] = 'hff ; mem_bank[82] = 'h10 ; mem_bank[83] = 'h27 ; mem_bank[84] = 'h80 ; mem_bank[85] = 'h80 ;
        mem_bank[86] = 'h00 ; mem_bank[87] = 'h80 ; mem_bank[88] = 'h80 ; mem_bank[89] = 'h80 ; mem_bank[90] = 'h00 ; mem_bank[91] = 'h03 ; mem_bank[92] = 'h80 ; mem_bank[93] = 'h66 ; mem_bank[94] = 'h66 ; mem_bank[95] = 'h00 ;
        mem_bank[96] = 'h40 ; mem_bank[97] = 'h18 ; mem_bank[98] = 'h17 ; mem_bank[99] = 'h28 ; mem_bank[100] = 'h80 ; mem_bank[101] = 'h80 ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h10 ; mem_bank[104] = 'h10 ; mem_bank[105] = 'h00 ;
        mem_bank[106] = 'h00 ; mem_bank[107] = 'h80 ; mem_bank[108] = 'hff ; mem_bank[109] = 'h00 ; mem_bank[110] = 'h80 ; mem_bank[111] = 'h80 ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h10 ; mem_bank[114] = 'h80 ; mem_bank[115] = 'h00 ;
        mem_bank[116] = 'h00 ; mem_bank[117] = 'h03 ; mem_bank[118] = 'h80 ; mem_bank[119] = 'h00 ; mem_bank[120] = 'h80 ; mem_bank[121] = 'h80 ; mem_bank[122] = 'h00 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h80 ; mem_bank[125] = 'h80 ;
        mem_bank[126] = 'h00 ; mem_bank[127] = 'h00 ; mem_bank[128] = 'h40 ; mem_bank[129] = 'h80 ; mem_bank[130] = 'h80 ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h28 ; mem_bank[133] = 'h28 ; mem_bank[134] = 'h00 ; mem_bank[135] = 'h00 ;
        mem_bank[136] = 'h00 ; mem_bank[137] = 'h10 ; mem_bank[138] = 'h80 ; mem_bank[139] = 'h00 ; mem_bank[140] = 'h18 ; mem_bank[141] = 'h80 ; mem_bank[142] = 'h80 ; mem_bank[143] = 'h00 ; mem_bank[144] = 'hff ; mem_bank[145] = 'h80 ;
        mem_bank[146] = 'h00 ; mem_bank[147] = 'h00 ; mem_bank[148] = 'h00 ; mem_bank[149] = 'hff ; mem_bank[150] = 'h00 ; mem_bank[151] = 'h80 ; mem_bank[152] = 'h00 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h00 ; mem_bank[155] = 'h18 ;
        mem_bank[156] = 'h10 ; mem_bank[157] = 'h00 ; mem_bank[158] = 'h80 ; mem_bank[159] = 'hff ; mem_bank[160] = 'h80 ; mem_bank[161] = 'hff ; mem_bank[162] = 'h80 ; mem_bank[163] = 'hff ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h80 ;
        mem_bank[166] = 'h00 ; mem_bank[167] = 'hff ; mem_bank[168] = 'h80 ; mem_bank[169] = 'h80 ; mem_bank[170] = 'h00 ; mem_bank[171] = 'h00 ; mem_bank[172] = 'h00 ; mem_bank[173] = 'h00 ; mem_bank[174] = 'hff ; mem_bank[175] = 'h00 ;
        mem_bank[176] = 'h80 ; mem_bank[177] = 'h00 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h00 ; mem_bank[180] = 'h18 ; mem_bank[181] = 'h80 ; mem_bank[182] = 'h00 ; mem_bank[183] = 'h20 ; mem_bank[184] = 'h80 ; mem_bank[185] = 'h80 ;
        mem_bank[186] = 'h00 ; mem_bank[187] = 'h00 ; mem_bank[188] = 'h00 ; mem_bank[189] = 'h00 ; mem_bank[190] = 'hff ; mem_bank[191] = 'h00 ; mem_bank[192] = 'h80 ; mem_bank[193] = 'h00 ; mem_bank[194] = 'h00 ; mem_bank[195] = 'h00 ;
        mem_bank[196] = 'h10 ; mem_bank[197] = 'h80 ; mem_bank[198] = 'h80 ; mem_bank[199] = 'h80 ; mem_bank[200] = 'h00 ; mem_bank[201] = 'h10 ; mem_bank[202] = 'h80 ; mem_bank[203] = 'hff ; mem_bank[204] = 'h00 ; mem_bank[205] = 'h00 ;
        mem_bank[206] = 'h00 ; mem_bank[207] = 'h00 ; mem_bank[208] = 'h00 ; mem_bank[209] = 'hff ; mem_bank[210] = 'h00 ; mem_bank[211] = 'h00 ; mem_bank[212] = 'h00 ; mem_bank[213] = 'hff ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h80 ;
        mem_bank[216] = 'h00 ; mem_bank[217] = 'h00 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h00 ; mem_bank[220] = 'h00 ; mem_bank[221] = 'h00 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'h00 ; mem_bank[225] = 'h00 ;
        mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h27 ; mem_bank[229] = 'h00 ; mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ;
        mem_bank[236] = 'h00 ; mem_bank[237] = 'h00 ; mem_bank[238] = 'h00 ; mem_bank[239] = 'h00 ; mem_bank[240] = 'h00 ; mem_bank[241] = 'h00 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ;
        mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ; mem_bank[250] = 'h00 ; mem_bank[251] = 'h00 ; mem_bank[252] = 'h00 ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h00 ;
        mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ; mem_bank[260] = 'h00 ; mem_bank[261] = 'h00 ; mem_bank[262] = 'h00 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'h00 ;
        mem_bank[266] = 'h00 ; mem_bank[267] = 'h00 ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h00 ; mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ; mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h00 ;
        mem_bank[276] = 'h00 ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; mem_bank[280] = 'h00 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h00 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ;
        mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h00 ; mem_bank[289] = 'h00 ; mem_bank[290] = 'h00 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h00 ;
    end
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
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    initial begin
        mem_bank[0] = 'h1c ; mem_bank[1] = 'h9c ;
        mem_bank[2] = 'h04 ; mem_bank[3] = 'h84 ; mem_bank[4] = 'h05 ; mem_bank[5] = 'ha5 ; mem_bank[6] = 'h1d ; mem_bank[7] = 'hbd ; mem_bank[8] = 'h80 ; mem_bank[9] = 'h85 ; mem_bank[10] = 'h60 ; mem_bank[11] = 'h84 ;
        mem_bank[12] = 'h00 ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h00 ; mem_bank[16] = 'hbd ; mem_bank[17] = 'hbf ; mem_bank[18] = 'hb3 ; mem_bank[19] = 'hb2 ; mem_bank[20] = 'hb1 ; mem_bank[21] = 'hb0 ;
        mem_bank[22] = 'h80 ; mem_bank[23] = 'h11 ; mem_bank[24] = 'h13 ; mem_bank[25] = 'h73 ; mem_bank[26] = 'h20 ; mem_bank[27] = 'h51 ; mem_bank[28] = 'h07 ; mem_bank[29] = 'h00 ; mem_bank[30] = 'h00 ; mem_bank[31] = 'h04 ;
        mem_bank[32] = 'h11 ; mem_bank[33] = 'h00 ; mem_bank[34] = 'h45 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h33 ; mem_bank[37] = 'h00 ; mem_bank[38] = 'h05 ; mem_bank[39] = 'h20 ; mem_bank[40] = 'h00 ; mem_bank[41] = 'hbf ;
        mem_bank[42] = 'hb3 ; mem_bank[43] = 'hb2 ; mem_bank[44] = 'hb1 ; mem_bank[45] = 'hb0 ; mem_bank[46] = 'he0 ; mem_bank[47] = 'hbd ; mem_bank[48] = 'h84 ; mem_bank[49] = 'h02 ; mem_bank[50] = 'h42 ; mem_bank[51] = 'h44 ;
        mem_bank[52] = 'h03 ; mem_bank[53] = 'h63 ; mem_bank[54] = 'h62 ; mem_bank[55] = 'h00 ; mem_bank[56] = 'h42 ; mem_bank[57] = 'h62 ; mem_bank[58] = 'h02 ; mem_bank[59] = 'h03 ; mem_bank[60] = 'h42 ; mem_bank[61] = 'h43 ;
        mem_bank[62] = 'h42 ; mem_bank[63] = 'h03 ; mem_bank[64] = 'h63 ; mem_bank[65] = 'h62 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'h42 ; mem_bank[68] = 'he0 ; mem_bank[69] = 'h62 ; mem_bank[70] = 'hbd ; mem_bank[71] = 'hbf ;
        mem_bank[72] = 'hb0 ; mem_bank[73] = 'h00 ; mem_bank[74] = 'h02 ; mem_bank[75] = 'h44 ; mem_bank[76] = 'h03 ; mem_bank[77] = 'h44 ; mem_bank[78] = 'h40 ; mem_bank[79] = 'h63 ; mem_bank[80] = 'h62 ; mem_bank[81] = 'h40 ;
        mem_bank[82] = 'h03 ; mem_bank[83] = 'h02 ; mem_bank[84] = 'h82 ; mem_bank[85] = 'h80 ; mem_bank[86] = 'h02 ; mem_bank[87] = 'h82 ; mem_bank[88] = 'h80 ; mem_bank[89] = 'h80 ; mem_bank[90] = 'h02 ; mem_bank[91] = 'h46 ;
        mem_bank[92] = 'h82 ; mem_bank[93] = 'h03 ; mem_bank[94] = 'h63 ; mem_bank[95] = 'h43 ; mem_bank[96] = 'h00 ; mem_bank[97] = 'h08 ; mem_bank[98] = 'h02 ; mem_bank[99] = 'h62 ; mem_bank[100] = 'h84 ; mem_bank[101] = 'h83 ;
        mem_bank[102] = 'h00 ; mem_bank[103] = 'h03 ; mem_bank[104] = 'h46 ; mem_bank[105] = 'h45 ; mem_bank[106] = 'h63 ; mem_bank[107] = 'h83 ; mem_bank[108] = 'h64 ; mem_bank[109] = 'h00 ; mem_bank[110] = 'h80 ; mem_bank[111] = 'h82 ;
        mem_bank[112] = 'h00 ; mem_bank[113] = 'h02 ; mem_bank[114] = 'h82 ; mem_bank[115] = 'h40 ; mem_bank[116] = 'h02 ; mem_bank[117] = 'h50 ; mem_bank[118] = 'h82 ; mem_bank[119] = 'h00 ; mem_bank[120] = 'h82 ; mem_bank[121] = 'h87 ;
        mem_bank[122] = 'h00 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h83 ; mem_bank[125] = 'h82 ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h62 ; mem_bank[128] = 'h00 ; mem_bank[129] = 'h88 ; mem_bank[130] = 'h86 ; mem_bank[131] = 'h00 ;
        mem_bank[132] = 'h06 ; mem_bank[133] = 'hb0 ; mem_bank[134] = 'ha2 ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h47 ; mem_bank[137] = 'h00 ; mem_bank[138] = 'h83 ; mem_bank[139] = 'h00 ; mem_bank[140] = 'h43 ; mem_bank[141] = 'h83 ;
        mem_bank[142] = 'h84 ; mem_bank[143] = 'h00 ; mem_bank[144] = 'h82 ; mem_bank[145] = 'h82 ; mem_bank[146] = 'h40 ; mem_bank[147] = 'h62 ; mem_bank[148] = 'h07 ; mem_bank[149] = 'h01 ; mem_bank[150] = 'h41 ; mem_bank[151] = 'h01 ;
        mem_bank[152] = 'h61 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h06 ; mem_bank[155] = 'h00 ; mem_bank[156] = 'h00 ; mem_bank[157] = 'ha2 ; mem_bank[158] = 'h83 ; mem_bank[159] = 'h84 ; mem_bank[160] = 'h84 ; mem_bank[161] = 'hc6 ;
        mem_bank[162] = 'h86 ; mem_bank[163] = 'hc0 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h82 ; mem_bank[166] = 'h00 ; mem_bank[167] = 'h42 ; mem_bank[168] = 'h82 ; mem_bank[169] = 'h82 ; mem_bank[170] = 'h00 ; mem_bank[171] = 'h40 ;
        mem_bank[172] = 'h62 ; mem_bank[173] = 'h07 ; mem_bank[174] = 'h01 ; mem_bank[175] = 'h41 ; mem_bank[176] = 'h01 ; mem_bank[177] = 'h61 ; mem_bank[178] = 'h00 ; mem_bank[179] = 'h06 ; mem_bank[180] = 'h00 ; mem_bank[181] = 'h84 ;
        mem_bank[182] = 'h00 ; mem_bank[183] = 'h64 ; mem_bank[184] = 'h83 ; mem_bank[185] = 'h82 ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h40 ; mem_bank[188] = 'h62 ; mem_bank[189] = 'h07 ; mem_bank[190] = 'h01 ; mem_bank[191] = 'h41 ;
        mem_bank[192] = 'h01 ; mem_bank[193] = 'h61 ; mem_bank[194] = 'h00 ; mem_bank[195] = 'h06 ; mem_bank[196] = 'h00 ; mem_bank[197] = 'h82 ; mem_bank[198] = 'h80 ; mem_bank[199] = 'h82 ; mem_bank[200] = 'h00 ; mem_bank[201] = 'h02 ;
        mem_bank[202] = 'h82 ; mem_bank[203] = 'h40 ; mem_bank[204] = 'h00 ; mem_bank[205] = 'hbf ; mem_bank[206] = 'hb0 ; mem_bank[207] = 'he0 ; mem_bank[208] = 'hbd ; mem_bank[209] = 'hbd ; mem_bank[210] = 'hbf ; mem_bank[211] = 'h00 ;
        mem_bank[212] = 'h00 ; mem_bank[213] = 'h00 ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h03 ; mem_bank[216] = 'h63 ; mem_bank[217] = 'h62 ; mem_bank[218] = 'h00 ; mem_bank[219] = 'h42 ; mem_bank[220] = 'he0 ; mem_bank[221] = 'h62 ;
        mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'h00 ; mem_bank[225] = 'h00 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ; mem_bank[228] = 'h00 ; mem_bank[229] = 'h00 ; mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ;
        mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h00 ; mem_bank[237] = 'h00 ; mem_bank[238] = 'h00 ; mem_bank[239] = 'h00 ; mem_bank[240] = 'h00 ; mem_bank[241] = 'h00 ;
        mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ; mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ; mem_bank[250] = 'h00 ; mem_bank[251] = 'h00 ;
        mem_bank[252] = 'h00 ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h00 ; mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ; mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ; mem_bank[260] = 'h00 ; mem_bank[261] = 'h00 ;
        mem_bank[262] = 'h00 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'h00 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h00 ; mem_bank[268] = 'h00 ; mem_bank[269] = 'h00 ; mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ;
        mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h00 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h00 ; mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; mem_bank[280] = 'h00 ; mem_bank[281] = 'h00 ;
        mem_bank[282] = 'h00 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ; mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ; mem_bank[288] = 'h00 ; mem_bank[289] = 'h00 ; mem_bank[290] = 'h00 ; mem_bank[291] = 'h00 ;
        mem_bank[292] = 'h00 ; mem_bank[293] = 'h00 ;
    end
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
    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;
    initial begin
        mem_bank[0] = 'h3c ; mem_bank[1] = 'h37 ; mem_bank[2] = 'h3c ; mem_bank[3] = 'h34 ; mem_bank[4] = 'h3c ; mem_bank[5] = 'h34 ; mem_bank[6] = 'h3c ; mem_bank[7] = 'h37 ;
        mem_bank[8] = 'hac ; mem_bank[9] = 'h00 ; mem_bank[10] = 'h14 ; mem_bank[11] = 'h24 ; mem_bank[12] = 'h0c ; mem_bank[13] = 'h00 ; mem_bank[14] = 'h00 ; mem_bank[15] = 'h08 ; mem_bank[16] = 'h27 ; mem_bank[17] = 'haf ;
        mem_bank[18] = 'haf ; mem_bank[19] = 'haf ; mem_bank[20] = 'haf ; mem_bank[21] = 'haf ; mem_bank[22] = 'h00 ; mem_bank[23] = 'h24 ; mem_bank[24] = 'h3c ; mem_bank[25] = 'h36 ; mem_bank[26] = 'h16 ; mem_bank[27] = 'h02 ;
        mem_bank[28] = 'h00 ; mem_bank[29] = 'h00 ; mem_bank[30] = 'h0c ; mem_bank[31] = 'h26 ; mem_bank[32] = 'h02 ; mem_bank[33] = 'h00 ; mem_bank[34] = 'h02 ; mem_bank[35] = 'h00 ; mem_bank[36] = 'h02 ; mem_bank[37] = 'h00 ;
        mem_bank[38] = 'h00 ; mem_bank[39] = 'h16 ; mem_bank[40] = 'h00 ; mem_bank[41] = 'h8f ; mem_bank[42] = 'h8f ; mem_bank[43] = 'h8f ; mem_bank[44] = 'h8f ; mem_bank[45] = 'h8f ; mem_bank[46] = 'h03 ; mem_bank[47] = 'h27 ;
        mem_bank[48] = 'h30 ; mem_bank[49] = 'h3c ; mem_bank[50] = 'h34 ; mem_bank[51] = 'ha0 ; mem_bank[52] = 'h3c ; mem_bank[53] = 'h34 ; mem_bank[54] = 'h90 ; mem_bank[55] = 'h00 ; mem_bank[56] = 'h34 ; mem_bank[57] = 'ha0 ;
        mem_bank[58] = 'h24 ; mem_bank[59] = 'h24 ; mem_bank[60] = 'h24 ; mem_bank[61] = 'h14 ; mem_bank[62] = 'h24 ; mem_bank[63] = 'h3c ; mem_bank[64] = 'h34 ; mem_bank[65] = 'h90 ; mem_bank[66] = 'h00 ; mem_bank[67] = 'h30 ;
        mem_bank[68] = 'h03 ; mem_bank[69] = 'ha0 ; mem_bank[70] = 'h27 ; mem_bank[71] = 'haf ; mem_bank[72] = 'haf ; mem_bank[73] = 'h00 ; mem_bank[74] = 'h3c ; mem_bank[75] = 'h24 ; mem_bank[76] = 'h00 ; mem_bank[77] = 'h00 ;
        mem_bank[78] = 'hac ; mem_bank[79] = 'h24 ; mem_bank[80] = 'h28 ; mem_bank[81] = 'h14 ; mem_bank[82] = 'h00 ; mem_bank[83] = 'h24 ; mem_bank[84] = 'haf ; mem_bank[85] = 'haf ; mem_bank[86] = 'h24 ; mem_bank[87] = 'haf ;
        mem_bank[88] = 'haf ; mem_bank[89] = 'haf ; mem_bank[90] = 'h3c ; mem_bank[91] = 'h24 ; mem_bank[92] = 'h8f ; mem_bank[93] = 'h3c ; mem_bank[94] = 'h34 ; mem_bank[95] = 'h00 ; mem_bank[96] = 'h00 ; mem_bank[97] = 'h00 ;
        mem_bank[98] = 'h00 ; mem_bank[99] = 'h00 ; mem_bank[100] = 'h8f ; mem_bank[101] = 'h8f ; mem_bank[102] = 'h00 ; mem_bank[103] = 'h00 ; mem_bank[104] = 'h00 ; mem_bank[105] = 'hac ; mem_bank[106] = 'h24 ; mem_bank[107] = 'haf ;
        mem_bank[108] = 'h14 ; mem_bank[109] = 'h00 ; mem_bank[110] = 'haf ; mem_bank[111] = 'h8f ; mem_bank[112] = 'h00 ; mem_bank[113] = 'h00 ; mem_bank[114] = 'haf ; mem_bank[115] = 'h10 ; mem_bank[116] = 'h3c ; mem_bank[117] = 'h24 ;
        mem_bank[118] = 'h8f ; mem_bank[119] = 'h00 ; mem_bank[120] = 'haf ; mem_bank[121] = 'h8f ; mem_bank[122] = 'h10 ; mem_bank[123] = 'h00 ; mem_bank[124] = 'h8f ; mem_bank[125] = 'h8f ; mem_bank[126] = 'h00 ; mem_bank[127] = 'h00 ;
        mem_bank[128] = 'h00 ; mem_bank[129] = 'haf ; mem_bank[130] = 'h8f ; mem_bank[131] = 'h00 ; mem_bank[132] = 'h00 ; mem_bank[133] = 'h00 ; mem_bank[134] = 'h8c ; mem_bank[135] = 'h00 ; mem_bank[136] = 'h00 ; mem_bank[137] = 'h00 ;
        mem_bank[138] = 'h8f ; mem_bank[139] = 'h00 ; mem_bank[140] = 'h00 ; mem_bank[141] = 'haf ; mem_bank[142] = 'h8f ; mem_bank[143] = 'h00 ; mem_bank[144] = 'h24 ; mem_bank[145] = 'haf ; mem_bank[146] = 'h14 ; mem_bank[147] = 'h00 ;
        mem_bank[148] = 'h00 ; mem_bank[149] = 'h24 ; mem_bank[150] = 'h14 ; mem_bank[151] = 'h3c ; mem_bank[152] = 'h14 ; mem_bank[153] = 'h00 ; mem_bank[154] = 'h00 ; mem_bank[155] = 'h00 ; mem_bank[156] = 'h00 ; mem_bank[157] = 'hac ;
        mem_bank[158] = 'haf ; mem_bank[159] = 'h24 ; mem_bank[160] = 'haf ; mem_bank[161] = 'h24 ; mem_bank[162] = 'haf ; mem_bank[163] = 'h14 ; mem_bank[164] = 'h00 ; mem_bank[165] = 'h8f ; mem_bank[166] = 'h00 ; mem_bank[167] = 'h24 ;
        mem_bank[168] = 'haf ; mem_bank[169] = 'h8f ; mem_bank[170] = 'h00 ; mem_bank[171] = 'h14 ; mem_bank[172] = 'h00 ; mem_bank[173] = 'h00 ; mem_bank[174] = 'h24 ; mem_bank[175] = 'h14 ; mem_bank[176] = 'h3c ; mem_bank[177] = 'h14 ;
        mem_bank[178] = 'h00 ; mem_bank[179] = 'h00 ; mem_bank[180] = 'h00 ; mem_bank[181] = 'h8f ; mem_bank[182] = 'h0c ; mem_bank[183] = 'h00 ; mem_bank[184] = 'h8f ; mem_bank[185] = 'h8f ; mem_bank[186] = 'h00 ; mem_bank[187] = 'h14 ;
        mem_bank[188] = 'h00 ; mem_bank[189] = 'h00 ; mem_bank[190] = 'h24 ; mem_bank[191] = 'h14 ; mem_bank[192] = 'h3c ; mem_bank[193] = 'h14 ; mem_bank[194] = 'h00 ; mem_bank[195] = 'h00 ; mem_bank[196] = 'h00 ; mem_bank[197] = 'haf ;
        mem_bank[198] = 'haf ; mem_bank[199] = 'h8f ; mem_bank[200] = 'h00 ; mem_bank[201] = 'h00 ; mem_bank[202] = 'haf ; mem_bank[203] = 'h14 ; mem_bank[204] = 'h00 ; mem_bank[205] = 'h8f ; mem_bank[206] = 'h8f ; mem_bank[207] = 'h03 ;
        mem_bank[208] = 'h27 ; mem_bank[209] = 'h27 ; mem_bank[210] = 'haf ; mem_bank[211] = 'h0c ; mem_bank[212] = 'h00 ; mem_bank[213] = 'h10 ; mem_bank[214] = 'h00 ; mem_bank[215] = 'h3c ; mem_bank[216] = 'h34 ; mem_bank[217] = 'h90 ;
        mem_bank[218] = 'h00 ; mem_bank[219] = 'h34 ; mem_bank[220] = 'h03 ; mem_bank[221] = 'ha0 ; mem_bank[222] = 'h00 ; mem_bank[223] = 'h00 ; mem_bank[224] = 'h00 ; mem_bank[225] = 'h00 ; mem_bank[226] = 'h00 ; mem_bank[227] = 'h00 ;
        mem_bank[228] = 'h00 ; mem_bank[229] = 'h00 ; mem_bank[230] = 'h00 ; mem_bank[231] = 'h00 ; mem_bank[232] = 'h00 ; mem_bank[233] = 'h00 ; mem_bank[234] = 'h00 ; mem_bank[235] = 'h00 ; mem_bank[236] = 'h00 ; mem_bank[237] = 'h00 ;
        mem_bank[238] = 'h00 ; mem_bank[239] = 'h00 ; mem_bank[240] = 'h00 ; mem_bank[241] = 'h00 ; mem_bank[242] = 'h00 ; mem_bank[243] = 'h00 ; mem_bank[244] = 'h00 ; mem_bank[245] = 'h00 ; mem_bank[246] = 'h00 ; mem_bank[247] = 'h00 ;
        mem_bank[248] = 'h00 ; mem_bank[249] = 'h00 ; mem_bank[250] = 'h00 ; mem_bank[251] = 'h00 ; mem_bank[252] = 'h00 ; mem_bank[253] = 'h00 ; mem_bank[254] = 'h00 ; mem_bank[255] = 'h00 ; mem_bank[256] = 'h00 ; mem_bank[257] = 'h00 ;
        mem_bank[258] = 'h00 ; mem_bank[259] = 'h00 ; mem_bank[260] = 'h00 ; mem_bank[261] = 'h00 ; mem_bank[262] = 'h00 ; mem_bank[263] = 'h00 ; mem_bank[264] = 'h00 ; mem_bank[265] = 'h00 ; mem_bank[266] = 'h00 ; mem_bank[267] = 'h00 ;
        mem_bank[268] = 'h00 ; mem_bank[269] = 'h00 ; mem_bank[270] = 'h00 ; mem_bank[271] = 'h00 ; mem_bank[272] = 'h00 ; mem_bank[273] = 'h00 ; mem_bank[274] = 'h00 ; mem_bank[275] = 'h00 ; mem_bank[276] = 'h00 ; mem_bank[277] = 'h00 ;
        mem_bank[278] = 'h00 ; mem_bank[279] = 'h00 ; mem_bank[280] = 'h00 ; mem_bank[281] = 'h00 ; mem_bank[282] = 'h00 ; mem_bank[283] = 'h00 ; mem_bank[284] = 'h00 ; mem_bank[285] = 'h00 ; mem_bank[286] = 'h00 ; mem_bank[287] = 'h00 ;
        mem_bank[288] = 'h00 ; mem_bank[289] = 'h00 ; mem_bank[290] = 'h00 ; mem_bank[291] = 'h00 ; mem_bank[292] = 'h00 ; mem_bank[293] = 'h00 ;
    end
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



