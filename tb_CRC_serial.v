module tb_CRC_serial();
reg CLK, RST, in; //in = serial input
wire [7:0] CRC1, CRC2; //output(CRC)
reg [40:0] message; //data + CRC
integer i, EN, message_length;

CRC_serial_1 method1(in, CLK, RST, CRC1); //method1
CRC_serial_2 method2(in, CLK, RST, CRC2); //method2

always #1 if(EN) begin CLK = ~CLK; end //CLK generate
    
initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, tb_CRC_serial); //for icarus verilog compile code
       
    CLK = 0; RST = 1; EN=1; 
    ///////// input MESSAGE //////////
    message = {32'hD, 8'h0}; // 64bit = data, 8bit = CRC
    message_length = 40; //message length (DATA+input_CRC)
    #1 RST = 0;
    for ( i = 1 ; i <= message_length ; i = i + 1 ) begin
        in = message[message_length - i]; #2; //serial input
    end
    in = 1'bx;
    #15 EN = 0; //finish CLK generating 
    $finish; 
    end
endmodule

