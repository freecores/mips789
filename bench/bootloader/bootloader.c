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
    uart0_putstr((char*)"HELLO CPU WORLD!\nThis is MIPS789 Running\nI am ready to RCV prgram...");
    download();
}
void ISR(void){}