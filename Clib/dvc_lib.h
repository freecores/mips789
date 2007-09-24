/*
`define       UART_DATA_ADDR        'H80_00_00_28
`define       CMD_ADDR        'H80_00_00_14
`define       STATUS_ADDR        'H80_00_00_18
`define       SEG7LED_ADDR        'H80_00_00_1C
`define       SIM_DIS_ADDR        'H80_00_00_20
`define       LCD_DATA_ADDR        'H80_00_00_24
`define       TMR_IRQ_ADDR        'H80_00_00_28
`define       TMR_DATA_ADDR        'H80_00_00_34
`define       KEY1_IRQ_ADDR        'H80_00_00_2C
`define       KEY2_IRQ_ADDR        'H80_00_00_30   
*/

#define FRQ 50*1000*1000
#define LCDDATA   		   *(volatile unsigned char*)0X80000024 
#define SEG7LED  		   *(volatile unsigned char*)0X8000001C 		 
#define UART0_DATA         *(volatile unsigned char*)0x80000028
#define CMD         	   *(volatile unsigned int* )0x80000014
#define STATUS             *(volatile unsigned int* )0x80000018	
#define TMR_DATA           *(volatile unsigned int* )0x80000034	

#define set_bit(a,b)		a=a|(1<<b)
#define clr_bit(a,b)		a=a&(~(1<<b))

#define  LINE1     0
#define  LINE2     1
#define  LINE1_HEAD    0x80
#define  LINE2_HEAD    0xC0
#define  DATA_MODE    0x38
#define  OPEN_SCREEN    0x0C
#define  DISPLAY_ADDRESS   0x80
#define  CLEARSCREEN    LCD_en_command(0x01)
#define  LCD_DLY_US 100*10
#define  LCD_INIT_US 50*1000*10

#define  HIGH    1
#define  LOW     0
#define  TRUE    1
#define  ZERO    0 	

void LCD_write_string(unsigned char X,unsigned char Y,unsigned char *s);
void LCD_write_char( unsigned x,unsigned char y,unsigned char dat);
void LCD_set_xy( unsigned char x, unsigned char y );
void LCD_en_dat(unsigned char dat);
void LCD_en_command(unsigned char command);
void LCD_delay(void);
void dly_us(unsigned int us );
void LCD_init(void);
void led1_on();
void led1_off();
void led2_on();
void led2_off();
void uart0_putstr(char *str);
unsigned char uart0_getc(void);
unsigned char  enqire_rxd(void);
void uart0_putc(unsigned char data);
void dis_byte(unsigned char data);
void download();
unsigned char get_key1();
unsigned char get_key2();
#define getkey1 get_key1
#define getkey2 get_key2

void tmr_en(unsigned int cntr);
void tmr_disen(void);
void tmr_clr(void);

