/****************************************************************** 
 *                                                                * 
 *    Author: Liwei                                               * 
 *                                                                * 
 *    This file is part of the "mips789" project.                 * 
 *    Downloaded from:                                            * 
 *    http://www.opencores.org/pdownloads.cgi/list/mips789        * 
 *                                                                * 
 *    If you encountered any problem, please contact me via,      * 
 *    Email:mcupro@opencores.org  or mcupro@163.com               * 
 *                                                                * 
 ******************************************************************/
 
#include "stdio.h"
#include "stdlib.h"

#define MAX_LEN (1024*2)

/*Liwei 2007-8-29*/
 char HEX[]="0123456789ABCDEF" ;
 char hex[]="0123456789abcdef" ;


int print_module(FILE * ft){
    if (ft==NULL)return 0;
fprintf(ft,"//This file is only used for simulation.\nmodule sim_mem_array \n");
fprintf(ft,"    ( \n");
fprintf(ft,"        input clk, \n");
fprintf(ft,"        input [31:0] pc_i, \n");
fprintf(ft,"        output [31:0] ins_o, \n");
fprintf(ft,"        input [3:0] wren, \n");
fprintf(ft,"        input [31:0]din, \n");
fprintf(ft,"        input [31:0]data_addr_i, \n");
fprintf(ft,"        output [31:0]dout \n");
fprintf(ft,"    ); \n\n");
fprintf(ft,"    wire [29:0] data_addr,pc; \n");
fprintf(ft,"    wire [31:0]dout_w; \n");
fprintf(ft,"    assign dout = dout_w; \n");
fprintf(ft,"    assign data_addr=data_addr_i[31:2]; \n");
fprintf(ft,"    assign pc= pc_i[31:2]; \n\n");


fprintf(ft,"    sim_syn_ram3 ram3 ( \n");
fprintf(ft,"                     .data(din[31:24]), \n");
fprintf(ft,"                     .wraddress(data_addr), \n");
fprintf(ft,"                     .rdaddress_a(pc), \n");
fprintf(ft,"                     .rdaddress_b(data_addr), \n");
fprintf(ft,"                     .wren(wren[3]), \n");
fprintf(ft,"                     .clock(clk), \n");
fprintf(ft,"                     .qa(ins_o[31:24]), \n");
fprintf(ft,"                     .qb(dout_w[31:24]) \n");
fprintf(ft,"                 ); \n");

fprintf(ft,"    sim_syn_ram2 ram2( \n");
fprintf(ft,"                     .data(din[23:16]), \n");
fprintf(ft,"                     .wraddress(data_addr), \n");
fprintf(ft,"                     .rdaddress_a(pc), \n");
fprintf(ft,"                     .rdaddress_b(data_addr), \n");
fprintf(ft,"                     .wren(wren[2]), \n");
fprintf(ft,"                     .clock(clk), \n");
fprintf(ft,"                     .qa(ins_o[23:16]), \n");
fprintf(ft,"                     .qb(dout_w[23:16]) \n");
fprintf(ft,"                 ); \n");

fprintf(ft,"    sim_syn_ram1 ram1( \n");
fprintf(ft,"                     .data(din[15:8]), \n");
fprintf(ft,"                     .wraddress(data_addr), \n");
fprintf(ft,"                     .rdaddress_a(pc), \n");
fprintf(ft,"                     .rdaddress_b(data_addr), \n");
fprintf(ft,"                     .wren(wren[1]), \n");
fprintf(ft,"                     .clock(clk), \n");
fprintf(ft,"                     .qa(ins_o[15:8]), \n");
fprintf(ft,"                     .qb(dout_w[15:8]) \n");
fprintf(ft,"                 ); \n");

fprintf(ft,"    sim_syn_ram0 ram0( \n");
fprintf(ft,"                     .data(din[7:0]), \n");
fprintf(ft,"                     .wraddress(data_addr), \n");
fprintf(ft,"                     .rdaddress_a(pc), \n");
fprintf(ft,"                     .rdaddress_b(data_addr), \n");
fprintf(ft,"                     .wren(wren[0]), \n");
fprintf(ft,"                     .clock(clk), \n");
fprintf(ft,"                     .qa(ins_o[7:0]), \n");
fprintf(ft,"                     .qb(dout_w[7:0]) \n");
fprintf(ft,"                 ); \n");
fprintf(ft,"endmodule \n\n\n");
return 1;
    }
