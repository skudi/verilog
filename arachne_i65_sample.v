// change "3" to "2" (two times) to avoid assertion
module test(input clk, output led);
reg[3:0] a;
assign led = a[0];
always @(posedge clk)
	if (a[3]) a <= a + 1;
endmodule

