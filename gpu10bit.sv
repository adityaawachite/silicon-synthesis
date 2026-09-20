
module simple_gpu (
    input  logic        clk,        // system clock
    input  logic        rst_n,      // active-low reset
    input  logic [7:0]  pixel_in,   // 8-bit input pixel
    input  logic [1:0]  op_sel,     // operation select
    output logic [7:0]  pixel_out   // 8-bit output pixel
);

    // Internal registers
    logic [7:0] pixel_reg;
    logic [7:0] result_reg;

    // Sequential logic: load pixel
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_reg  <= 8'd0;
            result_reg <= 8'd0;
        end else begin
            pixel_reg <= pixel_in;

            // ALU operations
            case (op_sel)
                2'b00: result_reg <= pixel_reg + 8'd10;   // brighten
                2'b01: result_reg <= pixel_reg - 8'd10;   // darken
                2'b10: result_reg <= pixel_reg & 8'hF0;   // mask high bits
                2'b11: result_reg <= ~pixel_reg;          // invert
            endcase
        end
    end

    // Output assignment
    assign pixel_out = result_reg;

endmodule