unsigned char hex2byte( char hex_char)
{
    unsigned char i ;
    for(i=0;i<16;++i)if(HEX[i]==hex_char)return i ;
    for(i=0;i<16;++i)if(hex[i]==hex_char)return i ;
    return 0 ;
}
unsigned int par2u32(char*par)
{
    unsigned int i,ret=0 ;
    if(par==NULL)return ;
    if((0==strncmp(par,"0x",2))||(0==strncmp(par,"0X",2))) 
    for(i=2;;++i)    {if(par[i]=='\0')return ret ; ret=ret*16+hex2byte(par[i]);}
    else 
    for(i=0;;++i)    {if(par[i]=='\0')return ret ; ret=ret*10+hex2byte(par[i]);}
    return 0 ;
}

main(int argc,char*argv[])
{
    int j=4,i=0,ii=0 ;
    int cntr=0,base=0 ;
    
    char str1[100],str2[111];
    
    FILE*ff=fopen("code.txt","r");
    FILE*ft=fopen("sim_ram.v","w");
    
    if(NULL!=argv[1])
    base=par2u32(argv[1])/4;
    print_module(ft);
    for(j=0;j<4;++j)
    {
        cntr=-10 ;
        fprintf(ft,"module sim_syn_ram%d(\n",j);
        fprintf(ft,"    input   [7:0]  data,\n");
        fprintf(ft,"    input   [29:0]  wraddress,\n");
        fprintf(ft,"    input   [29:0]  rdaddress_a,\n");
        fprintf(ft,"    input   [29:0]  rdaddress_b,\n");
        fprintf(ft,"    input     wren,\n");
        fprintf(ft,"    input     clock,\n");
        fprintf(ft,"    output  [7:0]  qa,\n");
        fprintf(ft,"    output  [7:0]  qb\n");
        fprintf(ft,"    );\n\n");

        fprintf(ft,"    reg [7:0]  r_data;\n");
        fprintf(ft,"    reg [29:0]  r_wraddress;\n");
        fprintf(ft,"    reg [29:0]  r_rdaddress_a;\n");
        fprintf(ft,"    reg [29:0]  r_rdaddress_b;\n");
        fprintf(ft,"    reg   r_wren;\n");

        fprintf(ft,"    reg [7:0] mem_bank  [0:12345]  ;\n");
        if(base!=0)
        fprintf(ft,"    \ninteger i;\n    initial begin\n        for(i=0;i<%d;i=1+i)\n         mem_bank[i] = 'h00;\n       ",base);
        else
        fprintf(ft,"    \ninitial begin   \n       ");

        rewind(ff);
        cntr=-10 ;
        i=-1 ;
        
        while(fgets(str2,100,ff))
        {
            ++i ;
            if(3==j)
            {
                str2[2]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",base+i,&str2[0]);
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr=0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(2==j)
            {
                str2[4]=0 ;
                
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",base+i,&str2[2]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr=0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(1==j)
            {
                str2[6]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",base+i,&str2[4]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr=0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(0==j)
            {
                str2[8]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",base+i,&str2[6]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr=0 ;
                    fprintf(ft,"\n       ");
                }
            }
        }
        fprintf(ft,"    \n       end\n");
        fprintf(ft,"    always @ (posedge clock) if (r_wren) mem_bank[r_wraddress]<=r_data;\n");
        fprintf(ft,"    always @ (posedge clock)\n");
        fprintf(ft,"    begin\n");
        fprintf(ft,"        r_data<=data;\n");
        fprintf(ft,"        r_wraddress<=wraddress;\n");
        fprintf(ft,"        r_rdaddress_a<=rdaddress_a;\n");
        fprintf(ft,"        r_rdaddress_b<=rdaddress_b;\n");
        fprintf(ft,"        r_wren<=wren;\n");
        fprintf(ft,"    end\n");
        fprintf(ft,"    assign qa =mem_bank[r_rdaddress_a];\n",base+i);
        fprintf(ft,"    assign qb =mem_bank[r_rdaddress_b];\n",base+i);
      //   fprintf(ft," //   assign qa =(r_rdaddress_a<%d)?mem_bank[r_rdaddress_a]:0;\n",base+i);
      //  fprintf(ft,"  //  assign qb =(r_rdaddress_b<%d)?mem_bank[r_rdaddress_b]:0;\n",base+i);
        fprintf(ft,"endmodule\n\n\n\n");
    }fclose(ft);

}
