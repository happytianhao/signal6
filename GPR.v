
module GPR(DataOut1,DataOut2,clk,WData,WE,WeSel,ReSel1,ReSel2);
	input clk;
	input WE;
	input [4:0] WeSel,ReSel1,ReSel2;
	input [31:0] WData;
	
	output [31:0] DataOut1,DataOut2;
	
	
	reg [31:0] Gpr[31:0];
	
	always@(posedge clk)
	begin
		if(WE == 1)
			Gpr[WeSel] <= WData;
			   $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, Gpr[1], Gpr[2], Gpr[3], Gpr[4], Gpr[5], Gpr[6], Gpr[7]);
         $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[8], Gpr[9], Gpr[10], Gpr[11], Gpr[12], Gpr[13], Gpr[14], Gpr[15]);
         $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[16], Gpr[17], Gpr[18], Gpr[19], Gpr[20], Gpr[21], Gpr[22], Gpr[23]);
         $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", Gpr[24], Gpr[25], Gpr[26], Gpr[27], Gpr[28], Gpr[29], Gpr[30], Gpr[31]);
         $display("R[%4X]=%8X", WeSel, Gpr[WeSel]);
	end
	assign DataOut1 = (ReSel1==0)?0:Gpr[ReSel1];
	assign DataOut2 = (ReSel2==0)?0:Gpr[ReSel2];
	
endmodule