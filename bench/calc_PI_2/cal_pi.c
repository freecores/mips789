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

/* This source code is baseed on a 16bit CPU Aquarius in opencores.org */
/* Thanks the author. */
/* modified by Liwei 2007-10-13 */


//#define DOS
#define MIPS

#ifdef MIPS
#include "..\..\clib\dvc_lib.h"
#endif

#ifdef DOS
#include "stdio.h"
#define uart0_putc putchar
#define uart0_putstr puts
#endif

void          longadd(unsigned short *a, unsigned short *b, unsigned short *c);
void          longsub(unsigned short *a, unsigned short *b, unsigned short *c);
int           longdiv(unsigned short *a, unsigned short b, unsigned short *c);
void          calc_pi(void);
void          disp_oct4(unsigned short x);
void          disp_pi(void);

#define  MAXFIGURE ((1100*2/4)+2) /* should be (N*8)+2 to display correctly */

unsigned short PI[MAXFIGURE];
unsigned short T1[MAXFIGURE];
unsigned short T2[MAXFIGURE];
unsigned short T3[MAXFIGURE];

/* ============= */
/*  Main Routine */
/* ============= */
void main_sh(void)
{

    uart0_putstr("Calculating.....   ");
    calc_pi();
    disp_pi();
}

/* ------------------------------------------------- */
/*  Calculate the Circular Constant Pi */
/* ------------------------------------------------- */
/*  (1) Matin's formula */
/*  PI/4 =  4*arctan(1/5) -   arctan(1/239) */
/*  PI   = 16*arctan(1/5) - 4*arctan(1/239) */
/*  Here, arctan(1/p) = 1/p - 1/(3*p^3) + 1/(5*p^5) - 1/(7*p^7) + ... */
/*  Then,  */
/*  PI =  (16*1/5     - 4*1/239) */
/*      - (16*1/3*5^3 - 4*1/3*239^3) */
/*      + (16*1/5*5^5 - 4*1/5*239^5) */
/*      - (16*1/7*5^7 - 4*1/7*239^7) */
/*      +... */
/*     =  (1/1)*(16*5/(5*5)^1 - 4*239/(239*239)^1) */
/*      - (1/3)*(16*5/(5*5)^2 - 4*239/(239*239)^2) */
/*      + (1/5)*(16*5/(5*5)^3 - 4*239/(239*239)^3) */
/*      - (1/7)*(16*5/(5*5)^4 - 4*239/(239*239)^4) */
/*      +... */
/* ------------------------------------------------- */
/*  (2) Define Arrays for Long Figure Number */
/*  Each element has Octal 4 figures.  */
/*      PI[] : Value to be converged to Pi */
/*      T1[] : (16*  5)/(  5*  5)^n (n=1...) */
/*      T2[] : ( 4*239)/(239*239)^n (n=1...) */
/*      T3[] : (-1)*(n+1)*(1/(2n-1))*(T1[]-T2[]) */
/* ------------------------------------------------- */
/*  (3) Example */
/*  n TI[0] TI[1] T2[0] T2[1] T3[0] T3[1] PI[0] PI[1]  */
/*  0 0080  0000  0956  0000  0000  0000  0000  0000 */
/*  1 0003  2000  0000  0167  0003  1833  0003  1833 (+) */
/*  2 0000  1280  0000  0000  0000  0426  0003  1407 (-) */
/*  3 0000  0051  0000  0000  0000  0010  0003  1417 (+) */
/*  4 0000  0002  0000  0000  0000  0000  0003  1417 (-) */
/* ------------------------------------------------- */
void calc_pi(void)
{
    int i;
    int converged;
    /* ----------- */
    /*  Initialize */
    /* ----------- */
    converged = 0;
    for (i=0; i<=MAXFIGURE-1; i++)
    {
        PI[i] = 0;
        T1[i] = 0;
        T2[i] = 0;
        T3[i] = 0;
    }
    T1[0] = 16*5;
    T2[0] = 4*239;

    /* ----------------------------- */
    /*  repeat until being converged */
    /* ----------------------------- */
    i = 1;
    while (converged == 0)
    {
        /* ------------- */
        /*  Make T1 & T2 */
        /* ------------- */
        longdiv(T1,  25, T1);
        longdiv(T2, 239, T2);
        longdiv(T2, 239, T2);
        /* -------- */
        /*  Make T3 */
        /* -------- */
        longsub(T1, T2, T3);
        converged = longdiv(T3, (unsigned short)(2*i-1), T3); 
        /* if (converged) break; */
        /* ----------------- */
        /*  Accumulate to PI */
        /* ----------------- */
        if (i%2 != 0)
            longadd(PI, T3, PI);
        else
            longsub(PI, T3, PI);
        /* ------------ */
        /*  Increment i */
        /* ------------ */
        i++;
    }
}

