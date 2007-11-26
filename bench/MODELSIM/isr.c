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
void cnop(void){
return;}
void main2()
{
	unsigned int addr=0x5c;
		TMR_IRQ_ADDR  = addr;
 KEY1_IRQ_ADDR  = addr;
  KEY2_IRQ_ADDR = addr;
    led1_off(); 
   set_bit(CMD,0);
   set_bit(CMD,31);
   set_bit(CMD,29);
   set_bit(CMD,30);
		while(1){
      led2_on();    led2_off();
      }
}
void ISR(void){
unsigned int mask=0;
int i=100;
while(i--){
	led1_on();
led1_off();
}
CMD=0;
}
