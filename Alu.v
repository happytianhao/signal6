`include "ctrl_encode_def.v"
module Alu(AluResult,Zero,DataIn1,DataIn2,Shamt,AluCtrl);

	input  [31:0] 		DataIn1;		//运算数据1
	input  [31:0]		DataIn2;		//运算数据2
	input  [4:0]		AluCtrl;		//运算器控制信号
    input  [4:0]        Shamt;
	
	output reg[31:0]		AluResult;		//运算器输出结果
	output reg				Zero;			//结果是否为零
	
	initial								//初始化数据
	begin
		Zero = 0;
		AluResult = 0;
	end	
	
	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
        Zero = (DataIn1 == DataIn2) ? 1 : 0;
        case ( AluCtrl )
            `ALUOp_ADDU: AluResult = DataIn1 + DataIn2;
            `ALUOp_SUBU: AluResult = DataIn1 - DataIn2;
            `ALUOp_AND: AluResult = DataIn1 & DataIn2;
            `ALUOp_OR: AluResult = DataIn1 | DataIn2;
            `ALUOp_ADD: AluResult = DataIn1 + DataIn2;
            `ALUOp_SUB: AluResult = DataIn1 - DataIn2;
            `ALUOp_SLL: AluResult = DataIn2 << Shamt;
            `ALUOp_SRL: AluResult = DataIn2 >> Shamt;
            `ALUOp_EQL: AluResult = DataIn1 - DataIn2;
            `ALUOp_BNE: 
                begin 
                    AluResult = DataIn1 - DataIn2;
                    Zero = (DataIn1 != DataIn2) ? 1 : 0;
                end
            `ALUOp_SLT: AluResult = (DataIn1[31] == DataIn2[31]) ? (DataIn1 < DataIn2) : (DataIn1[31] > DataIn2[31]);
            default: ;
        endcase

        // Zero = (DataIn1 == DataIn2) ? 1 : 0;

		// if(AluCtrl == 0)
		// 	AluResult = DataIn1+DataIn2;
		// else
		// 	if(AluCtrl == 1)
		// 		AluResult = DataIn1-DataIn2;
		// 	else
		// 	    if(AluCtrl == 2)
		// 			AluResult = DataIn1|DataIn2;
		
		
		// if(AluResult == 0)
		// 	Zero = 1;
		// else
		// 	Zero = 0;
	end

endmodule
