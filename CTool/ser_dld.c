
/*  RS-232 example */
/*  Compiles with Microsoft Visual C++ 5.0/6.0 */
/*  (c) fpga4fun.com KNJN LLC - 2003, 2004, 2005, 2006 */
/*  modified by Liwei 2007-9-2 */

#include "stdio.h" 
#include "windows.h" 
#include "conio.h" 
#define MAX_PRG_SIZE 0x1d00 

#define DEFAULT_BAUD_RATE 38400 
/*the two functions listed between are added by Liwei 2007-8-29*/
char HEX[]="0123456789ABCDEF" ;
char hex[]="0123456789abcdef" ;
unsigned char hex2byte(char hex_char)
{
    unsigned char i ;
    for(i=0;i<16;++i)if(HEX[i]==hex_char)return i ;
    for(i=0;i<16;++i)if(hex[i]==hex_char)return i ;
    return 0 ;
}
unsigned char hex2u8(char*par)
{
    return(hex2byte(par[0])*16+hex2byte(par[1]));
}
unsigned int par2u32(char*par)
{
    unsigned int i,ret=0 ;
    if(par==NULL)return ;
    if((0==strncmp(par,"0x",2))||(0==strncmp(par,"0X",2)))
    for(i=2;;++i)
    {
        if(par[i]=='\0')return ret ;
        ret=ret*16+hex2byte(par[i]);
    }
    else 
    for(i=0;;++i)
    {
        if(par[i]=='\0')return ret ;
        ret=ret*10+hex2byte(par[i]);
    }
    return 0 ;
}
/****************************/
HANDLE hCom ;

void OpenCom(unsigned int baudrate,char*comno)
{
    DCB dcb ;
    COMMTIMEOUTS ct ;
    
    hCom=CreateFile(comno,GENERIC_READ|GENERIC_WRITE,0,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);
    if(hCom==INVALID_HANDLE_VALUE)exit(1);
    if(!SetupComm(hCom,4096,4096))exit(1);
    
    if(!GetCommState(hCom,&dcb))exit(1);
    dcb.BaudRate=baudrate ;
    //modified by `Liwei 2007-9-4
    ((DWORD*)(&dcb))[2]=0x1001 ;
    /*  set port properties for TXDI + no flow-control */
    dcb.ByteSize=8 ;
    dcb.Parity=NOPARITY ;
    dcb.StopBits=2 ;
    if(!SetCommState(hCom,&dcb))exit(1);
    
    /*  set the timeouts to 0 */
    ct.ReadIntervalTimeout=MAXDWORD ;
    ct.ReadTotalTimeoutMultiplier=0 ;
    ct.ReadTotalTimeoutConstant=0 ;
    ct.WriteTotalTimeoutMultiplier=0 ;
    ct.WriteTotalTimeoutConstant=0 ;
    if(!SetCommTimeouts(hCom,&ct))exit(1);
}

void CloseCom()
{
    CloseHandle(hCom);
}

DWORD WriteCom(char*buf,int len)
{
    DWORD nSend ;
    if(!WriteFile(hCom,buf,len,&nSend,NULL))exit(1);
    
    return nSend ;
}

void WriteComChar(char b)
{
    WriteCom(&b,1);
}

int ReadCom(char*buf,int len)
{
    DWORD nRec ;
    if(!ReadFile(hCom,buf,len,&nRec,NULL))exit(1);
    
    return(int)nRec ;
}

char ReadComChar()
{
    DWORD nRec ;
    char c ;
    if(!ReadFile(hCom,&c,1,&nRec,NULL))exit(1);
    
    return nRec?c:0 ;
}

void main(int argc,char*argv[])
{
    char c,s[11];
    int i,baud_rate ;
    
    FILE*ff=fopen("code.txt","r");
    baud_rate=(NULL!=argv[1])?par2u32(argv[1]):DEFAULT_BAUD_RATE ;
    //baud_rate=DEFAULT_BAUD_RATE;
    OpenCom(baud_rate,argv[2]);
    WriteComChar('?');
    Sleep(1);
    i=100 ;
    while(i--)
    c=ReadComChar();
    WriteComChar('!');
    Sleep(10);
    c=ReadComChar();
    if((argv[3]!=NULL)&&(argv[3][0]=='N'))
    {
    }
    else 
    {
        if(c!='O')
        {
            //printf("%c",c);
            printf("1,Powerup you board.\n2,Chech cable.\nany key to exit...\n");
            getchar();
            return ;
        }
        else 
        {
            printf("Downloading,wait...\n");
        }
    }
    
    /*
        while(1){
        Sleep(100);
        WriteComChar(c++);
        }*/
    
    rewind(ff);
    while(fgets(s,10,ff))
    {
        WriteComChar(hex2u8((char*)(s+0)));
        printf("%2.2x  ",hex2u8((char*)(s+0)));
        Sleep(1);
        
        WriteComChar(hex2u8((char*)(s+2)));
        printf("%2.2x  ",hex2u8((char*)(s+2)));
        Sleep(1);
        
        WriteComChar(hex2u8((char*)(s+4)));
        printf("%2.2x  ",hex2u8((char*)(s+4)));
        Sleep(1);
        
        WriteComChar(hex2u8((char*)(s+6)));
        printf("%2.2x  \n",hex2u8((char*)(s+6)));
        Sleep(1);
        
    }
    Sleep(1);
    printf("Download to MIPS789 OK!\nPress RESET botton to RUN the MIPS789 program...");
    WriteComChar(0x88);
    getch();
    CloseCom();
}
