// module pipelined_machine(clk, reset);
//     input        clk, reset;

//     wire [31:0]  PC;
//     wire [31:2]  next_PC, PC_plus4, PC_target;
//     wire [31:0]  inst;

//     wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
//     wire [4:0]   rs = inst[25:21];
//     wire [4:0]   rt = inst[20:16];
//     wire [4:0]   rd = inst[15:11];
//     wire [5:0]   opcode = inst[31:26];
//     wire [5:0]   funct = inst[5:0];

//     wire [4:0]   wr_regnum;
//     wire [2:0]   ALUOp;


//     wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst;


//     wire         PCSrc, zero;
//     wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;





//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     register #(30, 30'h100000) PC_reg(PC[31:2], next_PC[31:2], clk, /* enable */1'b1, reset);
//     assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
//     adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
//     adder30 target_PC_adder(PC_target, PC_plus4, imm[29:0]);
//     mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
//     assign PCSrc = BEQ & zero;

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     instruction_memory imem(inst, PC[31:2]);



//     mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst,
//                       opcode, funct);










//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     regfile rf (rd1_data, rd2_data,
//                rs, rt, wr_regnum, wr_data,
//                RegWrite, clk, reset);

//     mux2v #(32) imm_mux(B_data, rd2_data, imm, ALUSrc);
//     alu32 alu(alu_out_data, zero, ALUOp, rd1_data, B_data);

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     data_mem data_memory(load_data, alu_out_data, rd2_data, MemRead, MemWrite, clk, reset);

//     mux2v #(32) wb_mux(wr_data, alu_out_data, load_data, MemToReg);
//     mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);



module pipelined_machine(clk, reset);
    input        clk, reset;

    wire [31:0]  PC;
    wire [31:2]  next_PC, PC_plus4, PC_target, PC_;
    wire [31:0]  inst;
    wire [31:1]  ppt

    wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
    wire [4:0]   rs = inst[25:21];
    wire [4:0]   rt = inst[20:16];
    wire [4:0]   rd = inst[15:11];
    wire [5:0]   opcode = inst[31:26];
    wire [5:0]   funct = inst[5:0];

    wire [4:0]   wr_regnum, wr_regnum0;
    wire [2:0]   ALUOp, ALUOp0;

    wire         RegWrite0, BEQ0, ALUSrc0, MemRead0, MemWrite0, MemToReg0, RegDst0, tmp0, tmp1;
    wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst;
    wire         PCSrc, zero;
    wire [31:0]  rd1_data0, rd2_data0. rd2_data01, B_data0, alu_out_data0;
    wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;

    assign tmp0 = ((rs == wr_regnum0) && RegWrite0 && (rs != 0));
    assign tmp1 = ((rt == wr_regnum0) && RegWrite0 && (rt != 0));
    assign Stall = ((wr_regnum_MW == rs && rs != 0) || (wr_regnum0 == rt && rt != 0)) && (MemRead0);
    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(30, 30'h100000) PC_reg(PC[31:2], next_PC[31:2], clk, /* enable */1'b1, reset);

    assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
    adder30 next_PC_adder(PC_plus4, PC[31:2], 30'h1);
    adder30 target_PC_adder(PC_target, PC_plus4, imm[29:0]);
    mux2v #(30) branch_mux(next_PC, PC_plus4, PC_target, PCSrc);
    assign PCSrc = BEQ & zero;

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory imem(inst, PC[31:2]);
    register #(32) check1(inst, ppt, clk, ~Stall, PCSrc || reset);
	register #(30) check2(PC_plus4, PC_, clk, ~Stall, PCSrc || reset);
    mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst,
                      opcode, funct);
    register #(1) outsr(RegWrite0, RegWrite, clk, 1'b1, PCSrc);
	register #(1) outbeq(BEQ0, BEQ, clk, 1'b1, PCSrc);
    register #(3) outalu(ALUOp0, ALUOp, clk, 1'b1, PCSrc);
	register #(1) outmem1(MemToReg0, MemToReg, clk, 1'b1, PCSrc);
	register #(1) outreg1(RegDst0, RegDst, clk, 1'b1, PCSrc);
	register #(1) outalu1(ALUSrc0, ALUSrc, clk, 1'b1, PCSrc);
    register #(1) outmem1(MemRead0, MemRead, clk, 1'b1, PCSrc);
	register #(1) outmem1(MemWrite0, MemWrite, clk, 1'b1, PCSrc);


    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf (rd1_data, rd2_data,
               rs, rt, wr_regnum, wr_data,
               RegWrite, clk, reset);

    mux2v #(32) imm_mux(B_data, rd2_data01, imm, ALUSrc);
    alu32 alu(alu_out_data, zero, ALUOp, rd1_data, B_data);

    // DO NOT comment out or rename this module
    // or the test bench will break
    data_mem data_memory(load_data, alu_out_data0, rd2_data0, MemRead0, MemWrite0, clk, reset);
    register #(32) reg0(alu_out_data0, alu_out_data, clk, 1'b1, PCSrc);
    register #(5) reg01(wr_regnum0, wr_regnum, clk, 1'b1, PCSrc);
	register #(32) reg00(rd2_data0, rd2_data01, clk, 1'b1, PCSrc);
    mux2v #(32) muxf1(rd1_data, rd1_data0, alu_out_data0, tmp0);
	mux2v #(32) muxf11(rd2_data01, rd2_data, alu_out_data0, tmp1);
    mux2v #(32) newmux0(wr_data, alu_out_data0, load_data, MemToReg0);
    mux2v #(5) newmux1(wr_regnum, rt, rd, RegDst);


endmodule // pipelined_machine
