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

module reg_array2(
        data,
        wraddress,
        rdaddress_a,
        rdaddress_b,
        wren,
        clock,
        qa,
        qb,
        rd_clk_cls
    );

    input	[31:0]  data;
    input	[4:0]  wraddress;
    input	[4:0]  rdaddress_a;
    input	[4:0]  rdaddress_b;

    reg	[31:0]  r_data;
    reg	[4:0]  r_wraddress;
    reg	[4:0]  r_rdaddress_a;
    reg	[4:0]  r_rdaddress_b;
    input rd_clk_cls;
    input	wren;
    reg r_wren;
    input	clock;
    output	[31:0]  qa;
    output	[31:0]  qb;
    reg [31:0]reg_bank[0:31];

    assign qa=(r_rdaddress_a==0)?0:
           ((r_wraddress==r_rdaddress_a)&&(r_wren))?r_data:
           reg_bank[r_rdaddress_a];

    assign qb=(r_rdaddress_b==0)?0:
           ((r_wraddress==r_rdaddress_b)&&(r_wren))?r_data:
           reg_bank[r_rdaddress_b];

    always@(posedge clock)
        if (~rd_clk_cls)
        begin
            r_rdaddress_a <=rdaddress_a;
            r_rdaddress_b<=rdaddress_b;
        end
    always@(posedge clock)
    begin
        r_data <=data;
        r_wraddress<=wraddress;
        r_wren<=wren;
    end
    always@(posedge clock)
        if (r_wren)
            reg_bank[r_wraddress] <= r_data ;
endmodule
