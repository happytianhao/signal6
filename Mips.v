
module Mips( );
	
  reg Clk, Reset;
  
   initial begin
      // $readmemh( "Test_6_Instr.txt", U_IM.IMem ) ; 
      // $readmemh( "Test_Signal_Pipeline.txt", U_IM.IMem ) ; 
      $readmemh( "Sort.txt", U_IM.IMem ) ; 
      
      $monitor("PC = 0x%8X, IR = 0x%8X", U_pcUnit.PC, opCode );        
      Clk = 1 ;
      Reset = 0 ;
      #5 Reset = 1 ;
      #20 Reset = 0 ;
   end
   always
	   #(50) Clk = ~Clk;
	
//PC	
	wire [31:0] pcOut;
//IM	
	wire [7:0]  imAdr;
	wire [31:0] opCode;
	
//GPR
	wire [4:0] gprWeSel,gprReSel1,gprReSel2;
	wire [31:0] gprDataIn;
	
	wire [31:0] gprDataOut1,gprDataOut2;
	
//Extender

	wire [15:0] extDataIn;
	wire [31:0] extDataOut;
	
//DMem

	wire [7:0]  dmDataAdr;
	wire [31:0] dmDataOut;
	
//Ctrl
	wire [25:0]     jumpaddr;
	wire [5:0]		op;
	wire [5:0]		funct;
	wire 		jump;						//指令跳转
	wire 		RegDst;						
	wire 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	wire [1:0]  ExtOp;						//位扩展/符号扩展选择
	wire [4:0]  Aluctrl;						//Alu运算选择

//Alu
	wire [31:0] aluDataIn2;
	wire [31:0]	aluDataOut;
	wire 		zero;
	
	assign pcSel = ((Branch&&zero)==1)?1:0;
	
	
//PC块实例化	
    PcUnit U_pcUnit(.PC(pcOut),.PcReSet(Reset),.PcSel(pcSel),.Jump(jump),.Clk(Clk),.Adress(extDataOut),.Jumpaddr(jumpaddr));
	assign imAdr = pcOut[9:2];
//指令寄存器实例化	
	IM U_IM(.OpCode(opCode),.ImAdress(imAdr));

	assign jumpaddr = opCode[25:0];
	assign op = opCode[31:26];
	assign funct = opCode[5:0];
	assign gprReSel1 = opCode[25:21];
	assign gprReSel2 = opCode[20:16];
	
	//这里和书上不一样，我改成了书上的信号！！！
	assign gprWeSel = (RegDst==0)?opCode[20:16]:opCode[15:11];
	assign extDataIn = opCode[15:0];

	 wire [7:0] o_seg,o_sel;
	 //reg[31:0] disp_data = 32'hAA5555AA;
     wire [31:0] disp_data ;//= 32'hAA5555AA;
	 assign disp_data = (RegW)?gprDataIn:((MemW)?gprDataOut2:pcOut);	
	 seg7x16 U_seg7x16(.clk(Clk), 
                .reset(Reset),
                .i_data(disp_data),
                .o_seg(o_seg ),
                .o_sel(o_sel ));
                
//寄存器堆实例化
	GPR U_gpr(.DataOut1(gprDataOut1),.DataOut2(gprDataOut2),.clk(Clk),.WData(gprDataIn)
			  ,.WE(RegW),.WeSel(gprWeSel),.ReSel1(gprReSel1),.ReSel2(gprReSel2));
//控制器实例化	
	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct));
//扩展器实例化	
	Extender U_extend(.ExtOut(extDataOut),.DataIn(extDataIn),.ExtOp(ExtOp));
	assign aluDataIn2 = (Alusrc==1)?extDataOut:gprDataOut2;//////////
//ALU实例化	
	Alu U_Alu(.AluResult(aluDataOut),.Zero(zero),.DataIn1(gprDataOut1),.DataIn2(aluDataIn2),.Shamt(opCode[10:6]),.AluCtrl(Aluctrl));
	assign gprDataIn = (Mem2R==1)?dmDataOut:aluDataOut;////////////
//DM实例化
	assign dmDataAdr = aluDataOut[9:2];//////////
	DMem U_Dmem(.DataOut(dmDataOut),.DataAdr(dmDataAdr),.DataIn(gprDataOut2),.DMemW(MemW),.DMemR(MemR),.clk(Clk));
endmodule