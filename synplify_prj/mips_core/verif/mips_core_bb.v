module synplicity_altsyncram4_r_w_reg_array (wren_a,wren_b,data_a,address_a,address_b,clock0,clock1,clocken0,clocken1,q_b);
input wren_a;
input wren_b;
input [31:0]data_a;
input [4:0]address_a;
input [4:0]address_b;
input clock0;
input clock1;
input clocken0;
input clocken1;
output [31:0]q_b;
endmodule

