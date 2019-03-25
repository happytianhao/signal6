`include "instruction_def.v"
`include "ctrl_encode_def.v"

module Ctrl(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,ExtOp,Aluctrl,OpCode,funct);
	
	input [5:0]		OpCode;				//指令操作码字段
	input [5:0]		funct;				//指令功能字段

	output reg jump;						//指令跳转
	output reg RegDst;						
	output reg Branch;						//分支
	output reg MemR;						//读存储器
	output reg Mem2R;						//数据存储器到寄存器堆
	output reg MemW;						//写数据存储器
	output reg RegW;						//寄存器堆写入数据
	output reg Alusrc;						//运算器操作数选择
	output reg [1:0] ExtOp;						//位扩展/符号扩展选择
	output reg [4:0] Aluctrl;						//Alu运算选择
	
	/*
	assign jump = 1;
	assign RegDst = OpCode[0];
	assign Branch = !(OpCode[0]||OpCode[1])&&OpCode[2];
	assign MemR = (OpCode[0]&&OpCode[1]&&OpCode[5])&&(!OpCode[3]);
	assign Mem2R = MemR;
	assign MemW = OpCode[1]&&OpCode[0]&&OpCode[3]&&OpCode[5];
	assign RegW = (OpCode[2]&&OpCode[3])||(!OpCode[2]&&!OpCode[3]);
	assign Alusrc = OpCode[0]||OpCode[1];
	assign ExtOp = OpCode[2]&&OpCode[3];
    */

	always@(OpCode or funct)
	begin
        case (OpCode)
            `INSTR_RTYPE_OP: 
                begin
                jump=0;
                RegDst=1;
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=1;
                Alusrc=0;
                ExtOp=`EXT_ZERO;
                case (funct)
                    `INSTR_ADDU_FUNCT: Aluctrl=`ALUOp_ADDU;
                    `INSTR_SUBU_FUNCT: Aluctrl=`ALUOp_SUBU;
                    `INSTR_ADD_FUNCT:  Aluctrl=`ALUOp_ADD;
                    `INSTR_SUB_FUNCT:  Aluctrl=`ALUOp_SUB;
                    `INSTR_AND_FUNCT:  Aluctrl=`ALUOp_AND;
                    `INSTR_OR_FUNCT:   Aluctrl=`ALUOp_OR;
                    `INSTR_SLL_FUNCT:  Aluctrl=`ALUOp_SLL;
                    `INSTR_SRL_FUNCT:  Aluctrl=`ALUOp_SRL;
                    `INSTR_SLT_FUNCT:  Aluctrl=`ALUOp_SLT;
                    default: ;
                endcase
                end
            `INSTR_ORI_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=1;
                Alusrc=1;
                ExtOp=`EXT_ZERO;
                Aluctrl=`ALUOp_OR;
                end
            `INSTR_SW_OP:
                begin
                jump=0;
                RegDst=0;//x
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=1;
                RegW=0;
                Alusrc=1;
                ExtOp=`EXT_SIGNED;
                Aluctrl=`ALUOp_ADD;
                end
            `INSTR_LW_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=0;
                MemR=1;
                Mem2R=1;
                MemW=0;
                RegW=1;
                Alusrc=1;
                ExtOp=`EXT_SIGNED;
                Aluctrl=`ALUOp_ADD;
                end
            `INSTR_BEQ_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=1;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=0;
                Alusrc=0;
                ExtOp=`EXT_SIGNED;
                Aluctrl=`ALUOp_EQL;
                end
            `INSTR_LUI_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=1;
                Alusrc=1;
                ExtOp=`EXT_HIGHPOS;
                Aluctrl=`ALUOp_ADDU;
                end
            `INSTR_BNE_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=1;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=0;
                Alusrc=0;
                ExtOp=`EXT_SIGNED;
                Aluctrl=`ALUOp_BNE;
                end
            `INSTR_J_OP:
                begin
                jump=1;
                RegDst=0;
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=0;
                Alusrc=0;
                ExtOp=`EXT_ZERO;
                Aluctrl=`ALUOp_ADD;
                end
            `INSTR_SLTI_OP:
                begin
                jump=0;
                RegDst=0;
                Branch=0;
                MemR=0;
                Mem2R=0;
                MemW=0;
                RegW=1;
                Alusrc=1;
                ExtOp=`EXT_SIGNED;
                Aluctrl=`ALUOp_SLT;
                end
            default: ;
        endcase
		/* Aluctrl[1] = ExtOp;
		if((OpCode[1]||OpCode[2]) == 0)
			Aluctrl[0] = funct[1];
		else
			Aluctrl[0] = !(OpCode[1]||OpCode[0]); */
	end
endmodule
