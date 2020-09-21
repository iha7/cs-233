// // arith_machine: execute a series of arithmetic instructions from an instruction cache
// //
// // except (output) - set to 1 when an unrecognized instruction is to be executed.
// // clock  (input)  - the clock signal
// // reset  (input)  - set to 1 to set all registers to zero, set to 0 for normal execution.

// module arith_machine(except, clock, reset);
//     output      except;
//     input       clock, reset;

//     wire [31:0] inst;  
//     wire [31:0] PC;  

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     register #(32) PC_reg( /* connect signals */ );

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     instruction_memory im( /* connect signals */ );

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     regfile rf ( /* connect signals */ );

//     /* add other modules */
   
// endmodule // arith_machine




// module arith_machine(except, clock, reset);
//     output      except;
//     input       clock, reset;


//     wire [31:0] inst;
//     wire [31:0] PC;

//     wire [4:0] rdest;
//     wire [31:0] n_PC, rs_dat, rt_dat, rd_dat, B, imm32;
//     wire overflow, zero, negative, wr_en, rd_src, alu_src2;
//     wire [2:0] alu_op;

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     register #(32) PC_reg(PC, n_PC, clock, 1'b1, reset);

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     instruction_memory im(inst[31:0], PC[31:2]);

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     regfile rf(rs_dat, rt_dat, inst[25:21], inst[20:16], rdest, rd_dat, wr_en, clock, reset);

//     /* add other modules */
//     mux2v b_mux(B, rt_dat, imm32, alu_src2);
//     alu32 ralu(rd_dat, overflow, zero, negative, rs_dat, B, alu_op);
//     mips_decode ddee(alu_op, wr_en, rd_src, alu_src2, except, inst[31:26], inst[5:0]);
//     se sit(imm32, inst[15:0]);
//     alu32 palu(n_PC, , , , PC, 32'b100, `ALU_ADD);
//     mux2v #(5) d_mux(rdest, inst[15:11], inst[20:16], rd_src);

// endmodule // arith_machine
// module se(imm32, imm16);
//     input [15:0] imm16;
//     output [32:0] imm32;
//     assign imm32[15:0] = imm16[15:0];
//     assign imm32[31:16] = {16{imm16[15]}};
// endmodule // Si_ex


// arith_machine: execute a series of arithmetic instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock  (input)  - the clock signal
// reset  (input)  - set to 1 to set all registers to zero, set to 0 for normal execution.

module arith_machine(except, clock, reset);
    output      except;
    input       clock, reset;


    wire [31:0] inst;
    wire [31:0] PC;

    wire [4:0] rdes;
    wire [31:0] n_PC, rs_dat, rt_dat, rd_dat, B, imm32;
    wire overflow, zero, negative, wr_en, rd_src;
    wire [2:0] alu_op;
    wire [1:0] alu_src2;

    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, n_PC, clock, 1'b1, reset);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst[31:0], PC[31:2]);

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf(rs_dat, rt_dat, inst[25:21], inst[20:16], rdes, rd_dat, wr_en, clock, reset);

    /* add other modules */
    mux2v b_mux(B, rt_dat, imm32, alu_src2[1]);
    alu32 ralu(rd_dat, overflow, zero, negative, rs_dat, B, alu_op);
    mips_decode ddee(rd_src, wr_en, alu_src2, alu_op, except, inst[31:26], inst[5:0]);
    se sit(imm32, inst[15:0]);
    alu32 palu(n_PC, , , , PC, 32'b100, `ALU_ADD);
    mux2v #(5) d_mux(rdes, inst[15:11], inst[20:16], rd_src);

endmodule // arith_machine
module se(imm32, imm16);
    input [15:0] imm16;
    output [31:0] imm32;
    assign imm32[15:0] = imm16[15:0];
    assign imm32[31:16] = {16{imm16[15]}};



endmodule // se