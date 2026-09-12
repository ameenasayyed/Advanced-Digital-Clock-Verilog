module alarm(
    input wire clk,
    input wire reset,
    input wire [4:0] current_hour,
    input wire [5:0] current_min,
    input wire [4:0] alarm_hour,
    input wire [5:0] alarm_min,
    input wire alarm_enable,
    output reg alarm 
  );
  always@(posedge clk or posedge reset)begin
  if(reset)begin
  alarm<=0;
  end
  else begin
  if (alarm_enable && 
      current_hour ==alarm_hour&&
      current_min == alarm_min)begin
      alarm<=1;
      end
      else begin
      alarm<=0;
      end
      end
      end
endmodule