/* --------- */
/*  Long Add */
/* --------- */
void longadd(unsigned short *a, unsigned short *b, unsigned short *c)
{
    int i;
    unsigned short carry;

    carry = 0;
    for (i = MAXFIGURE-1; i >= 0; i--)
    {
        *(c+i) = *(a+i) + *(b+i) + carry;
        if (*(c+i) < 10000)
            carry = 0;
        else
        {
            carry = 1;
            *(c+i) = *(c+i) - 10000;
        }
    }
}

/* --------- */
/*  Long Sub */
/* --------- */
void longsub(unsigned short *a, unsigned short *b, unsigned short *c)
{
    int i;
    unsigned short borrow;
    unsigned short temp;

    borrow = 0;
    for (i = MAXFIGURE-1; i >= 0; i--)
    {
        temp = *(b+i) + borrow;
        if (*(a+i) >= temp)
        {
            *(c+i) = *(a+i) - temp;
            borrow = 0;
        }
        else
        {
            *(c+i) = 10000 + *(a+i) - temp;
            borrow = 1;
        }
    }
}

/* --------- */
/*  Long Div */
/* --------- */
int longdiv(unsigned short *a, unsigned short b, unsigned short *c)
{
    int i;
    int conv;
    unsigned long al, bl, cl, dvd, rem;

    conv = 1;
    rem = 0;
    for (i = 0; i <= MAXFIGURE-1; i++)
    {
        al = (unsigned long) *(a+i);
        bl = (unsigned long) b;
        cl = (unsigned long) *(c+i);

        dvd = al + rem;
        cl = dvd / b;
        rem    = (dvd - cl * bl) * 10000;
        if (cl > 0) conv = 0;
        *(c+i) = (unsigned short) cl; 
    }
    return conv;
}

/* ----------- */
/*  Display Pi */
/* ----------- */
void disp_pi(void)
{
    int i, j;
    uart0_putstr("Calculating DONE  ");
    uart0_putstr("Pi = 3.");
  /*  while(1)*/
    {
        for (i = 0; i < (MAXFIGURE - 2) / 8; i++)
        {
             for (j = 0; j < 8; j++)
            {
  /*               if (j == 0) lcd_pos(0);  */
  /*               if (j == 4) lcd_pos(16); */
                disp_oct4(*(PI + i*8 + j + 1));
             }
        }
    }
}

/* ------------------- */
/*  Display Oct 4 digit */
/* ------------------- */

void disp_oct4(unsigned short x)
{
    
    unsigned short d;
    d = x / 1000;
    x = x - d * 1000;
    uart0_putc((char)(d+0x30));
    d = x / 100;
    x = x - d * 100;
    uart0_putc((char)(d+0x30));
    d = x / 10;
    x = x - d * 10;
    uart0_putc((char)(d+0x30));
    uart0_putc((char)(x+0x30));    
}

#ifdef MIPS
main2()
#endif

#ifdef DOS
main()
#endif
{      

unsigned char i=0;


for(;;)
{
 uart0_putstr("Hello CPU World ,this is  MIPS789...\n");
calc_pi();
    disp_pi();
#ifdef MIPS
dis_byte(i++);
while(get_key1()==0)      ;
#endif

#ifdef DOS
getchar();
#endif
}


}
