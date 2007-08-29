#include "stdio.h"
#include "stdlib.h"
#define DEFAULT_LEN "2048"
void main(int argc,char *argv[])
{
    int j=4,i=0 ;
    char str1[100],str2[111];
    FILE*ff=fopen("code.txt","r");
    FILE*ft ;
    for(j=0;j<4;++j)
    {
        if(j==0)
        ft=fopen("qu2_ram0.mif","w");
        else if(j==1)
        ft=fopen("qu2_ram1.mif","w");
        else if(j==2)
        ft=fopen("qu2_ram2.mif","w");
        else if(j==3)
        ft=fopen("qu2_ram3.mif","w");
        fprintf(ft,"WIDTH=8;\n");
        fprintf(ft,"DEPTH=%s;\n\n",(NULL!=argv[1])?argv[1]:DEFAULT_LEN);
        fprintf(ft,"ADDRESS_RADIX=HEX;\n");
        fprintf(ft,"DATA_RADIX=HEX;\n\n");
        fprintf(ft,"CONTENT BEGIN \n");
        rewind(ff);
        i=-1 ;
        while(fgets(str2,100,ff))
        {
            ++i ;
            if(3==j)
            {
                str2[2]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i,&str2[0]);
            }
            else if(2==j)
            {
                str2[4]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i,&str2[2]);
            }
            else if(1==j)
            {
                str2[6]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i,&str2[4]);
            }
            else if(0==j)
            {
                str2[8]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i,&str2[6]);
            }
        }
        fprintf(ft,"END;");
    }
}
