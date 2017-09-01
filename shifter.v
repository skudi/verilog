module shifter(clk, write, reset, data, out, negout, empty);

	//buffer: [d7..d0,out]

  parameter WIDTH = 8;
	parameter DIFFERANTIAL = 0;
	parameter LSB = 0;

	input clk, write, reset;
	input [WIDTH -1: 0] data;

	output out, negout, empty;
	

	wire clk, write, reset;
	wire [WIDTH -1: 0] data;
	wire out;
	wire negout;
	wire empty;

	//buffer = data bits + output bit
	reg [WIDTH : 0] buffer;
	reg [$clog2(WIDTH+1) : 0] position;

	if (LSB) assign out = buffer[0];
	else assign out = buffer[WIDTH];

	if (DIFFERANTIAL) begin
		if (LSB) assign negout = !buffer[0];
		else assign negout = !buffer[WIDTH];
	end

	assign empty = !position;

	always @reset begin
		if (reset) begin
			assign buffer = 0;
			assign position = 0;
		end else begin
			deassign buffer;
			deassign position;
		end
	end

	always @(posedge clk) begin
		if (position) begin
			if (LSB) buffer <= buffer >> 1;
			else buffer <= buffer << 1;
			position <= position -1;
		end
	end

	always @(posedge write) begin
		position <= WIDTH;
		if (LSB) buffer[WIDTH:1] <= data;
		else buffer[WIDTH-1:0] <= data;
	end

endmodule
