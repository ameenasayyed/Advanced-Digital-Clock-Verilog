module digital_clock(
     input wire clk,
     input wire reset,
     input wire tick,
     input wire set_hour,
     input wire set_min,
     input wire set_sec,
     output reg [4:0] hour,
     output reg [5:0] min,
      output reg [5:0] sec
    );
    always@(posedge clk or posedge reset) begin
    if (reset)begin
    hour<=0;
    min<=0;
    sec<=0;
    end
    else begin
    //manual time setting 
    if(set_hour)begin
    if(hour==23)
    hour<=0;
    else
    hour<=hour+1;
    end
    else if(set_min)begin
    if(min==59)
    min<=0;
    else
    min<=min+1;
    end
    else if(set_sec)begin
    if(sec==59)
    sec<=0;
    else
    sec<=sec+1;
    end
    
    //nrml clk operation
    else if(tick) begin
    if(sec==59) begin
    sec<=0;
    if (min ==59)begin
    min<=0;
    if (hour==23)
    hour<=0; 
    else
    hour<=hour+1;
    end
    else begin
    min<=min+1;
    end
    end
    else begin
    sec<=sec+1;
    end
    end
    end
 end
endmodule