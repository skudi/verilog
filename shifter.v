module shifter(clk, write, reset, data, out, negout, empty);

	//buffer: [d7..d0,out]

  parameter WIDTH = 8;
	parameter DIFFERANTIAL = 0;

	input clk, write, reset;
	input [WIDTH -1: 0] data;

	output out, negout, empty;
	

	wire clk, write, reset;
	wire [WIDTH -1: 0] data;
	wire out, negout;

	if (DIFFERANTIAL) begin
		assign negout = !buffer[0];
	end

	wire empty;

	//buffer = data bits + output bit
	reg [WIDTH : 0] buffer;
	reg [$clog2(WIDTH+1) : 0] position;

	assign out = buffer[0];

	assign empty = !position;

	always @reset
		if (reset) begin
			assign buffer = 0;
			assign position = 0;
		end else begin
			deassign buffer;
			deassign position;
		end

	always @(posedge clk) begin
		if (position) begin
			buffer <= buffer >> 1;
			position <= position -1;
		end
	end

	always @(posedge write) begin
		position <= WIDTH;
		buffer[WIDTH:1] <= data;
	end

endmodule
