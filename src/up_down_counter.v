module tt_um_up_down_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire set,
    input wire [3:0] set_value,
    input wire up_down, // 1 for up, 0 for down
    output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 4'b0101;
    else if (set)
        count <= set_value;
    else if (enable) begin
        if (up_down)
            count <= count + 1;
        else
            count <= count - 1;
    end
end

    // Interesting prints based on conditions
always @(count) begin
    if (reset == 0 && set == 0)
        // Output the current count value
        $display("Current count: %b", count);
        if (count == 4'b1111)
            $display("MAX COUNT REACHED!");
        else if (count == 4'b0000)
            $display("MIN COUNT REACHED!");
    
end

endmodule
