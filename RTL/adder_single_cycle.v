module adder_single_cycle(clk,rst,i_a,i_b,i_vld,o_res,o_res_vld,overflow); // capable of both addition and substraction of float 16 inputs

input clk,rst;
input [15:0] i_a,i_b;
input		 i_vld;


output reg [15:0] o_res;
output reg		  o_res_vld;
output overflow;

wire [12:0] mantissa_10,mantissa_20;
wire [12:0] mantissa_11,mantissa_21;  //(extra 3 bits required)
wire [13:0] mantissa_sum;
wire [10:0] mantissa_final; // 11 bits (10+1 intrinsic)
wire [4:0]  exponent_final;
wire sign_res;

wire exception_a,exception_b,zero_a,zero_b,zero_ip;

wire [15:0] a,b;
wire [15:0] res;

assign a = i_a;
assign b = i_b;

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

assign exception_a=(&a[14:10]);
assign exception_b=(&b[14:10]);
assign zero_a=!(|a[14:0]);
assign zero_b=!(|b[14:0]);
assign zero_ip= zero_a && zero_b;



assign mantissa_10 = (|a[14:10]) ? {3'b001,a[9:0]} : {3'b000,a[9:0]};   // assigned 13 bits		  
assign mantissa_20 = (|b[14:10]) ? {3'b001,b[9:0]} : {3'b000,b[9:0]};

wire [4:0] exponent_res;

compare_and_shift cas(mantissa_10,mantissa_20,a[14:10],b[14:10],exponent_res,mantissa_11,mantissa_21);
addition_s add(a[15],b[15],mantissa_11,mantissa_21,mantissa_sum);
normalisation_s norm(a[7],b[7],mantissa_sum,exponent_res,mantissa_final,exponent_final,sign_res,overflow);

assign res=(zero_ip?({sign_res,15'd0}):exception_a?{a[15],5'b11111,10'b0}:exception_b?{b[15],5'b11111,10'b0}:overflow?{1'b0,5'b11111,10'b0}:zero_a?b:zero_b?a:{sign_res,exponent_final,mantissa_final[9:0]});
endmodule

module addition_s(signa,signb,mantissa_11,mantissa_21,mantissa_sum);

input signa,signb;
input [12:0] mantissa_11,mantissa_21;

output [13:0] mantissa_sum;

wire [12:0] Mantissa_11,Mantissa_21;

assign Mantissa_11 = (signa?(-mantissa_11):mantissa_11);
assign Mantissa_21 = (signb?(-mantissa_21):mantissa_21);

assign mantissa_sum = Mantissa_11+Mantissa_21; // can instantiate full adder here instead of + operation

endmodule 

module compare_and_shift(mantissa_10,mantissa_20,ein_a,ein_b,exponent_res,mantissa_11,mantissa_21);
input [12:0] mantissa_10,mantissa_20;
input [4:0] ein_a,ein_b;


output reg [4:0] exponent_res;
output reg [12:0] mantissa_11,mantissa_21 ;

always @(*)
begin
		 
	if(ein_a==ein_b)
	begin
		 mantissa_11=mantissa_10;
		 mantissa_21=mantissa_20;
		 exponent_res=ein_a+8'd1; // helpful for normalisation
	end
	
	else if(ein_a>ein_b)
	begin
		mantissa_11=mantissa_10;
		mantissa_21=(mantissa_20>>(ein_a-ein_b)); // adjusting to normalize b
		exponent_res=ein_a+8'd1;
	end
	
	else
	begin
		mantissa_11=(mantissa_10>>(ein_b-ein_a)); // normalizing a since it is the smaller one
		mantissa_21=mantissa_20;
		exponent_res=ein_b+8'd1;
	end
	
end
endmodule

module normalisation_s(signa_int,signb_int,mantissa_sum,exponent_res,mantissa_final,exponent_final,sign_res,overflow);

input [13:0] mantissa_sum;
input [4:0] exponent_res;

input signa_int,signb_int;
 
output reg [10:0] mantissa_final;   //including the instrinsic bit so 11
output reg [4:0] exponent_final;
output sign_res;
output reg overflow;
wire [13:0] Mantissa_sum;      // 14 bit sum

assign sign_res=mantissa_sum[12];

assign Mantissa_sum=(mantissa_sum[12]?(-mantissa_sum):mantissa_sum);

always @(*)
begin
	
	overflow=0;
	if(Mantissa_sum[12:0]==13'b0)
	begin
		mantissa_final=11'b0;
		exponent_final=5'b0;
	end
	
	else
	begin
		mantissa_final=Mantissa_sum[11:1];
      exponent_final=exponent_res;
		
		repeat(11)
		begin
         if(mantissa_final[10]==0)
          begin
              mantissa_final=(mantissa_final<<1'b1);
              exponent_final=exponent_final-1'b1;
          end
		end
		
		if(exponent_final==5'b11111)
		begin
			overflow=1;
		end
		
	end
	
end
endmodule