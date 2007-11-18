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

`define ALU_MFHI       6 
`define ALU_MFLO       7
`define ALU_MULTTU     8
`define ALU_MULT       9
`define ALU_DIVU       10
`define ALU_DIV        11  	 
`define ALU_MTHI 	   31
`define ALU_MTLO       30



module muldiv
(
ready,rst,op1,op2,
clk,dout,func
);
    input         clk,rst;
    wire       sign;
    input [4:0] func ;
    input [31:0] op2, op1;
    output [31:0] dout;
    output        ready;
    reg [31:0]    quotient, quotient_temp;
    reg [63:0]    dividend_copy, divider_copy, diff;
    reg           negative_output;

    reg [63:0]    product, product_temp;

    reg [31:0]    multiplier_copy;
    reg [63:0]    multiplicand_copy;

    reg [6:0]     mul_bit,div_bit;
    wire          ready = ((mul_bit==0)&&(div_bit==0));

    wire  [31:0]  dividend, divider;

    wire [31:0]  remainder;
    wire [31:0] multiplier,multiplicand;

    reg [31:0] hi,lo;

    assign dout = (func==`ALU_MFHI)?hi:(func==`ALU_MFLO)?lo:0;

    assign  remainder = (!negative_output) ?
            dividend_copy[31:0] :
            ~dividend_copy[31:0] + 1'b1;

    assign multiplier=op2;
    assign multiplicand=op1;
    assign dividend=op1;
    assign  divider = op2;
    assign sign = ((func==`ALU_MULT)||(func==`ALU_DIV));

    always @( posedge clk or negedge rst)
        if (~rst)
        begin
            mul_bit=0;
            div_bit=0;
            hi = 0;
            lo = 0;
            negative_output = 0;
        end
        else
        begin
            if((ready)&&((func==`ALU_MULT)||(func==`ALU_MULTTU)))
            begin
                mul_bit               = 33;
                product           = 0;
                product_temp      = 0;
                multiplicand_copy = (!sign || !multiplicand[31]) ?
                                  { 32'd0, multiplicand } :
                                  { 32'd0, ~multiplicand + 1'b1};
                multiplier_copy   = (!sign || !multiplier[31]) ?multiplier :~multiplier + 1'b1;

                negative_output = sign &&
                                ((multiplier[31] && !multiplicand[31])
                                 ||(!multiplier[31] && multiplicand[31]));
            end
            if ( mul_bit > 1 )
            begin

                if( multiplier_copy[0] == 1'b1 )
                    product_temp = product_temp +multiplicand_copy;


                product = (!negative_output) ?
                        product_temp :
                        ~product_temp + 1'b1;

                multiplier_copy = multiplier_copy >> 1;
                multiplicand_copy = multiplicand_copy << 1;
                mul_bit = mul_bit - 1'b1;
            end
            else if (mul_bit == 1)
            begin
                hi =  product[63:32];
                lo =  product[31:0];
                mul_bit=0;
            end

            if((ready)&&((func==`ALU_DIV)||(func==`ALU_DIVU)))
            begin
                div_bit = 33;
                quotient = 0;
                quotient_temp = 0;
                dividend_copy = (!sign || !dividend[31]) ?
                              {32'd0,dividend} :
                              {32'd0,~dividend + 1'b1};

                divider_copy = (!sign || !divider[31]) ?
                             {1'b0,divider,31'd0} :
                             {1'b0,~divider + 1'b1,31'd0};

                negative_output = sign &&
                                ((divider[31] && !dividend[31])
                                 ||(!divider[31] && dividend[31]));
            end
            else if (div_bit > 1)
            begin
                diff = dividend_copy - divider_copy;
                quotient_temp = quotient_temp << 1;
                if( !diff[63] )
                begin
                    dividend_copy = diff;
                    quotient_temp[0] = 1'd1;
                end
                quotient = (!negative_output) ?quotient_temp :~quotient_temp + 1'b1;
                divider_copy = divider_copy >> 1;
                div_bit = div_bit - 1'b1;
            end
            else if (div_bit == 1)
            begin
                lo =  quotient;
                hi =  remainder;
                div_bit=0;
            end

            if (func==`ALU_MTHI)
                hi=op1 ;
                
            if (func==`ALU_MTLO)
                lo=op1 ;

        end

endmodule



/* I search the multiply and divide module in 
http://www.answers.google.com/answers
and find the two below modules ,
what I have done is combining the two modules and making it work in the mips_core.
original link is (I've no idear whether the link now works or not)
http://www.answers.google.com/answers/threadview?id=109219 
and the original modules is list as below.

module multiply(ready,product,multiplier,multiplicand,sign,clk); 

   input         clk;
   input         sign;
   input [31:0]  multiplier, multiplicand;
   output [63:0] product;
   output        ready;

   reg [63:0]    product, product_temp;

   reg [31:0]    multiplier_copy;
   reg [63:0]    multiplicand_copy;
   reg           negative_output;
   
   reg [5:0]     bit; 
   wire          ready = !bit;

   initial bit = 0;
   initial negative_output = 0;

   always @( posedge clk )

     if( ready ) begin

        bit               = 6'd32;
        product           = 0;
        product_temp      = 0;
        multiplicand_copy = (!sign || !multiplicand[31]) ? 
                            { 32'd0, multiplicand } : 
                            { 32'd0, ~multiplicand + 1'b1};
        multiplier_copy   = (!sign || !multiplier[31]) ?
                            multiplier :
                            ~multiplier + 1'b1; 

        negative_output = sign && 
                          ((multiplier[31] && !multiplicand[31]) 
                        ||(!multiplier[31] && multiplicand[31]));
        
     end 
     else if ( bit > 0 ) begin

        if( multiplier_copy[0] == 1'b1 ) product_temp = product_temp +
multiplicand_copy;

        product = (!negative_output) ? 
                  product_temp : 
                  ~product_temp + 1'b1;

        multiplier_copy = multiplier_copy >> 1;
        multiplicand_copy = multiplicand_copy << 1;
        bit = bit - 1'b1;

     end
endmodule


module divide(ready,quotient,remainder,dividend,divider,sign,clk);

   input         clk;
   input         sign;
   input [31:0]  dividend, divider;
   output [31:0] quotient, remainder;
   output        ready;

   reg [31:0]    quotient, quotient_temp;
   reg [63:0]    dividend_copy, divider_copy, diff;
   reg           negative_output;
   
   wire [31:0]   remainder = (!negative_output) ? 
                             dividend_copy[31:0] : 
                             ~dividend_copy[31:0] + 1'b1;

   reg [5:0]     bit; 
   wire          ready = !bit;

   initial bit = 0;
   initial negative_output = 0;

   always @( posedge clk ) 

     if( ready ) begin

        bit = 6'd32;
        quotient = 0;
        quotient_temp = 0;
        dividend_copy = (!sign || !dividend[31]) ? 
                        {32'd0,dividend} : 
                        {32'd0,~dividend + 1'b1};
        divider_copy = (!sign || !divider[31]) ? 
                       {1'b0,divider,31'd0} : 
                       {1'b0,~divider + 1'b1,31'd0};

        negative_output = sign &&
                          ((divider[31] && !dividend[31]) 
                        ||(!divider[31] && dividend[31]));
        
     end 
     else if ( bit > 0 ) begin

        diff = dividend_copy - divider_copy;

        quotient_temp = quotient_temp << 1;

        if( !diff[63] ) begin

           dividend_copy = diff;
           quotient_temp[0] = 1'd1;

        end

        quotient = (!negative_output) ? 
                   quotient_temp : 
                   ~quotient_temp + 1'b1;

        divider_copy = divider_copy >> 1;
        bit = bit - 1'b1;

     end
endmodule
*/