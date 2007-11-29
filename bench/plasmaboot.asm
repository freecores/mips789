##################################################################
# TITLE: Boot Up Code
# AUTHOR: Steve Rhoads (rhoadss@yahoo.com)
# DATE CREATED: 1/12/02
# FILENAME: boot.asm
# PROJECT: Plasma CPU core
# COPYRIGHT: Software placed into the public domain by the author.
#    Software 'as is' without warranty.  Author liable for nothing.
# DESCRIPTION:
#    Initializes the stack pointer and jumps to main2().
##################################################################
	.text
	.align	2
	.globl	entry
	.ent	entry
entry:
   .set noreorder

   #These eight instructions must be the first instructions.
   #convert.exe will correctly initialize $gp
   lui   $gp,0
   ori   $gp,$gp,0
   #convert.exe will set $4=.sbss_start $5=.bss_end
   lui   $4,0
   ori   $4,$4,0
   lui   $5,0
   ori   $5,$5,0
   lui   $sp,0
   ori   $sp,$sp,0xfff0     #initialize stack pointer
$BSS_CLEAR:
   sw    $0,0($4)
   slt   $3,$4,$5
   bnez  $3,$BSS_CLEAR
   addiu $4,$4,4
nop
nop
   jal   main2
   nop
$L1:
		nop
   j $L1
		nop
		nop
		nop
		nop
# som NOP make sure the results had write back
   .set reorder
	.end	entry



###################################################
   #address 0x44
   .global interrupt_service_routine
   .ent interrupt_service_routine
interrupt_service_routine:
   .set noreorder
   .set noat
	nop  
#do not save registers for this is just for simulation in this version
  jal   ISR
	nop
   mtc0  $0,$0  #return from interrupt
	nop
nop
   .end interrupt_service_routine
   .set at
###################################################