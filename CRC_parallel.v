module serial_line(D, Cin, Cout); //1bit input serial line, serial 8bit CRC generator without register(only combinational logic)
input D; //1bit input 
input [7:0] Cin;
input [7:0] Cout;

// polynomial 'b1001011
assign Cout[0] = D^Cin[7];
assign Cout[1] = Cout[0]^Cin[0];
assign Cout[2] = Cin[1];
assign Cout[3] = Cout[0]^Cin[2];
assign Cout[4] = Cout[0]^Cin[3];
assign Cout[5] = Cin[4];
assign Cout[6] = Cin[5];
assign Cout[7] = Cout[0]^Cin[6];
endmodule 

module parallel_CRC(parallel_in, CLK, RST, CRC); //stack 8layer of serial line module
input [7:0] parallel_in; //input (8bit/clk)
input CLK, RST;
output [7:0]CRC; //output
wire [7:0] temp7, temp6, temp5, temp4, 
           temp3, temp2, temp1;
reg [7:0] Q, D; //Q=output reg, D=input reg

//parallel CRC
serial_line S7(D[7], Q, temp7);    //D[7:0] = parallel in, Q: feedback loop
serial_line S6(D[6], temp7, temp6);
serial_line S5(D[5], temp6, temp5);
serial_line S4(D[4], temp5, temp4);
serial_line S3(D[3], temp4, temp3);
serial_line S2(D[2], temp3, temp2);
serial_line S1(D[1], temp2, temp1);
serial_line S0(D[0], temp1, CRC); //last layer --> output=generate CRC

always @ (posedge CLK, posedge RST) begin
    //initial value
    if (RST) begin Q <= 8'b0; D <= 8'b0; end //reset(init value)
    else begin Q <= CRC; D <= parallel_in; end 
end
endmodule

