module UART_TX_TB #(parameter N=8)();
    reg [N-1:0] P_in;
    reg P_En;
    reg V_input;
    reg P_Bit;
    reg clk, res;
    wire Busy;
    wire Tx_out;

    UART_TX DUT(
        .Busy(Busy),
        .clk(clk),
	.res(res),
        .P_Bit(P_Bit),
        .P_En(P_En),
        .P_in(P_in),
        .V_input(V_input),
        .Tx_out(Tx_out)
    );
    initial begin
        clk=0;
        forever begin
            #5 clk=~clk;
        end
    end

    initial begin 
        $monitor("P_in=%b | P_En=%b | V_input=%b | P_Bit=%b | Busy=%b | Tx_out=%b ",
         P_in, P_En, V_input, P_Bit, Busy, Tx_out);
    end
    initial begin
        res=1'b1; 
	P_in= 8'b0; P_En=1'b0; V_input=1'b0; P_Bit=1'b0;

        #10 res=1'b0;

	#15 res = 1'b1;

        //P_in= 8'b0; P_En=1'b0; V_input=1'b0; P_Bit=1'b0; #10;

        P_in= 8'b11000011; P_En=1'b1; V_input=1'b1; P_Bit=1'b0; #100;

        P_in= 8'b01001111; P_En=1'b1; V_input=1'b1; P_Bit=1'b1; #100;
	
	$finish;
    end


endmodule