module counter_modk (Clock, Reset_n, Q, rollover);
    parameter n = 8;
    parameter k = 20;

    input  Clock, Reset_n;
    output reg [n-1:0] Q;
    output reg rollover;

    always @(posedge Clock or negedge Reset_n) begin
        if (!Reset_n) begin
            Q        <= 0;
            rollover <= 0;
        end else begin
            if (Q == k-1) begin
                Q        <= 0;
                rollover <= 1;
            end else begin
                Q        <= Q + 1;
                rollover <= 0;
            end
        end
    end
endmodule
