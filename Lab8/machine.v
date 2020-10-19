// module machine(clk, reset);
//    input        clk, reset;

//    wire [31:0]  PC;
//    wire [31:2]  next_PC, PC_plus4, PC_target;
//    wire [31:0]  inst;

//    wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
//    wire [4:0]   rs = inst[25:21];
//    wire [4:0]   rt = inst[20:16];
//    wire [4:0]   rd = inst[15:11];

//    wire [4:0]   wr_regnum;
//    wire [2:0]   ALUOp;

//    wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET;
//    wire         PCSrc, zero, negative;
//    wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;

//    //Your extra wires go here


//    register #(30, 30'h100000) PC_reg(PC[31:2], next_PC[31:2], clk, /* enable */1'b1, reset);
//    assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
//    adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
//    adder30 target_PC_adder(PC_target, PC_plus4, imm[29:0]);
//    mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
//    assign PCSrc = BEQ & zero;

//    instruction_memory imem (inst, PC[31:2]);

//    mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET,
//                       inst);

//    regfile rf (rd1_data, rd2_data,
//                rs, rt, wr_regnum, wr_data,
//                RegWrite, clk, reset);

//    mux2v #(32) imm_mux(B_data, rd2_data, imm, ALUSrc);
//    alu32 alu(alu_out_data, zero, negative, ALUOp, rd1_data, B_data);

//    data_mem data_memory(load_data, alu_out_data, rd2_data, MemRead, MemWrite, clk, reset);

//    mux2v #(32) wb_mux(wr_data, alu_out_data, load_data, MemToReg);
//    mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);
   
//    //Connect your new modules below
   

// endmodule // machine


module machine(clk, reset);
   input        clk, reset;

   wire [31:0]  PC;
   wire [31:2]  next_PC, PC_plus4, PC_target;
   wire [31:0]  inst;

   wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
   wire [4:0]   rs = inst[25:21];
   wire [4:0]   rt = inst[20:16];
   wire [4:0]   rd = inst[15:11];

   wire [4:0]   wr_regnum;
   wire [2:0]   ALUOp;
   wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET;
   wire         PCSrc, zero, negative, notio;
   wire [31:0]  tdata, rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data, c0wr_data, taddress;

	assign c0wr_data = rd2_data;
	assign taddress = alu_out_data;
	assign tdata = rd2_data;
	assign notio = ~TimerAddress;

	wire [31:2] next_PC2, ERETout;
    wire MemRead_, MemWrite_;

    wire [31:0] wr_data2, el_tiempo, c0rd_data;
	wire TimerInterrupt, TimerAddress;

	wire [29:0] EPC;
   	wire TakenInterrupt;

    assign el_tiempo = 32'h80000180;

    mux2v #(30) mux_uno(ERETout, next_PC2, EPC, ERET);
    mux2v #(30) mux_uno_dos(next_PC, ERETout, el_tiempo[31:2], TakenInterrupt);

	register #(30, 30'h100000) reg_pc(PC[31:2], next_PC[31:2], clk, 1'b1, reset);

    assign PC[1:0] = 2'b0;

	//adders

    adder30 pc_nex5t(PC_plus4, PC[31:2], 30'h1);
    adder30 pc_bullseye(PC_target, PC_plus4, imm[29:0]);

	//switch

    mux2v #(30) mux_branch(next_PC2, PC_plus4, PC_target, PCSrc);
    assign PCSrc = BEQ & zero;

    instruction_memory ello (inst, PC[31:2]);
    mips_decode dec_der(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET, inst);

    regfile rf (rd1_data, rd2_data, rs, rt, wr_regnum, wr_data, RegWrite, clk, reset);

    mux2v #(32) mux_(B_data, rd2_data, imm, ALUSrc);
    alu32 alu(alu_out_data, zero, negative, ALUOp, rd1_data, B_data);
    
	//make sure to assign

	assign MemRead_ = MemRead&notio;
   	assign MemWrite_ = MemWrite&notio;
    
	data_mem mem_dat(load_data, alu_out_data, rd2_data, MemRead_, MemWrite_, clk, reset);

    //last muxes


	mux2v #(32) mux_wba(wr_data2, alu_out_data, load_data, MemToReg);
	mux2v #(32) mux_wbb(wr_data, wr_data2, c0rd_data, MFC0);
    mux2v #(5) mux_rdd(wr_regnum, rt, rd, RegDst);
    
   	timer t_1(TimerInterrupt, load_data, TimerAddress, tdata, taddress, MemRead, MemWrite, clk, reset);
  	cp0 c_1(c0rd_data, EPC, TakenInterrupt,wr_regnum, c0wr_data, next_PC2, TimerInterrupt, MTC0, ERET, clk, reset);

endmodule // machine