#include "dvc_lib.h"
void __inline dis_byte(unsigned char data)
{
    SEG7LED=data ;
}

void dly_us(unsigned int us)
{
    int i ;
    while(us--)
    {
        i=FRQ/1000000/3-2 ;
        while(i--);
        //delay 1us
    }
}

void dly_ms(unsigned int ms)
{
    int i ,us=1000*ms;
    while(us--)
    {
        i=12;
        while(i--);
    }
}

void uart0_putc(unsigned char data)
{
    while((STATUS&(1<<2))!=0);
    UART0_DATA=data ;
}
unsigned char uart0_getc(void)
{
    unsigned char ret=0 ;
    while((STATUS&(1<<3))==0);
    ret=UART0_DATA ;
    set_bit(CMD,1);
    set_bit(CMD,1);
    clr_bit(CMD,1);
    return ret ;
}
unsigned char enqire_rxd(void)
{
    return(STATUS&(1<<3))?1:0 ;
}

void uart0_putstr(char*str)
{
    while(1){
    if(*str=='\0')return ;
    else if(*str=='\n')
    	{
    		uart0_putc('\r');
    		uart0_putc(*str++);
    	}
    	else 
    		uart0_putc(*str++);
		}
}

void __inline led1_on(void)
{
    CMD=CMD&(~(1<<5));
}
void __inline led1_off(void)
{
    CMD=CMD|(1<<5);
}
void __inline led2_on(void)
{
    CMD=CMD&(~(1<<6));
}
void __inline led2_off(void)
{
    CMD=CMD|(1<<6);
}

//lcd part

void LCD_init(void)
{
    char i=3 ;
    CLEARSCREEN ;
    //clear screen
    while(i--)
    {
        LCD_en_command(DATA_MODE);
        //set 8 bit data transmission mode
        dly_us(LCD_INIT_US);
    }
    LCD_en_command(OPEN_SCREEN);
    //open display (enable lcd display)
    dly_us(LCD_DLY_US);
    LCD_en_command(DISPLAY_ADDRESS);
    //set lcd first display address
    dly_us(LCD_DLY_US);
    CLEARSCREEN ;
    //clear screen
    dly_us(LCD_DLY_US);
}

void LCD_en_command(unsigned char command)
{
    LCDDATA=command ;
    clr_bit(CMD,2);
    // LCD1602_RS=LOW;
    clr_bit(CMD,3);
    //LCD1602_RW=LOW;
    clr_bit(CMD,4);
    //LCD1602_EN=LOW;
    dly_us(LCD_DLY_US);
    set_bit(CMD,4);
    //LCD1602_EN=HIGH;
}

void LCD_en_dat(unsigned char dat)
{
    LCDDATA=dat ;
    set_bit(CMD,2);
    //LCD1602_RS=HIGH;
    clr_bit(CMD,3);
    //LCD1602_RW=LOW;
    clr_bit(CMD,4);
    //LCD1602_EN=LOW;
    dly_us(LCD_DLY_US);
    set_bit(CMD,4);
    //LCD1602_EN=HIGH;
}

void LCD_set_xy(unsigned char x,unsigned char y)
{
    unsigned char address ;
    if(y==LINE1)
    address=LINE1_HEAD+x ;
    else 
    address=LINE2_HEAD+x ;
    LCD_en_command(address);
}

void LCD_write_char(unsigned x,unsigned char y,unsigned char dat)
{
    LCD_set_xy(x,y);
    LCD_en_dat(dat);
}

void LCD_write_string(unsigned char X,unsigned char Y,unsigned char*s)
{
    LCD_set_xy(X,Y);
    while(*s)
    {
        LCD_en_dat(*s++);
    }
}

void download()
{
    unsigned char*addr=(void*)0 ;
    uart0_putstr((char*)"This is MIPS789 BOOTLOADER\n");
    dis_byte(0xcc);
    //attenions please'!'
    while(uart0_getc()!='!');
    uart0_putc((unsigned char)('O'));
    //'O'k .i am ready
    while(1)
    {
        *addr=(unsigned char)uart0_getc();
        dis_byte((unsigned char)(*addr++));
    }
}

void tmr_en(unsigned int cntr)
{
    set_bit(CMD,8);
    TMR_DATA=cntr ;
    tmr_clr();
}

void tmr_disen(void)
{
    clr_bit(CMD,8);
    clr_bit(CMD,7);
}

void tmr_clr(void)
{
    set_bit(CMD,7);
    set_bit(CMD,7);
    clr_bit(CMD,7);
    clr_bit(CMD,7);
}

unsigned int  read_tmr()
{
    return TMR_DATA ;
}


unsigned char get_key1()
{
    return(STATUS&1)?0:1 ;
}

unsigned char get_key2()
{
    return(STATUS&(1<<1))?0:1 ;
}
