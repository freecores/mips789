//This file is based YACC ->shifter.v 
/////////////////////////////////////////////////////////////////////
////  Author: Liwei                                              ////
////                                                             ////
////                                                             ////
////  If you encountered any problem, please contact :           ////
////  Email: mcupro@yahoo.com.hk or mcupro@opencores.org         ////
////                                                             ////
////  Downloaded from:                                           ////
////     http://www.opencores.org/pdownloads.cgi/list/mips789    ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2006-2007 Liwei                               ////
////                         mcupro@yahoo.com.hk                 ////
////                                                             ////
////                                                             ////
//// This source file may be used and distributed freely without ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and any derivative work contains the  ////
//// original copyright notice and the associated disclaimer.    ////
////                                                             ////
//// Please let the author know if it is used                    ////
//// for commercial purpose.                                     ////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
////                                                             ////
//// Date of Creation: 2007.8.1                                  ////
////                                                             ////
//// Version: 0.0.1                                              ////
////                                                             ////
//// Description:                                                ////
////                                                             ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Change log:                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

`define ALU_SRL                  1
`define ALU_SLL                  2
`define ALU_SRA                  4

module
    shifter(
            input [31:0] a,
            output reg [31:0] shift_out,
            input [4:0] shift_func,//connect to alu_func_ctl
            input [31:0] shift_amount//connect to b
        );

    always @ (*)
    begin
        if( shift_func == `ALU_SLL  )
        begin
            case ( shift_amount[4:0] )
                5'b00000: shift_out=a;
                5'b00001: shift_out={a[30:0],1'b0};
                5'b00010: shift_out={a[29:0],2'b0};
                5'b00011: shift_out={a[28:0],3'b0};
                5'b00100: shift_out={a[27:0],4'b0};
                5'b00101: shift_out={a[26:0],5'b0};
                5'b00110: shift_out={a[25:0],6'b0};
                5'b00111: shift_out={a[24:0],7'b0};
                5'b01000: shift_out={a[23:0],8'b0};
                5'b01001: shift_out={a[22:0],9'b0};
                5'b01010: shift_out={a[21:0],10'b0};
                5'b01011: shift_out={a[20:0],11'b0};
                5'b01100: shift_out={a[19:0],12'b0};
                5'b01101: shift_out={a[18:0],13'b0};
                5'b01110: shift_out={a[17:0],14'b0};
                5'b01111: shift_out={a[16:0],15'b0};
                5'b10000: shift_out={a[15:0],16'b0};
                5'b10001: shift_out={a[14:0],17'b0};
                5'b10010: shift_out={a[13:0],18'b0};
                5'b10011: shift_out={a[12:0],19'b0};
                5'b10100: shift_out={a[11:0],20'b0};
                5'b10101: shift_out={a[10:0],21'b0};
                5'b10110: shift_out={a[9:0],22'b0};
                5'b10111: shift_out={a[8:0],23'b0};
                5'b11000: shift_out={a[7:0],24'b0};
                5'b11001: shift_out={a[6:0],25'b0};
                5'b11010: shift_out={a[5:0],26'b0};
                5'b11011: shift_out={a[4:0],27'b0};
                5'b11100: shift_out={a[3:0],28'b0};
                5'b11101: shift_out={a[2:0],29'b0};
                5'b11110: shift_out={a[1:0],30'b0};
                5'b11111: shift_out={a[0],31'b0};
                default shift_out ='d0;
            endcase
        end else if (shift_func== `ALU_SRL) begin
            case (shift_amount[4:0])
                5'b00000: shift_out=a;
                5'b00001: shift_out={1'b0,a[31:1]};
                5'b00010: shift_out={2'b0,a[31:2]};
                5'b00011: shift_out={3'b0,a[31:3]};
                5'b00100: shift_out={4'b0,a[31:4]};
                5'b00101: shift_out={5'b0,a[31:5]};
                5'b00110: shift_out={6'b0,a[31:6]};
                5'b00111: shift_out={7'b0,a[31:7]};
                5'b01000: shift_out={8'b0,a[31:8]};
                5'b01001: shift_out={9'b0,a[31:9]};
                5'b01010: shift_out={10'b0,a[31:10]};
                5'b01011: shift_out={11'b0,a[31:11]};
                5'b01100: shift_out={12'b0,a[31:12]};
                5'b01101: shift_out={13'b0,a[31:13]};
                5'b01110: shift_out={14'b0,a[31:14]};
                5'b01111: shift_out={15'b0,a[31:15]};
                5'b10000: shift_out={16'b0,a[31:16]};
                5'b10001: shift_out={17'b0,a[31:17]};
                5'b10010: shift_out={18'b0,a[31:18]};
                5'b10011: shift_out={19'b0,a[31:19]};
                5'b10100: shift_out={20'b0,a[31:20]};
                5'b10101: shift_out={21'b0,a[31:21]};
                5'b10110: shift_out={22'b0,a[31:22]};
                5'b10111: shift_out={23'b0,a[31:23]};
                5'b11000: shift_out={24'b0,a[31:24]};
                5'b11001: shift_out={25'b0,a[31:25]};
                5'b11010: shift_out={26'b0,a[31:26]};
                5'b11011: shift_out={27'b0,a[31:27]};
                5'b11100: shift_out={28'b0,a[31:28]};
                5'b11101: shift_out={29'b0,a[31:29]};
                5'b11110: shift_out={30'b0,a[31:30]};
                5'b11111: shift_out={31'b0,a[31:31]};
                default : shift_out = 0;
            endcase
        end else
            if (shift_func==`ALU_SRA)
            begin// SHIFT_RIGHT_SIGNED
                case ( shift_amount[4:0])
                    5'b00000: shift_out=a;
                    5'b00001: shift_out={a[31],a[31:1]};
                    5'b00010: shift_out={{2{a[31]}},a[31:2]};
                    5'b00011: shift_out={{3{a[31]}},a[31:3]};
                    5'b00100: shift_out={{4{a[31]}},a[31:4]};
                    5'b00101: shift_out={{5{a[31]}},a[31:5]};
                    5'b00110: shift_out={{6{a[31]}},a[31:6]};
                    5'b00111: shift_out={{7{a[31]}},a[31:7]};
                    5'b01000: shift_out={{8{a[31]}},a[31:8]};
                    5'b01001: shift_out={{9{a[31]}},a[31:9]};
                    5'b01010: shift_out={{10{a[31]}},a[31:10]};
                    5'b01011: shift_out={{11{a[31]}},a[31:11]};
                    5'b01100: shift_out={{12{a[31]}},a[31:12]};
                    5'b01101: shift_out={{13{a[31]}},a[31:13]};
                    5'b01110: shift_out={{14{a[31]}},a[31:14]};
                    5'b01111: shift_out={{15{a[31]}},a[31:15]};
                    5'b10000: shift_out={{16{a[31]}},a[31:16]};
                    5'b10001: shift_out={{17{a[31]}},a[31:17]};
                    5'b10010: shift_out={{18{a[31]}},a[31:18]};
                    5'b10011: shift_out={{19{a[31]}},a[31:19]};
                    5'b10100: shift_out={{20{a[31]}},a[31:20]};
                    5'b10101: shift_out={{21{a[31]}},a[31:21]};
                    5'b10110: shift_out={{22{a[31]}},a[31:22]};
                    5'b10111: shift_out={{23{a[31]}},a[31:23]};
                    5'b11000: shift_out={{24{a[31]}},a[31:24]};
                    5'b11001: shift_out={{25{a[31]}},a[31:25]};
                    5'b11010: shift_out={{26{a[31]}},a[31:26]};
                    5'b11011: shift_out={{27{a[31]}},a[31:27]};
                    5'b11100: shift_out={{28{a[31]}},a[31:28]};
                    5'b11101: shift_out={{29{a[31]}},a[31:29]};
                    5'b11110: shift_out={{30{a[31]}},a[31:30]};
                    5'b11111: shift_out={{31{a[31]}},a[31:31]};
                    default shift_out='d0;
                endcase
            end
            else 			 shift_out='d0;
    end
endmodule
