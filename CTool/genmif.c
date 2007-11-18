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
 
#include "stdio.h"
#include "stdlib.h"
#define DEFAULT_LEN  "2048"
/*Liwei 2007-8-29*/
char HEX[]="0123456789ABCDEF" ;
char hex[]="0123456789abcdef" ;
unsigned char hex2byte(char hex_char)
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
    for(i=2;;++i)
    {
        if(par[i]=='\0')return ret ;if(par[i]==' ')return ret ;
        ret=ret*16+hex2byte(par[i]);
    }
    else 
    for(i=0;;++i)
    {
        if(par[i]=='\0')return ret ;if(par[i]==' ')return ret ;
        ret=ret*10+hex2byte(par[i]);
    }
    return 0 ;
}
/****************************/


void main(int argc,char*argv[])
{
    int j=4,base=0,i=0 ;
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
        base=(NULL!=argv[1])?par2u32(argv[1]):0 ;
        base=base/4 ;
        fprintf(ft,"WIDTH=8;\n");
        fprintf(ft,"DEPTH=%s;\n\n",DEFAULT_LEN);
        fprintf(ft,"ADDRESS_RADIX=HEX;\n");
        fprintf(ft,"DATA_RADIX=HEX;\n\n");
        fprintf(ft,"CONTENT BEGIN \n");
        i=base ;
        
        if(base)while(i)
        {
            fprintf(ft,"   %X  :    %s;\n  ",base-i,"00");
            --i ;
        }
        
        rewind(ff);
        rewind(ff);
        rewind(ff);
        i=-1 ;
        
        while(fgets(str2,100,ff))
        {
            ++i ;
            if(3==j)
            {
                str2[2]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i+base,&str2[0]);
            }
            else if(2==j)
            {
                str2[4]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i+base,&str2[2]);
            }
            else if(1==j)
            {
                str2[6]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i+base,&str2[4]);
            }
            else if(0==j)
            {
                str2[8]=0 ;
                fprintf(ft,"   %X  :    %s;\n  ",i+base,&str2[6]);
            }
        }
        fprintf(ft,"END;");
    }
}
