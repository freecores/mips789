#include "..\..\clib\dvc_lib.h"

void main2()
{
    uart0_putstr((char*)"HELLO CPU WORLD!\nThis is MIPS789 Running\nI am ready to RCV prgram...");
    download();
}
