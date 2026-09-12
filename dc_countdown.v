module countdown(
     input wire clk,
     input wire reset,
     input wire tick,
     input wire load,
     input wire start,
     input wire [4:0] load_hour,
     input wire [5:0] load_min,
     input wire [5:0] load_sec,
     output reg [4:0] cd_hour,
     output reg [5:0] cd_min,
     output reg [5:0] cd_sec,
     output reg done
   );
   reg running;
always@(posedge clk or posedge reset) begin
   if(reset)begin
    cd_hour <=0;
    cd_min<=0;
    cd_sec<=0;
    running<=0;
    done<=0;
    end
    else if (load) begin
    
       cd_hour<= load_hour;
        cd_min<= load_min;
         cd_sec<= load_sec;
         running<=0;
         done<=0;
         end
         else if (start) begin 
            running<= 1;
            done<=0;
         end
         else if(tick && running )begin
         if (cd_hour == 0&&
             cd_min ==0 &&
             cd_sec ==0) begin
         
             running <=0;
             done<=1;
             end
             else if (cd_hour == 0&&
             cd_min ==0 &&
             cd_sec ==1) begin
               cd_sec<=0;
             running <=0;
             done<=1;
             end
             else if (cd_sec>0) begin
             cd_sec <= cd_sec -1;
             end
             else if (cd_min>0) begin 
             cd_min<=cd_min-1;
             cd_min <=59;
             end
             
             else if(cd_hour>0) begin
             cd_hour<=cd_hour-1;
             cd_min <=59;
             cd_sec<=59;
         end
             end
end
            
       
endmodule
