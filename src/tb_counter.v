`timescale 1ns / 1ps

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module tb_counter;

// Inputs
reg clk;
reg reset;
reg enable;
reg set;
reg [3:0] set_value;
reg up_down;

// Output
wire [3:0] count;

// Instantiate the Unit Under Test (UUT)
tt_um_up_down_counter uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .set(set),
    .set_value(set_value),
    .up_down(up_down),
    .count(count)
);

// Clock generation
always #5 clk = ~clk; // 100MHz clock

initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    enable = 0;
    set = 0;
    set_value = 4'b0000;
    up_down = 1;

    // Apply reset
    reset = 1;
    //repeat (5) @(posedge clk);
    #50;
    reset = 0;

    // Set counter value in module (reset condition)
    set = 1;
    #10;
    set = 0;

    // Enable counting up
    $display("---TB: Counting up---");
    enable = 1;
    up_down = 1; // Count up
    //#repeat (20) @(posedge clk);
    #50;

    // Enable counting down
    $display("---TB: Counting down---");
    up_down = 0; // Count down
    //repeat (20) @(posedge clk);
    #50;

    // Disable counting
    enable = 0;
    #20;

    $stop;
end

endmodule
