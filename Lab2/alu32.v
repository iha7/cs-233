//implement your 32-bit ALU
// module alu32(out, overflow, zero, negative, A, B, control);
//     output [31:0] out;
//     output        overflow, zero, negative;
//     input  [31:0] A, B;
//     input   [2:0] control;


// endmodule // alu32
module alu32(out, overflow, zero, negative, A, B, control);
    output [31:0] out;
    output        overflow, zero, negative;
    input  [31:0] A, B;
    input   [2:0] control;

    wire [31:0] carryout;

alu1 alu0(out[0], carryout[0], A[0], B[0], control[0], control);

alu1 alu1(out[1], carryout[1], A[1], B[1], carryout[0], control);
alu1 alu2(out[2], carryout[2], A[2], B[2], carryout[1], control);
alu1 alu3(out[3], carryout[3], A[3], B[3], carryout[2], control);
alu1 alu4(out[4], carryout[4], A[4], B[4], carryout[3], control);
alu1 alu5(out[5], carryout[5], A[5], B[5], carryout[4], control);
alu1 alu6(out[6], carryout[6], A[6], B[6], carryout[5], control);
alu1 alu7(out[7], carryout[7], A[7], B[7], carryout[6], control);
alu1 alu8(out[8], carryout[8], A[8], B[8], carryout[7], control);
alu1 alu9(out[9], carryout[9], A[9], B[9], carryout[8], control);
alu1 alu10(out[10], carryout[10], A[10], B[10], carryout[9], control);
alu1 alu11(out[11], carryout[11], A[11], B[11], carryout[10], control);
alu1 alu12(out[12], carryout[12], A[12], B[12], carryout[11], control);
alu1 alu13(out[13], carryout[13], A[13], B[13], carryout[12], control);
alu1 alu14(out[14], carryout[14], A[14], B[14], carryout[13], control);
alu1 alu15(out[15], carryout[15], A[15], B[15], carryout[14], control);
alu1 alu16(out[16], carryout[16], A[16], B[16], carryout[15], control);
alu1 alu17(out[17], carryout[17], A[17], B[17], carryout[16], control);
alu1 alu18(out[18], carryout[18], A[18], B[18], carryout[17], control);
alu1 alu19(out[19], carryout[19], A[19], B[19], carryout[18], control);
alu1 alu20(out[20], carryout[20], A[20], B[20], carryout[19], control);
alu1 alu21(out[21], carryout[21], A[21], B[21], carryout[20], control);
alu1 alu22(out[22], carryout[22], A[22], B[22], carryout[21], control);
alu1 alu23(out[23], carryout[23], A[23], B[23], carryout[22], control);
alu1 alu24(out[24], carryout[24], A[24], B[24], carryout[23], control);
alu1 alu25(out[25], carryout[25], A[25], B[25], carryout[24], control);
alu1 alu26(out[26], carryout[26], A[26], B[26], carryout[25], control);
alu1 alu27(out[27], carryout[27], A[27], B[27], carryout[26], control);
alu1 alu28(out[28], carryout[28], A[28], B[28], carryout[27], control);
alu1 alu29(out[29], carryout[29], A[29], B[29], carryout[28], control);
alu1 alu30(out[30], carryout[30], A[30], B[30], carryout[29], control);
alu1 alu31(out[31], carryout[31], A[31], B[31], carryout[30], control);

xor x(overflow, carryout[30], carryout[31]);
    not n(zero, out[31] || out[30] ||
        out[29] ||  
        out[28] ||
        out[27] ||
        out[26] ||
        out[25] ||
        out[24] ||
        out[23] ||
        out[22] ||
        out[21] ||
        out[20] ||
        out[19] ||
        out[18] ||
        out[17] ||
        out[16] ||
        out[15] ||
        out[14] ||
        out[13] ||
        out[12] ||
        out[11] ||
        out[10] ||
        out[9] ||
        out[8] ||
        out[7] ||
        out[6] ||
        out[5] ||
        out[4] ||
        out[3] ||
        out[2] ||
        out[1] ||
        out[0] );
    assign negative = out[31];

endmodule // alu32
