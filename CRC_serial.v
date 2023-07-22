module CRC_serial_1 (D, CLK, RST, Q); //method1
input CLK, RST;
input D; //input(data)
output reg [7:0] Q; //CRC


always @ (posedge CLK, posedge RST) begin
    if (RST) Q <= 8'b0; //initial value
    //shift regiser
    else Q <= {Q[6]^Q[7] , Q[5], Q[4] ,Q[3]^Q[7], Q[2]^Q[7], Q[1], Q[0]^Q[7], D^Q[7]}; // polynomial 'b1001011
end
endmodule

module CRC_serial_2 (D, CLK, RST, Q); //method2
input CLK, RST;
input D; //input(data)
output reg [7:0] Q; //CRC 

always @ (posedge CLK, posedge RST) begin
    if (RST) Q <= 8'b0; //initial value
    //shift regiser
    else Q <= {Q[6]^D^Q[7] , Q[5], Q[4] ,Q[3]^D^Q[7], Q[2]^D^Q[7], Q[1], Q[0]^D^Q[7], D^Q[7]}; // polynomial 'b1001011
end
endmodule

