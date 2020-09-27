// mips_decode: a decoder for MIPS arithmetic instructions
//
// alu_op       (output) - control signal to be sent to the ALU
// writeenable  (output) - should a new value be captured by the register file
// rd_src       (output) - should the destination register be rd (0) or rt (1)
// alu_src2     (output) - should the 2nd ALU source be a register (0) or an immediate (1)
// except       (output) - set to 1 when we don't recognize an opdcode & funct combination
// control_type (output) - 00 = fallthrough, 01 = branch_target, 10 = jump_target, 11 = jump_register 
// mem_read     (output) - the register value written is coming from the memory
// word_we      (output) - we're writing a word's worth of data
// byte_we      (output) - we're only writing a byte's worth of data
// byte_load    (output) - we're doing a byte load
// slt          (output) - the instruction is an slt
// lui          (output) - the instruction is a lui
// addm         (output) - the instruction is an addm
// opcode        (input) - the opcode field from the instruction
// funct         (input) - the function field from the instruction
// zero          (input) - from the ALU
//

// module mips_decode(alu_op, writeenable, rd_src, alu_src2, except, control_type,
//                    mem_read, word_we, byte_we, byte_load, slt, lui, addm,
//                    opcode, funct, zero);
//     output [2:0] alu_op;
//     output [1:0] alu_src2;
//     output       writeenable, rd_src, except;
//     output [1:0] control_type;
//     output       mem_read, word_we, byte_we, byte_load, slt, lui, addm;
//     input  [5:0] opcode, funct;
//     input        zero;


//     wire addi = (opcode == `OP_ADDI);
//     wire andi = (opcode == `OP_ANDI);
//     wire ori = (opcode == `OP_ORI);
//     wire xori = (opcode == `OP_XORI);

//     wire or1 = (opcode == `OP_OTHER0) & (funct == `OP0_OR);
//     wire nor1 = (opcode == `OP_OTHER0) & (funct == `OP0_NOR);
//     wire xor1 = (opcode == `OP_OTHER0) & (funct == `OP0_XOR);
//     wire add = (opcode == `OP_OTHER0) & (funct == `OP0_ADD);
//     wire sub = (opcode == `OP_OTHER0) & (funct == `OP0_SUB);
//     wire andd = (opcode == `OP_OTHER0) & (funct == `OP0_AND);


//     wire lw1 = (opcode == `OP_LW);
//     wire lbu1 = (opcode == `OP_LBU);
//     wire sw1 = (opcode == `OP_SW);
//     wire sb1 = (opcode == `OP_SB);
//     wire bne1 = (opcode == `OP_BNE);
//     wire beq1 = (opcode == `OP_BEQ);
//     wire j1 = (opcode == `OP_J);
//     wire lui1 = (opcode == `OP_LUI);

//     wire addm1 = (opcode == `OP_OTHER0) & (funct == `OP0_ADDM);
//     wire slt1 = (opcode == `OP_OTHER0) & (funct == `OP0_SLT);
//     wire jr1 = (opcode == `OP_OTHER0) & (funct == `OP0_JR);
//     assign control_type[0] = ((bne1 & ~zero) | (beq1 & zero) | jr1);
//     assign control_type[1] = (j1 | jr1);

//     assign alu_op[0] = (xori | bne1 | beq1 | slt1 | sub | or1 | xor1 | ori);
//     assign alu_op[1] = (add | sub | beq1 | lw1 | lbu1 | sw1 | sb1 | slt1 | nor1 | xor1 | addi | xori | bne1);
//     assign alu_op[2] = (xor1 | andi | ori | xori | andd | or1 | nor1);
//     assign writeenable = (andi | ori | xori | lw1 | lbu1 | lui1 | slt1 | addm1 | add | sub | andd | or1 | nor1 | xor1 | addi);
//     assign rd_src = (lw1 | lbu1 | lui1 | addi | andi | ori | xori);
//     assign alu_src2 = (lw1 | lbu1 | sw1 | sb1 | addi | andi | ori | xori);
//     assign except = ~(nor1 | xor1 | addi | andi | lw1 | lbu1 | sw1 | sb1 | addm1 | add | sub | andd | or1 | ori | xori | bne1 | beq1 | j1 | jr1 | lui1 | slt1);

//     endmodule // mips_decode



module mips_decode(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                   mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                   opcode, funct, zero);
    output [2:0] alu_op;
    output  alu_src2;
    output       writeenable, rd_src, except;
    output [1:0] control_type;
    output       mem_read, word_we, byte_we, byte_load, slt, lui, addm;
    input  [5:0] opcode, funct;
    input        zero;



    wire addi = (opcode == `OP_ADDI);
    wire andi = (opcode == `OP_ANDI);
    wire ori = (opcode == `OP_ORI);
    wire xori = (opcode == `OP_XORI);

    wire or1 = (opcode == `OP_OTHER0) & (funct == `OP0_OR);
    wire nor1 = (opcode == `OP_OTHER0) & (funct == `OP0_NOR);
    wire xor1 = (opcode == `OP_OTHER0) & (funct == `OP0_XOR);
    wire add = (opcode == `OP_OTHER0) & (funct == `OP0_ADD);
    wire sub = (opcode == `OP_OTHER0) & (funct == `OP0_SUB);
    wire andd = (opcode == `OP_OTHER0) & (funct == `OP0_AND);


    wire lw1 = (opcode == `OP_LW);
    wire lbu1 = (opcode == `OP_LBU);
    wire sw1 = (opcode == `OP_SW);
    wire sb1 = (opcode == `OP_SB);
    wire bne1 = (opcode == `OP_BNE);
    wire beq1 = (opcode == `OP_BEQ);
    wire j1 = (opcode == `OP_J);
    wire lui1 = (opcode == `OP_LUI);

    wire addm1 = (opcode == `OP_OTHER0) & (funct == `OP0_ADDM);
    wire slt1 = (opcode == `OP_OTHER0) & (funct == `OP0_SLT);
    wire jr1 = (opcode == `OP_OTHER0) & (funct == `OP0_JR);


    assign control_type[0] = ((bne1 & ~zero) | (beq1 & zero) | jr1);
    assign control_type[1] = (j1 | jr1);

    assign alu_op[0] = (xori | bne1 | beq1 | slt1 | sub | or1 | xor1 | ori);
    assign alu_op[1] = (add | sub | beq1 | lw1 | lbu1 | sw1 | sb1 | slt1 | nor1 | xor1 | addi | xori | bne1);
    assign alu_op[2] = (xor1 | andi | ori | xori | andd | or1 | nor1);
    assign writeenable = (andi | ori | xori | lw1 | lbu1 | lui1 | slt1 | addm1 | add | sub | andd | or1 | nor1 | xor1 | addi);
    assign rd_src = (lw1 | lbu1 | lui1 | addi | andi | ori | xori);
    assign alu_src2 = (lw1 | lbu1 | sw1 | sb1 | addi | andi | ori | xori);
    assign except = ~(nor1 | xor1 | addi | andi | lw1 | lbu1 | sw1 | sb1 | addm1 | add | sub | andd | or1 | ori | xori | bne1 | beq1 | j1 | jr1 | lui1 | slt1);



    assign lui = lui1;
    assign slt = slt1;
    assign word_we = sw1;
    assign byte_we = sb1;
    assign mem_read = (lw1 | lbu1 | addm1);
    assign addm = addm1;
    assign byte_load = lbu1;
    //test

endmodule // mips_decode