module test;

  /* Make a reset that pulses once. */
  reg reset = 0;
  initial begin
		 $display("t\tc\tv");
     $monitor("%t %d %h (%0d)",
              $time, clk, value, value);
     # 17 reset = 1;
     # 11 reset = 0;
     # 29 reset = 1;
     # 11 reset = 0;
		 # 100 $finish;
     //# 100 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #5 clk <= !clk;

  wire [7:0] value;
  counter c1 (value, clk, reset);

endmodule // test
