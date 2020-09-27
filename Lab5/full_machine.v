// full_machine: execute a series of MIPS instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock   (input) - the clock signal
// reset   (input) - set to 1 to set all registers to zero, set to 0 for normal execution.

// module full_machine(except, clock, reset);
//     output      except;
//     input       clock, reset;

//     wire [31:0] inst;  
//     wire [31:0] PC;  

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     register #(32) PC_reg( /* connect signals */);

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     instruction_memory im( /* connect signals */ );

//     // DO NOT comment out or rename this module
//     // or the test bench will break
//     regfile rf ( /* connect signal wires */);

//     /* add other modules */

// endmodule // full_machine
module full_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [31:0] inst;  
    wire [31:0] PC;
    wire [31:0] trashslt, trashrmem, trashload, dataout, addmtrsh, luitrsh, ext, neg, load, jaddr, branchoff, addr, nextPC, rsData, rtData, rdData, PC4, PCbo, B, imm32, out;
    wire weword, webyte, readmem, addm, overflow, zero, negative, rdsrc, wren, alusrc2, lui, slt, loadbyte;
    wire [7:0] muxdatatrsh;
    wire [1:0] control_type;
    wire [2:0] alu_op;
    wire [4:0] rdest;

    // DO NOT comment out or rename this module
    // or the test bench will break
    register #(32) PC_reg(PC, nextPC, clock, 1'b1, reset);

    // DO NOT comment out or rename this module
    // or the test bench will break
    instruction_memory im(inst, PC[31:2]);

    // DO NOT comment out or rename this module
    // or the test bench will break
    regfile rf (rsData, rtData, inst[25:21], inst[20:16], rdest, rdData, wren, clock, reset);

    /* add other modules */

    mips_decode code(alu_op, wren, rdsrc, alusrc2, except, control_type, readmem, weword, webyte, loadbyte, lui, slt, addm, inst[31:26], inst[5:0], zero);
    data_mem mem(dataout, addr, rtData, weword, webyte, clock, reset);  

    loadupper lu(load, inst[15:0]);
    jraddress j(jaddr, inst[25:0], PC);
    signextender sign_ext(imm32, inst[15:0]);
    shiftleft sl(branchoff, imm32[29:0]);
    byteextend be1(ext, muxdatatrsh);
    negativeextend next1(neg, negative);





    mux2v #(32) memRead(trashrmem, trashslt, trashload, readmem);
    mux2v #(32) byteMux(trashload, dataout, ext, loadbyte);
    mux2v #(32) Bmux(B, rtData, imm32, alusrc2);
    mux2v #(32) luiMux(luitrsh, trashrmem, load, lui);
    mux2v #(5) rdest_(rdest, inst[15:11], inst[20:16], rdsrc);
    mux2v #(32) addmMux(rdData, luitrsh, addmtrsh,  addm);
    mux2v #(32) ad(addr, out, rsData, addm);
    mux2v #(32) sltMux(trashslt, out, neg, slt);
    mux4v #(8) dataMux(muxdatatrsh, dataout[7:0], dataout[15:8], dataout[23:16], dataout[31:24], out[1:0]);
    mux4v #(32) pcpicker(nextPC, PC4, PCbo, jaddr, rsData, control_type);

    alu32 outAlu(out, overflow, zero, negative, rsData, B, alu_op);
    alu32 addmALU(addmtrsh, , , , dataout, rtData, `ALU_ADD);
    alu32 add4(PC4, , , , PC, 32'b100, `ALU_ADD);
    alu32 br(PCbo, , , , PC4, branchoff, `ALU_ADD);


    endmodule // full_machine

module signextender(imm32, imm16);

    output [31:0] imm32;
    input [15:0] imm16;
    assign imm32[15:0] = imm16[15:0];
    assign imm32[31:16] = {16{imm16[15]}};
endmodule // signextender

module jraddress(out, address, pc);

    output  [31:0] out;
    input   [25:0] address;
    input   [31:0] pc;
    assign out[31:28] = pc[31:28];
    assign out[27:2] = address[25:0];
    assign out[1:0] = 2'b0;

endmodule // signextender

module byteextend(out, in);

    output  [31:0] out;
    input   [7:0] in;
    assign out[31:8] = 24'b0;
    assign out[7:0] = in[7:0];

endmodule // signextender

module negativeextend(out, in);

    output  [31:0] out;
    input   in;
    assign out[31:1] = 31'b0;
    assign out[0] = in;

endmodule // signextender

module loadupper(out, in);

    output  [31:0] out;
    input   [15:0] in;
    assign out[31:16] = in[15:0];
    assign out[15:0] = 16'b0;

endmodule // signextender

module shiftleft(out, in);

    output [31:0] out;
    input [29:0] in;
    assign out[31:2] = in[29:0];
    assign out[1:0] = 2'b0;

endmodule // signextender