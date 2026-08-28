module FSM_control (
    input wire P_En,
    input wire clk, res,
    input wire V_input,
    input wire Ser_done,
    output reg Ser_En,
    output reg [1:0] Sel,
    output reg Busy
);

    reg [1:0] current_state, next_state;

    localparam S0_IDLE   = 2'b00,
               S1_DATA   = 2'b01,
               S2_PARITY = 2'b10,
               S3_STOP   = 2'b11;
    always @(posedge clk or negedge res) begin
        if (!res) begin
            current_state <= S0_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        Ser_En     = 1'b0;
        Busy       = 1'b1;
        Sel        = 2'b01;

        case (current_state)
            S0_IDLE: begin
                Busy = 1'b0;
                Sel  = 2'b01;
                if (V_input && P_En) begin
                    next_state = S1_DATA;
                end
            end

            S1_DATA: begin
                Ser_En = 1'b1;
                Sel    = 2'b11;
                if (Ser_done) begin
                    next_state = S2_PARITY;
                end
            end

            S2_PARITY: begin
                Sel = 2'b10;
                next_state = S3_STOP;
            end

            S3_STOP: begin
                Sel = 2'b01 ;
                next_state = S0_IDLE;
            end
            default: next_state = S0_IDLE;
        endcase
    end

endmodule
