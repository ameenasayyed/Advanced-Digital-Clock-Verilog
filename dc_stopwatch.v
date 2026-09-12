module stopwatch(
     input wire clk,
     input wire reset,
     input wire tick,
     input wire start_stop,
     input wire sw_reset,
     output reg [5:0] sw_sec,
     output reg [5:0] sw_min,
     output reg [5:0] sw_hour
    );
reg running;
always@(posedge clk or posedge reset) begin
if(reset)begin
sw_sec<=0;
sw_min<=0;
sw_hour<=0;
running<=0;
end
else begin
//stopwatch reset
if(sw_reset) begin
sw_sec<=0;
sw_min<=0;
sw_hour<=0;
end
//start/stop
else if (start_stop)begin
running <= ~running;
end
//counting
else if (tick && running )begin
 if (sw_sec == 59) begin
      sw_sec<=0;
        if (sw_min==59) begin
           sw_min <=0;
            if (sw_hour ==23)
              sw_hour<=0;
            else
              sw_hour <=sw_hour+1;
            end
        else begin
            sw_min<=sw_min+1;
            end
            end
            else begin 
            sw_sec<=sw_sec+1;
            end
            end
            end
            end
             
endmodule
