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

    uart0_putstr((char*)"HELLO CPU WORLD!\nThis is MIPS789 Running\n");
    LCD_init();
    LCD_write_string(0,0," THIS'S MIPS789");
    LCD_write_string(0,1,"MIPS789 demo...");
    while(1)
    { if(i==0)
    	  uart0_putstr((char*)"HI can you see me?\n");
        dis_byte(i++);
        dly_us(100*1000);
        led1_off();
        led2_off();
        /*
        if(get_key1()&&get_key2())
        {
            led1_off();
            led2_off();
            LCD_write_string(0,1,"Ready to RCV ");
            uart0_putstr((char*)"I am ready to rcv program...\n");
            download();
        }
        else 
        */
        if(get_key1())
        {
            LCD_write_string(0,1,"hello key1      ");
            led1_on();
            uart0_putstr((char*)"you have pressed key1\n");
            while(get_key1());
		LCD_write_string(0,1,"MIPS789 demo...");
        }
        else if(get_key2())
        {
           LCD_write_string(0,1,"hello key2      ");
            led2_on();
             uart0_putstr((char*)"you have pressed key2\n");
            while(get_key2());
            LCD_write_string(0,1,"MIPS789 demo...");
        }

    }
}
void ISR(void){}