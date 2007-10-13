source "C:/Program Files/Synplicity/fpga_81/lib/altera/quartus_cons.tcl"
syn_create_and_open_prj mips_sys
source $::quartus(binpath)/prj_asd_import.tcl
syn_create_and_open_csf mips_sys
syn_handle_cons mips_sys
syn_compile_quartus
