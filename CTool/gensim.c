
#include "stdio.h"
#include "stdlib.h"



/*Liwei 2007-8-29*/
 char HEX[]="0123456789ABCDEF" ;
 char hex[]="0123456789abcdef" ;

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
    for(j=0;j<4;++j)
    {
        cntr=-10 ;
        fprintf(ft,"module sim_syn_ram%d(\n",j);
        fprintf(ft,"        data,\n");
        fprintf(ft,"        wraddress,\n");
        fprintf(ft,"        rdaddress_a,\n");
        fprintf(ft,"        rdaddress_b,\n");
        fprintf(ft,"        wren,\n");
        fprintf(ft,"        clock,\n");
        fprintf(ft,"        qa,\n");
        fprintf(ft,"        qb);\n\n");
        fprintf(ft,"    input   [7:0]  data;\n");
        fprintf(ft,"    input   [10:0]  wraddress;\n");
        fprintf(ft,"    input   [10:0]  rdaddress_a;\n");
        fprintf(ft,"    input   [10:0]  rdaddress_b;\n");
        fprintf(ft,"    input     wren;\n");
        fprintf(ft,"    reg [7:0]  r_data;\n");
        fprintf(ft,"    reg [10:0]  r_wraddress;\n");
        fprintf(ft,"    reg [10:0]  r_rdaddress_a;\n");
        fprintf(ft,"    reg [10:0]  r_rdaddress_b;\n");
        fprintf(ft,"    reg   r_wren;\n");
        fprintf(ft,"    input     clock;\n");
        fprintf(ft,"    output  [7:0]  qa;\n");
        fprintf(ft,"    output  [7:0]  qb;\n");
        fprintf(ft,"    reg [7:0] mem_bank  [0:2047]  ;\n");
        if(base!=0)
        fprintf(ft,"    integer i;\n    initial begin\n        for(i=0;i<%d;i=1+i)\n         mem_bank[i] = 'h00;\n       ",base);
        else
        fprintf(ft,"    initial begin   \n       ");

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
        fprintf(ft,"    assign qa =mem_bank[r_rdaddress_a];\n");
        fprintf(ft,"    assign qb =mem_bank[r_rdaddress_b];\n");
        fprintf(ft,"endmodule\n\n\n\n");
    }
}
