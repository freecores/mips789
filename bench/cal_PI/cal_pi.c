#include "..\..\clib\dvc_lib.h"

void print_num(unsigned long num)
{
    unsigned long digit,offset ;
    for(offset=1000;offset;offset/=10)
    {
        digit=num/offset ;
        uart0_putc('0'+digit);
        num-=digit*offset ;
    }
}

long a=10000,b=0,c=56,d=0,e=0,f[57]={0},g=0 ;

void cal_PI(void)
{
    uart0_putstr("\nPI = ");
    a=10000 ;
    b=0 ;
    c=56 ;
    d=0 ;
    e=0 ;
    g=0 ;
    for(;b-c;)f[b++]=a/5 ;
    for(;d=0,g=c*2;c-=14,print_num(e+d/a),e=d%a)
    for(b=c;d+=f[b]*a,f[b]=d%--g,d/=g--,--b;d*=b);
    uart0_putc('\n');
}

main2()
{      

while(1)
{
    uart0_putstr("Hello CPU World ,this is  MIPS789...");
cal_PI();
}

}
