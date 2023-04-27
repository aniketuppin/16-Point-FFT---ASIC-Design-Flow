module butterflyy_tb ;
parameter NBITS=16;
reg clk,rst;
reg [NBITS-1:0] Ar,Ai,Br,Bi,Wr,Wi;
wire [NBITS-1:0] Xr_F,Xi_F,Yr_F,Yi_F;

butterflyy #(16)test (.clk(clk),.rst(rst),.Ar(Ar),.Br(Br),.Ai(Ai),.Bi(Bi),.Wr(Wr),.Wi(Wi),.Xr_F(Xr_F),.Yr_F(Yr_F),.Xi_F(Xi_F),.Yi_F(Yi_F));

initial
begin
  forever 
	#10 clk=!clk;
end

initial
begin
clk=1'b0; 
rst=1'b1;
#1 rst=1'b0;
/*
#4 Ar=16'h4900;
Ai=16'h0000;
Br=16'h4500;
Bi=16'h0000;
Wr=16'hc200;
Wi=16'h0000;

#20 Ar=16'h4000;
Ai=16'h3c00;
Br=16'hbda8;
Bi=16'hbc00;
Wr=16'h3da8;
Wi=16'h3c00;

#20 Ar=16'h4000;
Ai=16'h4000;
Br=16'h4000;
Bi=16'h4000;
Wr=16'hc000;
Wi=16'hc000;
*/

#4 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#20 Ar=16'h4c00;
Ai=16'h0;
Br=16'h4c00;
Bi=16'h0;

#1000 $finish;
end

initial
begin
      $display("Xr = %d", Xr_F);
      $display("Xi = %d", Xi_F);
      $display("Yr = %d", Yr_F);
      $display("Yi = %d", Yi_F);

      $display("Xr = %16b", Xr_F);
      $display("Xi = %16b", Xi_F);
      $display("Yr = %16b", Yr_F);
      $display("Yi = %16b", Yi_F);

end
endmodule



