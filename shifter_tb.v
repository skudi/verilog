module shifter_tb();

  reg clk = 0;
	always #5 clk = !clk;

	reg reset, write;
	reg [7:0] d;
	wire out, empty;

	shifter #(.WIDTH(7)) s1(.write(write), .clk(clk), .reset(reset), .data(d), .out(out), .empty(empty));

	initial begin
		$dumpfile("shifter.vcd");
		$dumpvars(0, s1);
		$display("\t\tt\tclk\twrite\tout\tempty\tdata\t(buffer,pos)");
		$monitor("%t\t%d\t%d\t%d\t%d\t%h\t(%h,%d)",
			$time, clk, write, out, empty, d, s1.buffer, s1.position);
		# 2 reset = 1;
		# 15 d = 8'b11000001;
		# 30 reset = 0;
		# 6 write = 1;
		# 12 write = 0;
		# 100 $finish;
	end

endmodule
