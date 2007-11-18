
typedef unsigned int   uint32;
typedef unsigned short uint16;
typedef unsigned char  uint8;

#ifndef NULL
#define NULL (void*)0
#endif

#define assert(A) if((A)==0){OS_Assert();UartPrintfCritical("\r\nAssert %s:%d\r\n", __FILE__, __LINE__);}

#define isprint(c) (' '<=(c)&&(c)<='~')
#define isspace(c) ((c)==' '||(c)=='\t'||(c)=='\n'||(c)=='\r')
#define isdigit(c) ('0'<=(c)&&(c)<='9')
#define islower(c) ('a'<=(c)&&(c)<='z')
#define isupper(c) ('A'<=(c)&&(c)<='Z')
#define isalpha(c) (islower(c)||isupper(c))
#define isalnum(c) (isalpha(c)||isdigit(c))
#define min(a,b)   ((a)<(b)?(a):(b))
#define strcpy     strcpy2  //don't use intrinsic functions
#define strcat     strcat2
#define strcmp     strcmp2
#define strlen     strlen2
#define memcpy     memcpy2
#define memcmp     memcmp2
#define memset     memset2
#define abs        abs2

char *strcpy(char *dst, const char *src);
char *strncpy(char *dst, const char *src, int count);
char *strcat(char *dst, const char *src);
char *strncat(char *dst, const char *src, int count);
int   strcmp(const char *string1, const char *string2);
int   strncmp(const char *string1, const char *string2, int count);
char *strstr(const char *string, const char *find);
int   strlen(const char *string);
void *memcpy(void *dst, const void *src, unsigned long bytes);
void *memmove(void *dst, const void *src, unsigned long bytes);
int   memcmp(const void *cs, const void *ct, unsigned long bytes);
void *memset(void *dst, int c, unsigned long bytes);
int   abs(int n);
int   rand(void);
void  srand(unsigned int seed);
long  strtol(const char *s, const char **end, int base);
int   atoi(const char *s);
char *itoa(int num, char *dst, int base);
int sscanf(const char*s,const char*format,int arg0);
int sprintf(char*s,const char*format,int arg0);
