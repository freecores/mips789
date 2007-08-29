#include "stdio.h" 
main(int file_no,char*file_name[])
{
    int j=4,i=0 ;
    int cntr ;
    char str1[100],str2[111];
   /* 
    FILE*ff=fopen(file_name[1],"r");
    FILE*ft=fopen(file_name[2],"w");
    */
    FILE*ff=fopen("code.txt","r");
    FILE*ft=fopen("sim_ram.v","w");
    for(j=0;j<4;++j)
    {
	cntr = -10;
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
        
        fprintf(ft,"      initial begin   \n       ");
        rewind(ff);
        i=-1 ;
        
        while(fgets(str2,100,ff))
        {
            ++i ;
            if(3==j)
            {
                str2[2]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",i,&str2[0]);
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr==0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(2==j)
            {
                str2[4]=0 ;
                
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",i,&str2[2]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr==0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(1==j)
            {
                str2[6]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",i,&str2[4]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr==0 ;
                    fprintf(ft,"\n       ");
                }
            }
            else 
            if(0==j)
            {
                str2[8]=0 ;
                fprintf(ft,"mem_bank[%d] = 'h%s ; ",i,&str2[6]);
                
                ++cntr ;
                if(!(cntr%10))
                {
                    cntr==0 ;
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
