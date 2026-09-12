`timescale 1ns / 1ps

module digital_clock_tb;

reg clk;
reg reset;

reg set_hour;
reg set_min;
reg set_sec;

reg alarm_enable;
reg [4:0] alarm_hour;
reg [5:0] alarm_min;

reg sw_start_stop;
reg sw_reset;

reg cd_load;
reg cd_start;
reg [4:0] cd_load_hour;
reg [5:0] cd_load_min;
reg [5:0] cd_load_sec;

reg [1:0] mode;

wire [4:0] display_hour;
wire [5:0] display_min;
wire [5:0] display_sec;

wire alarm;
wire countdown_done;


// Instantiate top module
digital_clock_top #(
    .CLK_FREQ(10)
) uut (

    .clk(clk),
    .reset(reset),

    .set_hour(set_hour),
    .set_min(set_min),
    .set_sec(set_sec),

    .alarm_enable(alarm_enable),
    .alarm_hour(alarm_hour),
    .alarm_min(alarm_min),

    .sw_start_stop(sw_start_stop),
    .sw_reset(sw_reset),

    .cd_load(cd_load),
    .cd_start(cd_start),
    .cd_load_hour(cd_load_hour),
    .cd_load_min(cd_load_min),
    .cd_load_sec(cd_load_sec),

    .mode(mode),

    .display_hour(display_hour),
    .display_min(display_min),
    .display_sec(display_sec),

    .alarm(alarm),
    .countdown_done(countdown_done)
);


// Generate clock
always #5 clk = ~clk;


// Test sequence
initial begin
  $dumpfile("dc.vcd");
   $dumpvars(0, digital_clock_tb);

    // Initial values
    clk = 0;
    reset = 1;

    set_hour = 0;
    set_min = 0;
    set_sec = 0;

    alarm_enable = 0;
    alarm_hour = 0;
    alarm_min = 0;

    sw_start_stop = 0;
    sw_reset = 0;

    cd_load = 0;
    cd_start = 0;

    cd_load_hour = 0;
    cd_load_min = 0;
    cd_load_sec = 0;

    mode = 2'b00;

    // Reset
    #20;
    reset = 0;

    // Set clock to 07:29:55

    repeat(7) begin
        set_hour = 1;
        #10;
        set_hour = 0;
        #10;
    end

    repeat(29) begin
        set_min = 1;
        #10;
        set_min = 0;
        #10;
    end

    repeat(55) begin
        set_sec = 1;
        #10;
        set_sec = 0;
        #10;
    end

    // Set alarm = 07:30
    
    alarm_hour = 7;
    alarm_min = 30;
    alarm_enable = 1;

    // Allow clock to run
  
    #200;

    // Stopwatch
    
    mode = 2'b01;

    sw_start_stop = 1;
    #10;
    sw_start_stop = 0;

    #500;


    // Stop stopwatch
    sw_start_stop = 1;
    #10;
    sw_start_stop = 0;

    #300;

    // Countdown

    mode = 2'b10;

    cd_load_hour = 0;
    cd_load_min = 0;
    cd_load_sec = 5;

    cd_load = 1;
    #15;
    cd_load = 0;
    #10;
    cd_start = 1;
    #15;
    cd_start = 0;

    #700;


    // End simulation
    $finish;

end

endmodule