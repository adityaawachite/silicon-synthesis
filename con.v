
module tiny_controller (
    input wire clk, rst,
    output reg [1:0] state
);
    always @(posedge clk or posedge rst)
        if (rst) state <= 2'b00;
        else     state <= state + 1;
endmodule
