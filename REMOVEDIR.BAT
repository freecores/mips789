
@echo  Those folder are all empty.

del  dbe\cvs\*.* 
del  verilog\simulate\cvs\*.*
del  verilog\mips_core\cvs\*.*
del  verilog\device\cvs\*.*
del  verilog\altera_ram\cvs\*.*
del  verilog\cvs\*.*
del  tools\cvs\*.*
del  dbe\cvs\*.*
del  tools_source_code\cvs\*.*

RMDIR dbe\cvs 
RMDIR verilog\simulate\cvs
RMDIR verilog\mips_core\cvs
RMDIR verilog\device\cvs
RMDIR verilog\altera_ram\cvs
RMDIR verilog\cvs
RMDIR tools\cvs 
RMDIR dbe\cvs 
RMDIR tools_source_code\cvs

RMDIR dbe 
RMDIR verilog\simulate
RMDIR verilog\mips_core
RMDIR verilog\device
RMDIR verilog\altera_ram
RMDIR verilog
RMDIR tools 
RMDIR dbe 
RMDIR tools_source_code

@echo Empty folder is removed,so delete this BAT file itself.

@echo del removedir.bat


