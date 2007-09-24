source "C:/Program Files/Synplicity/fpga_81/lib/altera/quartus_cons.tcl"
syn_create_and_open_prj r5_reg_cls
source $::quartus(binpath)/prj_asd_import.tcl
syn_create_and_open_csf r5_reg_cls
syn_handle_cons r5_reg_cls
