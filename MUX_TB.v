module Mux_TB();
    reg B_start;
    reg B_end;
    reg Ser_in;
    reg Par_calc;
    reg [1:0]Sel;
    wire Tx_out;

    MUX DUT(
        .B_start(B_start),
        .B_end(B_end),
        .Ser_in(Ser_in),
        .Par_calc(Par_calc),
        .Sel(Sel),
        .Tx_out(Tx_out)
    );
	initial begin
	$monitor("B_start=%b |B_end=%b |Ser_in=%b |Par_calc=%b |Sel=%b |Tx_out=%b", 
	B_start, B_end, Ser_in, Par_calc, Sel, Tx_out );
	end
    initial begin
        B_start=1'b0;
        B_end=1'b1;
        Ser_in=1'b0;
        Par_calc=1'b1;

        #10;
        Sel=2'b00; #10;
        Sel=2'b01; #10;
        Sel=2'b10; #10;
        Sel=2'b11; #10;
    end
endmodule

