module multiplier(clk,rst,i_a,i_b,i_vld,exception,overflow,underflow,o_res,o_res_vld);

input clk,rst;

input i_vld;
input [15:0] i_a,i_b;

output exception,overflow,underflow;
output reg [15:0] o_res;
output reg o_res_vld;

wire sign,round,normalised,zero;
wire [5:0] exponent,sum_exponent;
wire [9:0] product_mantissa;  ////
wire [10:0] op_a,op_b;
wire [21:0] product,product_normalised,res; 



wire [15:0] a,b;
assign zero= !(|i_a[14:0]  && |i_b[14:0]);

always @(posedge clk)
begin
	if(rst)
	begin
		o_res <= 16'd0;
		o_res_vld <= 1'b0;
	end
	
	else 
	begin
		o_res <= res;
		o_res_vld <= i_vld;
	end

end

assign a = i_a;
assign b = i_b;


assign sign = a[15] ^ b[15];

  													
assign exception = (&a[14:10]) | (&b[14:10]);								
																							
																																														
assign op_a = (|(a[14:10]) ? {1'b1,a[9:0]} : {1'b0,a[9:0]});		  
assign op_b = (|(b[14:10]) ? {1'b1,b[9:0]} : {1'b0,b[9:0]});


assign product = op_a * op_b ;	// can use modified booth recoding multiplier here instead of * operation
											
assign round = |product_normalised[9:0]; 
 							
assign normalised = product[21] ? 1'b1 : 1'b0;
	
assign product_normalised = normalised ? product : product << 1;								

assign product_mantissa = product_normalised[20:11] + ((&product_normalised[20:11])?1'b0:(product_normalised[10] & round)); 
					
//assign zero = exception ? 1'b0 : (product_mantissa == 10'b0) ? 1'b1 : 1'b0;

assign sum_exponent = a[14:10] + b[14:10];

assign exponent = sum_exponent - 5'd15 + normalised;

assign overflow =((exponent[5] & !exponent[4])) ;
									
assign underflow =((exponent[5] & exponent[4])); 							

assign res = (zero ?({sign,15'd0}): overflow ?({sign,5'b11111,10'b0}) : underflow ? ({sign,15'b0}) : exception ? 16'b0 : {sign,exponent[4:0],product_mantissa});

endmodule

/*
module multiplier_tb;
reg clk,rst;
reg [15:0] a,b;
//wire exception,overflow,underflow;
wire [15:0] res;

multiplier DUT(.clk(clk),.rst(rst),.i_a(a),.i_b(b),.o_res(res));

initial
begin
		
	 clk=0;
	 rst=0;
	 
	 #2
	 rst=1;
	 
	 #5
	 rst=0;
	 
	 #3
         a=16'h3e00; 
	 b=16'hbe00;  //expected c080(1.5x-1.5)
	 
	 #10 
	 a=16'h4640; 
	 b=16'h4400; // expected 4e40 (6.25x4)
	 
	 #10
	 
	 a=16'hc900; 
	 b=16'hc900;  //5640(-10x-10) 

	 #10
	 
	 a=16'h000E;
	 b=16'h000A; //0000
	 
	 #200
	 $finish;
	 
end
always #5 clk=!clk;

endmodule
*/