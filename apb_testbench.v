`include "apb_design.v"
module apb_testbench;
   
     reg pclk,preset_n,penable,pselx,pwrite;
     reg [7:0] paddr,pwdata;
     wire [7:0] prdata;
     wire pready;
reg [7:0]data[0:2];
reg [7:0]addr[0:2]; //to store memory write addresses---if we use reg[7:0]addr--one register store only one address if we repeat also it will overwritten so three address to store three registers required
integer i;
     apb_design dut(.pclk(pclk),
                    .preset_n(preset_n),
                    .pselx(pselx),
                    .penable(penable),
                    .pwrite(pwrite),
                    .paddr(paddr),
                    .pwdata(pwdata),
                    .prdata(prdata),
                    .pready(pready)
                    );
   //clock generation  
  initial pclk=0;
   always #5 pclk=~pclk;
   
   //reset generation
   initial begin
      preset_n=0;
#10;  preset_n=1;
        end

 //initializing all signals zero to bring unknown state to known state to avaoid waveforms become confusing
 initial begin
      pselx=0;
      penable=0;
      pwrite=0;
      paddr=0;
      pwdata=0;

  end  
//-------------------APB write transcation------------------
initial
begin
#10;
 for(i=0; i<3;i=i+1)

     begin
     addr[i]=$random;
     data[i]=$random;

   //setup phase
   
    pselx = 1;
    penable = 0;
    pwrite = 1;
    paddr=addr[i];
    pwdata=data[i];
       
    #10;
    //access
    penable = 1;

     #10;
    $display("write :Addr=%h data%h",paddr,pwdata);
    pselx = 0;
    penable = 0;
#10;
 end   

//---------------------- APB Read Transaction----------------
  for(i=0; i<3;i=i+1)  //here not generating a new address.reusing the address stored by the first loop in write transaction i used here two loops because i want to complete first write transaction after read should happenif i use same loop then write and read alternatively happens.
  begin 
    //setup
    pselx = 1;
    penable = 0;
    pwrite = 0;
    paddr =addr[i];
      
    #10;
    penable = 1;

    #10;
    $display("Read Data = %h", prdata);

    pselx = 0;
    penable = 0;
    #10;
end    
 #150 $finish;

end


endmodule 
