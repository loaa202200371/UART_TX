module Serializer #(
    parameter N = 8
)(
    input wire         clk,
    input wire         res,
    input wire         Ser_En,
    input wire [N-1:0] P_in,
    output reg         Ser_done,
    output reg         Ser_in
);

    reg [N-1:0]       shift_reg;
    reg [$clog2(N):0] counter;

    always @(posedge clk or negedge res) begin
        if (!res) begin
            Ser_done  <= 1'b0;
            Ser_in    <= 1'b0;
            counter   <= 0;
            shift_reg <= 0;
        end 
        else if (Ser_En) begin
            if (counter == 0) begin
                shift_reg <= P_in >> 1;
                Ser_in    <= P_in[0];
                counter   <= counter + 1'b1;
                Ser_done  <= 1'b0;
            end 
            else if (counter < N) begin
                Ser_in    <= shift_reg[0];
                shift_reg <= shift_reg >> 1;
                counter   <= counter + 1'b1;
                if (counter == N - 1) begin
                    Ser_done <= 1'b1;
                end
            end
        end 
        else begin
            counter  <= 0;
            Ser_done <= 1'b0;
            Ser_in   <= 1'b0;
        end
    end

endmodule
