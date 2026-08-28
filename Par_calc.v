module Par_calc #(parameter N = 8)(
    input  wire         P_Bit,
    input  wire         clk,
    input  wire         res,
    input  wire         V_input,
    input  wire [N-1:0] P_in,
    output reg          Par_bit
);

    always @(posedge clk or negedge res) begin
        if (!res) begin
            Par_bit <= 1'b0;
        end
        else if (V_input) begin
            if (P_Bit == 1'b0) begin
                Par_bit <= ^P_in;
            end
            else begin
                Par_bit <= ~^P_in;
            end
        end
    end

endmodule
