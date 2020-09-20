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


module arith_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;
    wire [31:0] PC;

    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg( /* connect signals / );

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im( / connect signals / );

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf ( / connect signals / );

    / add other modules */

    wire [31:0]  rt_d, rd_d, B, imm_32, next_pc, rdrs_d;
    wire [4:0] rd;
    wire overflow, zero, negative, W_en, rd_src, alu_src2;
    wire [2:0] alu_op;

    Si_ex signer(imm_32, inst[15:0]);
    mux2v muxuno(B, rt_d, imm_32, alu_src2);
    mux2v #(5) muxdos(rd, inst[15:11], inst[20:16], rd_src);
    mips_decode uncode(alu_op, W_en, rd_src, alu_src2, except, inst[31:26], inst[5:0]);

    alu32 alupc(next_pc, , , , PC, 32'b100, `ALU_ADD);
    alu32 register_alu(rd_d, overflow, zero, negative, rdrs_d, B, alu_op);

endmodule // arith_machine



module Si_ex(imm_32, imm_16);

input [15:0] imm_16;
output [32:0] imm_32;
assign imm_32[31:16] = {16{imm_16[15]}};
assign imm_32[15:0] = imm_16[15:0];

endmodule // Si_ex