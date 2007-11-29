path;
path=..\..\gccmips_elf
del *.axf
del *.txt
as -o boot.o ..\plasmaboot.asm
gcc  -O2 -O  -Wall -c -s ..\..\clib\dvc_lib.c
gcc  -O2 -O  -Wall -c -s demo.c

ld.exe -Ttext 0 -eentry -Map test.map -s -N -o test.axf boot.o dvc_lib.o demo.o

objdump.exe --disassemble test.axf > list.txt

convert_sp 
gensim 
genmif 

#ser_dld 9600 COM1 N
copy *.mif ..\..\quartus2\*.mif
copy *.v ..\MODELSIM\*.v
copy list.txt ..\MODELSIM\list.txt
del ..\MODELSIM\*.c
copy *.c ..\MODELSIM\*.c


