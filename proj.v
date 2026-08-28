module UART_TX #(parameter N=8)(
    input wire [N-1:0]P_in,
    input wire P_En,
    input wire V_input,
    input wire P_Bit,
    input wire clk, res,
    output wire Busy,
    output wire Tx_out

);

    wire Ser_done;
    wire Ser_En;
    wire Par_bit;
    wire [1:0]Sel;
    wire Ser_in;

    Par_calc #(.N(N)) Par_calc_1(
        .V_input(V_input),
        .P_in(P_in),
        .P_Bit(P_Bit),
        .clk(clk),
        .res(res),
	.Par_bit(Par_bit)
    );

    Serializer #(.N(N)) Serializer_1(
        .P_in(P_in),
        .Ser_En(Ser_En),
        .Ser_in(Ser_in),
        .Ser_done(Ser_done),
        .clk(clk),
        .res(res)
    );

    FSM_control FSM_control_1(
        .Busy(Busy),
        .Sel(Sel),
        .Ser_En(Ser_En),
        .Ser_done(Ser_done),
        .V_input(V_input),
        .P_En(P_En),
        .clk(clk),
        .res(res)
    );


    MUX MUX_1(
        .Ser_in(Ser_in),
        .Par_bit(Par_bit),
        .Sel(Sel),
        .Tx_out(Tx_out)
    );
    

endmodule