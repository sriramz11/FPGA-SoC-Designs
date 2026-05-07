module part2_bcd_counter (
    input        CLOCK_50,
    input  [0:0] KEY,          // KEY[0] = reset (active low)
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2
);
    wire reset_n = KEY[0];

    // 1 Hz divider: 50 MHz / 50,000,000 = 1 Hz
    wire [25:0] div_q;        // enough bits to count to 50M-1
    wire        tick_1hz;

    counter_modk divider (
        .Clock    (CLOCK_50),
        .Reset_n  (reset_n),
        .Q        (div_q),
        .rollover (tick_1hz)
    );
    defparam divider.n = 26;
    defparam divider.k = 50000000;   // 50e6

    // 3-digit BCD counter
    reg [3:0] ones  = 4'd0;
    reg [3:0] tens  = 4'd0;
    reg [3:0] hunds = 4'd0;

    always @(posedge CLOCK_50 or negedge reset_n) begin
        if (!reset_n) begin
            ones  <= 4'd0;
            tens  <= 4'd0;
            hunds <= 4'd0;
        end else if (tick_1hz) begin
            // Increment BCD 000–999
            if (ones == 4'd9) begin
                ones <= 4'd0;
                if (tens == 4'd9) begin
                    tens <= 4'd0;
                    if (hunds == 4'd9)
                        hunds <= 4'd0;
                    else
                        hunds <= hunds + 4'd1;
                end else begin
                    tens <= tens + 4'd1;
                end
            end else begin
                ones <= ones + 4'd1;
            end
        end
    end

    // Drive 7-seg displays (HEX0 = least significant digit)
    bcd7seg u0 (.bcd(ones),  .seg(HEX0));
    bcd7seg u1 (.bcd(tens),  .seg(HEX1));
    bcd7seg u2 (.bcd(hunds), .seg(HEX2));

endmodule