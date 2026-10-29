module apb_design(pclk, preset_n,pwrite,paddr,pwdata,prdata,pready,penable,pselx);
           input pclk,preset_n,pselx,penable,pwrite;
           input [7:0] paddr,pwdata;
           output pready;
           output reg [7:0]prdata;
           reg [7:0] mem [0:255];

   parameter IDLE=2'b00 ,SETUP=2'b01,ACCESS=2'b10;
     
     reg[1:0] current_state,next_state;

     assign pready=(pselx && penable);


    always@(posedge pclk)
    begin
         if(!preset_n)
             begin
                 prdata<=0;
                 current_state<=IDLE;
             end
             else
                 current_state<=next_state;
     end

     always@(*)
     begin
         case(current_state)
               IDLE:if(pselx==1'b1 && penable==1'b0)
                       next_state<=SETUP;
                    else
                        next_state<=IDLE;

               SETUP:if(pselx==1'b1 && penable==1'b1)
                       next_state<=ACCESS;
                    else if(pselx==1'b1 && penable==1'b0)
                        next_state<=SETUP;
                    else
                        next_state<=IDLE;

               ACCESS:begin
                     if(pselx==1'b1 && penable==1'b1)
                       begin
                           if(pwrite==1'b1)begin 
                           
                               mem[paddr]<=pwdata;
                                $display("WRITE: mem[%h] <= %h", paddr, pwdata);
end
                              
                           else begin
                               prdata<=mem[paddr];
                               $display("READ: mem[%h] = %h", paddr, mem[paddr]);
end

                               next_state<=IDLE;  
                        end    
                             
                               
  
                    else if(pselx==1'b1 && penable==1'b0)
                        next_state<=SETUP;
                    else
                        next_state<=IDLE;
                    end    
         endcase
    end
 endmodule   

          


