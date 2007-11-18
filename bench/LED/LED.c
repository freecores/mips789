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

void main2()
{
    unsigned char i=0 ;
    
    while(1)
    { 
        dis_byte(i++);
    //   dly_us(100000);
        if (i%2)led1_on();else led1_off();
        if (i%2)led2_on();else led2_off();
    //uart0_putc('!');

    }
}
