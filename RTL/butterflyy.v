module butterflyy #(parameter NBITS = 16)
(
   input wire  clk,
   input wire rst,
   input wire  [NBITS-1:0] Ar,
   input wire  [NBITS-1:0] Ai,
   input wire  [NBITS-1:0] Br,
   input wire  [NBITS-1:0] Bi,
   input wire  [NBITS-1:0] Wr,
   input wire  [NBITS-1:0] Wi,
   output reg  [NBITS-1:0] Xr_F,
   output reg  [NBITS-1:0] Xi_F,
   output reg  [NBITS-1:0] Yr_F,
   output reg  [NBITS-1:0] Yi_F
);

   /**************************
    * Internal Signals
    *************************/

   // Intermediate values used to store the product of B and W(twiddle factor).
   
   wire  [NBITS-1:0] Zr_a;
   wire  [NBITS-1:0] Zr_b;
   wire  [NBITS-1:0] Zi_a;
   wire  [NBITS-1:0] Zi_b;
   
   // Intermediate values used to store partial output sums.

   wire  [NBITS-1:0] Zrsub;	
   wire  [NBITS-1:0] Ziadd;
	

  // Input to registers holding the results.
   wire  [NBITS-1:0] Xr;
   wire  [NBITS-1:0] Xi;
   wire [NBITS-1:0] Yr;
   wire  [NBITS-1:0] Yi;
   //reg [NBITS-1:0] Xr_FF;
   //reg [NBITS-1:0] Xi_FF;
	//reg [NBITS-1:0] Yr_FF;
	//reg [NBITS-1:0] Yi_FF;
	
	reg [NBITS-1:0] Ar_F;
	reg [NBITS-1:0] Ai_F;
  
    reg [NBITS-1:0] Ar_FF;
    reg [NBITS-1:0] Ai_FF;
   /**************************
    * Data Path
    *************************/

always @(posedge clk)
begin
     if(rst)
	begin
	 Xr_F<=16'b0;
	 Xi_F<=16'b0;
	 Yr_F<=16'b0;
	 Yi_F<=16'b0;
	end
     else
	begin
	
	 Ar_F<=Ar;
	 Ai_F<=Ai;
	 
	 Ar_FF<=Ar_F;
	 Ai_FF<=Ai_F;
	 
	 //Xr_FF<=Xr;
	 //Xi_FF<=Xi;
	 //Yr_FF<=Yr;
	 //Yi_FF<=Yi;
	 
	 Xr_F<=Xr;
	 Xi_F<=Xi;
	 Yr_F<=Yr;
	 Yi_F<=Yi;
	end

end

	multiplier m1(.clk(clk),.rst(rst),.i_a(Br),.i_b(Wr),.i_vld(1'b1),.o_res(Zr_a));
	multiplier m2(.clk(clk),.rst(rst),.i_a(Bi),.i_b(Wi),.i_vld(1'b1),.o_res(Zr_b));
	multiplier m3(.clk(clk),.rst(rst),.i_a(Br),.i_b(Wi),.i_vld(1'b1),.o_res(Zi_a));
	multiplier m4(.clk(clk),.rst(rst),.i_a(Bi),.i_b(Wr),.i_vld(1'b1),.o_res(Zi_b));
	
	adder_single_cycle int1(.clk(clk),.rst(rst),.i_a(Zr_a),.i_b({(Zr_b[15] ^1'b1),Zr_b[14:0]}),.i_vld(1'b1),.o_res(Zrsub));  //subtraction so flipping the sign bit to force subtraction
	adder_single_cycle int2(.clk(clk),.rst(rst),.i_a(Zi_a),.i_b(Zi_b),.i_vld(1'b1),.o_res(Ziadd));                           // 
	
	adder_single_cycle o1_r(.clk(clk),.rst(rst),.i_a(Ar_FF),.i_b(Zrsub),.i_vld(1'b1),.o_res(Xr));
	adder_single_cycle o1_i(.clk(clk),.rst(rst),.i_a(Ai_FF),.i_b(Ziadd),.i_vld(1'b1),.o_res(Xi));
	adder_single_cycle o2_r(.clk(clk),.rst(rst),.i_a(Ar_FF),.i_b({(Zrsub[15] ^ 1'b1),Zrsub[14:0]}),.i_vld(1'b1),.o_res(Yr));  // x(-1)
	adder_single_cycle o2_i(.clk(clk),.rst(rst),.i_a(Ai_FF),.i_b({(Ziadd[15] ^ 1'b1),Ziadd[14:0]}),.i_vld(1'b1),.o_res(Yi));  // x(-1)


endmodule