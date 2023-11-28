`timescale 1ns/1ps


module fft_top_tb;

   /****************************************************************************
    * Signals
    ***************************************************************************/

   reg                clk;
   reg                reset;

   reg                in_push;
   reg signed [15:0]  in_real;
   reg signed [15:0]  in_imag;
   wire               in_stall;

   wire               out_push;
   wire signed [15:0] out_real;
   wire signed [15:0] out_imag;
   reg                out_stall;

   integer            i;
   integer            r;

   /****************************************************************************
    * Generate Clock Signals
    ***************************************************************************/

   // 250 MHz clock
   initial clk = 1'b1;
   always #10 clk = ~clk;

   /****************************************************************************
    * Instantiate Modules
    ***************************************************************************/

   fft_top fft_top_0 (
      .clk        (clk),
      .reset      (reset),
      .in_push    (in_push),
      .in_real    (in_real),
      .in_imag    (in_imag),
      .in_stall   (in_stall),
      .out_push_F (out_push),
      .out_real_F (out_real),
      .out_imag_F (out_imag),
      .out_stall  (out_stall)
   );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/

   // Record the input data.
	
	integer count1=0;
   initial begin: RECORD_INPUT

      integer input_file;
      

      input_file = $fopen("C:/Users/Aniket/Desktop/Fast-Fourier-Transform/matlab/data_in2.m", "w");

      $fdisplay(input_file, "Testing...");
            $fdisplay(input_file, "Testing...");

      while (count1 < 16) begin

         @(posedge clk);

         if (in_push === 1'b1 && in_stall === 1'b0) begin

            $display("in(%0d) = %0h + i*%0h;",
               count1 + 1, in_real, in_imag);

            $fdisplay(input_file, "in(%0h) = %0h + i*%0h;",
               count1 + 1, in_real, in_imag);

            count1 = count1 + 1;

         end

      end

   end

   // Record the output data.
	
	integer count=0;
   initial begin: RECORD_OUTPUT

      integer output_file;
      integer j;

      output_file = $fopen("C:/Student Programs/verilog_files/output_files/data_out2.m");

      while (count < 16) begin

         @(posedge clk);

         if (out_push === 1'b1 && out_stall === 1'b0) begin

            $display("out(%0d) = %0h + i*%0h;",
               count + 1, out_real, out_imag);

            $fwrite(output_file, "out(%0h) = %0h + i*%0h;\n",
               count + 1, out_real, out_imag);

            count = count + 1;

         end

      end

   end

   // Apply stimulus.
	
   initial begin

      repeat (1) @(posedge clk);

      reset = 1'b1;
      repeat (1) @(posedge clk);

      reset = 1'b0;
      in_push = 1'b0;
      in_real = 0;
      in_imag = 0;
      out_stall = 0;
      repeat (1) @(posedge clk);
		
      for (i = 0; i < 16; i = i+1) begin

         in_push = 1'b1;

         // Case (i)
         in_real = (i == 0 || i==1 || i==2 || i==3 )? 16'h4c00 : 0;
         in_imag = 16'h0;



         repeat (1) @(posedge clk);

      end

      in_push = 1'b0;
      repeat (1) @(posedge clk);

      for (i = 0; i < 16; i = i+1) begin

         while (out_push == 1'b0)
            @(posedge clk);

         //$display("%04x %04x (%0h %0h)", out_real, out_imag, out_real, out_imag);
         @(posedge clk);

      end

      repeat (5) @(posedge clk);

      $finish;

   end

endmodule
