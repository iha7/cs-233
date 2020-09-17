// mips_decode: a decoder for MIPS arithmetic instructions
//
// rd_src      (output) - should the destination register be rd (0) or rt (1)
// writeenable (output) - should a new value be captured by the register file
// alu_src2    (output) - should the 2nd ALU source be a register (0), zero extended immediate or sign extended immediate
// alu_op      (output) - control signal to be sent to the ALU
// except      (output) - set to 1 when the opcode/funct combination is unrecognized
// opcode      (input)  - the opcode field from the instruction
// funct       (input)  - the function field from the instruction
//

module mips_decode(rd_src, writeenable, alu_src2, alu_op, except, opcode, funct);
    output       rd_src, writeenable, except;
    output [1:0] alu_src2;
    output [2:0] alu_op;
    input  [5:0] opcode, funct;


wire or1 = (funct == `OP0_OR) & (opcode == `OP_OTHER0);
wire xor1 = (funct == `OP0_XOR) & (opcode == `OP_OTHER0);

wire and1 = (funct == `OP0_AND) & (opcode == `OP_OTHER0);
wire add = (funct == `OP0_ADD) & (opcode == `OP_OTHER0);


wire nor1 = (funct == `OP0_NOR) & (opcode == `OP_OTHER0);
wire sub = (opcode == `OP_OTHER0) & (funct == `OP0_SUB);

wire addi = (opcode == `OP_ADDI);
wire andi = (opcode == `OP_ANDI);

wire xori = (opcode == `OP_XORI);
wire ori = (opcode == `OP_ORI);

assign alu_op[0] = (ori | xori | xor1 | or1 | sub);
assign alu_op[1] = (xori | xor1 | nor1 | add | sub | addi);
assign alu_op[2] = (xori | ori | xor1 | or1 | and1 | nor1 | andi);


assign alu_src2[0] = addi;
assign alu_src2[1] = (andi | ori | xori);
assign rd_src = (andi | addi | xori | ori);
// assign alu_src2 = (addi | andi | xori | ori);


// assign except = (or1 | andi | addi | nor1 | xori | add | and1 | sub | ori | xor1);

assign writeenable = (xor1 | or1 | addi | andi | ori | xori | sub | and1 | add | nor1);

assign except = ~(writeenable);

endmodule // mips_decode

//    // declare and initialize base operation wires
//     wire add = (opcode == `OP_OTHER0) & (funct == `OP0_ADD);
//     wire and_ = (opcode == `OP_OTHER0) & (funct == `OP0_AND);
//     wire sub = (opcode == `OP_OTHER0) & (funct == `OP0_SUB);
//     wire nor_ = (opcode == `OP_OTHER0) & (funct == `OP0_NOR);
//     wire xor_ = (opcode == `OP_OTHER0) & (funct == `OP0_XOR);
//     wire or_ = (opcode == `OP_OTHER0) & (funct == `OP0_OR);
//     wire andi = (opcode == `OP_ANDI);
//     wire addi = (opcode == `OP_ADDI);
//     wire ori = (opcode == `OP_ORI);
//     wire xori = (opcode == `OP_XORI);

//     // assigning alu op values
//     assign alu_op[0] = (sub | xor_ | xori | or_ | ori);
//     assign alu_op[1] = (add | sub | nor_ | xor_ | addi | xori);
//     assign alu_op[2] = (and_| or_ | nor_ | xor_ | andi | ori | xori);

//     // other output values
//     assign alu_src2 = (xori | ori | addi | andi);
//     assign rd_src = (xori | ori | addi | andi);
//     assign writeenable = (add | and_ | sub | nor_ | xor_ | or_ | andi | addi | ori | xori);
//     assign except = (add | and_ | sub | nor_ | xor_ | or_ | andi | addi | ori | xori);

// endmodule // mips_decode
