// full_machine: execute a series of MIPS instructions from an instruction cache

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




    wire [7:0] byte_mux_output;
    wire [4:0] writeittothisAdress;
    wire [2:0] alu_op;
    wire [1:0] alu_src2, controlNumberType;
    wire lui, addm, mem_read, word_we,  zero, rd_src, writeenable, slt, overflow, negative, except, byte_we, byte_load;
    wire [31:0] inst, PC, next_PC, rsData,  luiinput0, luiinput1, lui_mux_out, offsetThing, B, out, B_data, imm16, PC_control_0, PC_control_1, PC_control_2, PC_control_3;
    wire [31:0] addmOutput, rdData, byte_extended, byteOutPut, slt_input_1, slt_output,  data_out, sign_extended;




    // Decoder
    mips_decode d(alu_op, writeenable, rd_src, alu_src2, except, controlNumberType,
                   mem_read, word_we, byte_we, byte_load, slt, lui, addm,inst[31:26], inst[5:0], zero);


    // Sign extender
    assign sign_extended[15:0] = inst[15:0];
    assign imm16[15:0] = inst[15:0];
    assign sign_extended[31:16] = 16'b0;
    assign imm16[31:16] = {16{inst[15]}};



    // Control unit
    alu32 a1(PC_control_0, , , , PC, 32'h4, 3'b010);
    alu32 a2(PC_control_1, , , , offsetThing, PC_control_0, 3'b010);
    register #(32) PC_reg(PC, next_PC, clock, 1'b1, reset);
    instruction_memory im(inst, PC[31:2]);
    mux4v m1(next_PC, PC_control_0, PC_control_1, PC_control_2, rsData, controlNumberType);
 

    assign luiinput1 = {inst[15:0], 16'b0};
    assign slt_input_1 = {31'b0, negative};
    assign slt_input_0 = out;
    assign byte_extended = {24'b0, byte_mux_output};

    assign PC_control_3 = rsData;
    assign PC_control_2[31:28] = PC_control_0[31:28];
    assign PC_control_2[27:2] = inst[25:0];
    assign PC_control_2[1:0] = 2'b0;


        // Data Memory
    data_mem dm(data_out, out, B_data, word_we, byte_we, clock, reset);
    mux4v m5(byte_mux_output, data_out[7:0], data_out[15:8], data_out[23:16], data_out[31:24], out[1:0]);
    mux2v m6(luiinput0, slt_output, byteOutPut, mem_read);
    mux2v m7(byteOutPut, data_out[31:0], byte_extended, byte_load);
    mux2v m8(slt_output, out, slt_input_1, slt);

    
    // Regfile and alu
    mux2v m3(lui_mux_out, luiinput0, luiinput1, lui);
    mux3v m4(B, B_data, imm16, sign_extended, alu_src2);
    alu32 a3(out, overflow, zero, negative, rsData, B, alu_op);
    mux2v m2(writeittothisAdress, inst[15:11], inst[20:16], rd_src);
    regfile rf (rsData, B_data, inst[25:21], inst[20:16], writeittothisAdress, rdData, writeenable, clock, reset);





    // Addm implementation - not working
    mux2v m9(rdData, lui_mux_out, addmOutput, addm);
    alu32 a4(addmOutput, , , , data_out, Binput, 3'b010);


    // Bit shift
    bitshift b1(offsetThing, imm16[29:0]);   

    
endmodule // full_machine

module bitshift(offsetThing, imm16);
   output [31:0] offsetThing;
   input [29:0] imm16;
   assign offsetThing[31:2] = imm16[29:0];
   assign offsetThing[1:0] = 0;

endmodule // shift_left_two