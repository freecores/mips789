#EP1C3T144C8 Setup.tcl 
# Setup pin setting for evaluaton board V1.0
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED" 
set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF 

set_location_assignment PIN_28 -to clk
set_location_assignment PIN_159 -to rst
set_location_assignment PIN_156 -to key1                
set_location_assignment PIN_158 -to key2  

set_location_assignment PIN_1 -to led1 
set_location_assignment PIN_2 -to led2 
set_location_assignment PIN_177 -to ser_rxd
set_location_assignment PIN_176 -to ser_txd

set_location_assignment PIN_135 -to lcd_en
set_location_assignment PIN_133 -to lcd_rs
set_location_assignment PIN_134 -to lcd_rw 
set_location_assignment PIN_136 -to lcd_data\[0\] 
set_location_assignment PIN_137 -to lcd_data\[1\]
set_location_assignment PIN_138 -to lcd_data\[2\] 
set_location_assignment PIN_139 -to lcd_data\[3\]
set_location_assignment PIN_140 -to lcd_data\[4\] 
set_location_assignment PIN_141 -to lcd_data\[5\]
set_location_assignment PIN_143 -to lcd_data\[6\] 
set_location_assignment PIN_144 -to lcd_data\[7\]           
            
set_location_assignment PIN_169 -to seg7led1\[0\]            
set_location_assignment PIN_166 -to seg7led1\[1\]            
set_location_assignment PIN_161 -to seg7led1\[2\]            
set_location_assignment PIN_160 -to seg7led1\[3\]            
set_location_assignment PIN_164 -to seg7led1\[4\]            
set_location_assignment PIN_168 -to seg7led1\[5\]            
set_location_assignment PIN_167 -to seg7led1\[6\]            
set_location_assignment PIN_175 -to seg7led2\[0\]            
set_location_assignment PIN_170 -to seg7led2\[1\]            
set_location_assignment PIN_163 -to seg7led2\[2\]            
set_location_assignment PIN_165 -to seg7led2\[3\]            
set_location_assignment PIN_162 -to seg7led2\[4\]            
set_location_assignment PIN_174 -to seg7led2\[5\]            
set_location_assignment PIN_173 -to seg7led2\[6\]
            
set_location_assignment PIN_128 -to uart_rxd_usb            
set_location_assignment PIN_131 -to uart_txd_usb  

set_location_assignment PIN_60 -to sd_data\[0\] 
set_location_assignment PIN_59 -to sd_data\[1\]
set_location_assignment PIN_58 -to sd_data\[2\] 
set_location_assignment PIN_57 -to sd_data\[3\]
set_location_assignment PIN_56 -to sd_data\[4\] 
set_location_assignment PIN_55 -to sd_data\[5\]
set_location_assignment PIN_54 -to sd_data\[6\] 
set_location_assignment PIN_53 -to sd_data\[7\]
set_location_assignment PIN_12 -to sd_data\[8\] 
set_location_assignment PIN_11 -to sd_data\[9\]
set_location_assignment PIN_8 -to sd_data\[10\] 
set_location_assignment PIN_7 -to sd_data\[11\]
set_location_assignment PIN_6 -to sd_data\[12\] 
set_location_assignment PIN_5 -to sd_data\[13\]
set_location_assignment PIN_4 -to sd_data\[14\] 
set_location_assignment PIN_3 -to sd_data\[15\]

set_location_assignment PIN_42 -to sd_addr\[0\] 
set_location_assignment PIN_41 -to sd_addr\[1\]
set_location_assignment PIN_39 -to sd_addr\[2\] 
set_location_assignment PIN_38 -to sd_addr\[3\]
set_location_assignment PIN_23 -to sd_addr\[4\] 
set_location_assignment PIN_21 -to sd_addr\[5\]
set_location_assignment PIN_20 -to sd_addr\[6\] 
set_location_assignment PIN_19 -to sd_addr\[7\]
set_location_assignment PIN_18 -to sd_addr\[8\] 
set_location_assignment PIN_17 -to sd_addr\[9\]
set_location_assignment PIN_43 -to sd_addr\[10\] 
set_location_assignment PIN_16 -to sd_addr\[11\]

set_location_assignment PIN_45 -to sd_ba\[0\] 
set_location_assignment PIN_44 -to sd_ba\[1\]

set_location_assignment PIN_50 -to sd_dqm\[0\] 
set_location_assignment PIN_13 -to sd_dqm\[1\]

set_location_assignment PIN_46 -to sd_cs
set_location_assignment PIN_47 -to sd_ras
set_location_assignment PIN_48 -to sd_cas
set_location_assignment PIN_49 -to sd_we 
set_location_assignment PIN_15 -to sd_cke
set_location_assignment PIN_14 -to sd_clk


set_location_assignment PIN_208 -to FLASH_CE
set_location_assignment PIN_213 -to FLASH_OE
set_location_assignment PIN_206 -to FLASH_WE

set_location_assignment PIN_196 -to FLASH_RESET
set_location_assignment PIN_223 -to FLASH_BYTE

set_location_assignment PIN_207 -to FLASH_ADDR\[0\]
set_location_assignment PIN_181 -to FLASH_ADDR\[1\]
set_location_assignment PIN_182 -to FLASH_ADDR\[2\]
set_location_assignment PIN_183 -to FLASH_ADDR\[3\]
set_location_assignment PIN_184 -to FLASH_ADDR\[4\]
set_location_assignment PIN_185 -to FLASH_ADDR\[5\]
set_location_assignment PIN_186 -to FLASH_ADDR\[6\]
set_location_assignment PIN_187 -to FLASH_ADDR\[7\]
set_location_assignment PIN_204 -to FLASH_ADDR\[8\]
set_location_assignment PIN_203 -to FLASH_ADDR\[9\]
set_location_assignment PIN_202 -to FLASH_ADDR\[10\]
set_location_assignment PIN_201 -to FLASH_ADDR\[11\]
set_location_assignment PIN_200 -to FLASH_ADDR\[12\]
set_location_assignment PIN_199 -to FLASH_ADDR\[13\]
set_location_assignment PIN_198 -to FLASH_ADDR\[14\]
set_location_assignment PIN_197 -to FLASH_ADDR\[15\]
set_location_assignment PIN_222 -to FLASH_ADDR\[16\]
set_location_assignment PIN_188 -to FLASH_ADDR\[17\]
set_location_assignment PIN_193 -to FLASH_ADDR\[18\]
set_location_assignment PIN_205 -to FLASH_ADDR\[19\]

set_location_assignment PIN_214 -to FLASH_DQ\[0\]
set_location_assignment PIN_216 -to FLASH_DQ\[1\]
set_location_assignment PIN_218 -to FLASH_DQ\[2\]
set_location_assignment PIN_220 -to FLASH_DQ\[3\]
set_location_assignment PIN_235 -to FLASH_DQ\[4\]
set_location_assignment PIN_233 -to FLASH_DQ\[5\]
set_location_assignment PIN_227 -to FLASH_DQ\[6\]
set_location_assignment PIN_225 -to FLASH_DQ\[7\]
set_location_assignment PIN_215 -to FLASH_DQ\[8\]
set_location_assignment PIN_217 -to FLASH_DQ\[9\]
set_location_assignment PIN_219 -to FLASH_DQ\[10\]
set_location_assignment PIN_221 -to FLASH_DQ\[11\]
set_location_assignment PIN_234 -to FLASH_DQ\[12\]
set_location_assignment PIN_228 -to FLASH_DQ\[13\]
set_location_assignment PIN_226 -to FLASH_DQ\[14\]
set_location_assignment PIN_224 -to FLASH_DQ\[15\]
