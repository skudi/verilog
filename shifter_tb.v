module shifter_tb();

  reg clk = 0;
	always #5 clk = !clk;

	reg reset, write;
	reg [11:0] d;
	wire outp, outn, empty;

	shifter #(.WIDTH(12), .DIFFERANTIAL(1)) s1(
		.write(write),
		.clk(clk),
		.reset(reset),
		.data(d),
		.out(outp),
		.negout(outn),
		.empty(empty)
	);

	initial begin
		$dumpfile("shifter.vcd");
		$dumpvars(0, s1);
		$display("\t\tt\tclk\twrite\tout\tempty\tdata\t(buffer,pos)");
		$monitor("%t\t%d\t%d\t%d%d\t%d\t%h\t(%h,%d)",
			$time, clk, write, outp, outn, empty, d, s1.buffer, s1.position);
		# 2 reset = 1;
		# 15 d = 12'b110011000101;
		# 30 reset = 0;
		# 6 write = 1;
		# 12 write = 0;
		# 100 $finish;
	end

endmodule
