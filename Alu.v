`include "ctrl_encode_def.v"
module Alu(AluResult,Zero,DataIn1,DataIn2,AluCtrl);

	input  [31:0] 		DataIn1;		//运算数据1
	input  [31:0]		DataIn2;		//运算数据2
	input  [4:0]		AluCtrl;		//运算器控制信号
	
	output reg[31:0]		AluResult;		//运算器输出结果
	output reg				Zero;			//结果是否为零
	
    // integer shamt;

	initial								//初始化数据
	begin
		Zero = 0;
		AluResult = 0;
        // shamt = DataIn2[10:6];
        // shamt = DataIn2[6]+DataIn2[7]*2+DataIn2[8]*4+DataIn2[9]*8+DataIn2[10]*16;
	end	
	
	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
        Zero = (DataIn1 == DataIn2) ? 1 : 0;
        case ( AluCtrl )
            `ALUOp_ADDU: AluResult = DataIn1 + DataIn2;
            `ALUOp_SUBU: AluResult = DataIn1 - DataIn2;
            `ALUOp_OR: AluResult = DataIn1 | DataIn2;
            `ALUOp_ADD: AluResult = DataIn1 + DataIn2;
            `ALUOp_SUB: AluResult = DataIn1 - DataIn2;
            `ALUOp_SLL: AluResult = AluResult << DataIn2[10:6];
            `ALUOp_SRL: AluResult = AluResult >> DataIn2[10:6];
            `ALUOp_BNE: Zero = (DataIn1 != DataIn2) ? 1 : 0;
            `ALUOp_SLT: AluResult = (DataIn1 < DataIn2);
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
