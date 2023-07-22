module tb_CRC_parallel ();
reg CLK, RST;
reg [7:0]parallel_in; //8bits parallel input
wire [7:0] CRC;//output(CRC)
reg [71:0] message; //data + CRC
integer i, EN, message_length;

parallel_CRC parallel_CRC(parallel_in, CLK, RST, CRC); //parallel CRC 

always #1 if(EN) begin CLK = ~CLK; end //CLK generate
    
initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, tb_CRC_parallel); //for icarus verilog compile code
       
    CLK = 0; RST = 1; EN=1; 
    ///// input MESSAGE /////
    message = {64'd18346244063708551516, 8'h0}; // 64bit = data, 8bit = CRC
    message_length = 72; #1 RST = 0;
    for ( i = 1 ; i <= message_length ; i = i + 8 ) begin
        parallel_in[7] = message[message_length - i];
        parallel_in[6] = message[message_length - i - 1];
        parallel_in[5] = message[message_length - i - 2];
        parallel_in[4] = message[message_length - i - 3]; 
        parallel_in[3] = message[message_length - i - 4];
        parallel_in[2] = message[message_length - i - 5];
        parallel_in[1] = message[message_length - i - 6];
        parallel_in[0] = message[message_length - i - 7]; 
        #2 RST = 0;
    end
    parallel_in = 8'hxx;
    #15 EN = 0; //finish CLK generating 
    $finish; 
    end
endmodule
