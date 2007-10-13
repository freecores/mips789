path;
path=..\..\gccmips_elf
del *.axf
del *.txt
as -o boot.o ..\plasmaboot.asm
gcc  -O2 -O  -Wall -c -s ..\..\clib\dvc_lib.c
gcc  -O2 -O  -Wall -c -s bootloader.c

ld.exe -Ttext 0x1500 -eentry -Map test.map -s -N -o test.axf boot.o dvc_lib.o bootloader.o

objdump.exe --disassemble test.axf > list.txt

convert_sp 0x2000 128
gensim 0x1500 
genmif 0x1500
copy *.mif ..\..\quartus2\*.mif