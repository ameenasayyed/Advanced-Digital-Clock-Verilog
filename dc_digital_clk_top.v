module digital_clock_top #(
    parameter CLK_FREQ = 100_000_000
)(
    input wire clk,
    input wire reset,

    // Clock setting
    input wire set_hour,
    input wire set_min,
    input wire set_sec,

    // Alarm
    input wire alarm_enable,
    input wire [4:0] alarm_hour,
    input wire [5:0] alarm_min,

    // Stopwatch
    input wire sw_start_stop,
    input wire sw_reset,

    // Countdown
    input wire cd_load,
    input wire cd_start,
    input wire [4:0] cd_load_hour,
    input wire [5:0] cd_load_min,
    input wire [5:0] cd_load_sec,

    // Mode
    input wire [1:0] mode,

    // Display outputs
    output wire [4:0] display_hour,
    output wire [5:0] display_min,
    output wire [5:0] display_sec,

    output wire alarm,
    output wire countdown_done
);

wire tick;

wire [4:0] clock_hour;
wire [5:0] clock_min;
wire [5:0] clock_sec;

wire [5:0] sw_hour;
wire [5:0] sw_min;
wire [5:0] sw_sec;

wire [4:0] cd_hour;
wire [5:0] cd_min;
wire [5:0] cd_sec;


// Clock divider
clock_divider #(
    .CLK_FREQ(CLK_FREQ)
) divider (
    .clk(clk),
    .reset(reset),
    .tick(tick)
);


// Digital clock
digital_clock clock_unit (
    .clk(clk),
    .reset(reset),
    .tick(tick),

    .set_hour(set_hour),
    .set_min(set_min),
    .set_sec(set_sec),

    .hour(clock_hour),
    .min(clock_min),
    .sec(clock_sec)
);


// Alarm
alarm alarm_unit (
    .clk(clk),
    .reset(reset),

    .current_hour(clock_hour),
    .current_min(clock_min),

    .alarm_hour(alarm_hour),
    .alarm_min(alarm_min),

    .alarm_enable(alarm_enable),

    .alarm(alarm)
);


// Stopwatch
stopwatch stopwatch_unit (
    .clk(clk),
    .reset(reset),
    .tick(tick),

    .start_stop(sw_start_stop),
    .sw_reset(sw_reset),

    .sw_sec(sw_sec),
    .sw_min(sw_min),
    .sw_hour(sw_hour)
);


// Countdown
countdown countdown_unit (
    .clk(clk),
    .reset(reset),
    .tick(tick),

    .load(cd_load),
    .start(cd_start),

    .load_hour(cd_load_hour),
    .load_min(cd_load_min),
    .load_sec(cd_load_sec),

    .cd_hour(cd_hour),
    .cd_min(cd_min),
    .cd_sec(cd_sec),

    .done(countdown_done)
);


// Mode selector
assign display_hour =
        (mode == 2'b00) ? clock_hour :
        (mode == 2'b01) ? sw_hour :
        cd_hour;

assign display_min =
        (mode == 2'b00) ? clock_min :
        (mode == 2'b01) ? sw_min :
        cd_min;

assign display_sec =
        (mode == 2'b00) ? clock_sec :
        (mode == 2'b01) ? sw_sec :
        cd_sec;

endmodule