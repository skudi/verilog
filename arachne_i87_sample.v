module top (
    input clk,
    output res
);

    reg [7:0] start;
    always @ (posedge clk)
        if (~start[7]) start <= start + 1;
    assign res = start[7];

endmodule
