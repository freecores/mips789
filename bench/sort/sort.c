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

#include "..\..\clib\dvc_lib.h"
#include "..\..\clib\stringlib.h"

#define SORT_U16


#ifdef SORT_U8
#define DATA_TYPE   unsigned char
#define DATA_MAX 0xff
#else
#ifdef SORT_U16
#define DATA_TYPE  unsigned  short
#define DATA_MAX 0xffff
#else
#define DATA_TYPE   unsigned int
#define DATA_MAX 0xffffffff
#endif
#endif
void sort(DATA_TYPE*a,int num)
{
    int i,j ;
    
    DATA_TYPE tmp ;
    
    for(i=0;i<num;i++)
    {
        for(j=i+1;j<num;j++)
        {
            if(a[i]<a[j])
            {
                tmp=a[i];
                a[i]=a[j];
                a[j]=tmp ;
            }
        }
    }
}

DATA_TYPE array[16]={123,234,122,111,222,122,332,111,11,99,11,12,43,23,43,45};



char str[100];
void main2()
{
    int i ;
//initial_array(array,16);
    for(;;)
    {
        
        sort(array,16);
        for(i=0;i<16;++i)
        {
            sprintf(str,"  %x",array[i]);
            uart0_putstr(str);
        }
        uart0_putstr(" \n");
    }
}


