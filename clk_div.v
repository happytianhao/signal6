//`timescale 1ns / 1ps
module clk_div( input clk,
                input rst,
              //  input SW15,
                output Clk_CPU
              );

// Clock divider-Ê±ÖÓ·ÖÆµÆ÷

  reg[31:0]clkdiv;

  always @ (posedge clk or posedge rst) begin 
    if (rst) clkdiv <= 0; else clkdiv <= clkdiv + 1'b1; end

//  assign Clk_CPU=(SW15)? clkdiv[8] : clkdiv[1];
assign Clk_CPU= clkdiv[8]; 

endmodule
