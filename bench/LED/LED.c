#include "..\..\clib\dvc_lib.h"

void main2()
{
    unsigned char i=0 ;
    
    while(1)
    { 
        dis_byte(i++);
        dly_us(100000);
        if (i%2)led1_on();else led1_off();
        if (i%2)led2_on();else led2_off();
        uart0_putc('!');

    }
}
