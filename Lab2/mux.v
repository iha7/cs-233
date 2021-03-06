// // output is A (when control == 0) or B (when control == 1)
// module mux2(out, A, B, control);
//     output out;
//     input  A, B;
//     input  control;
//     wire   wA, wB, not_control;
         
//     not n1(not_control, control);
//     and a1(wA, A, not_control);
//     and a2(wB, B, control);
//     or  o1(out, wA, wB);
// endmodule // mux2

// // output is A (when control == 00) or B (when control == 01) or
// //           C (when control == 10) or D (when control == 11)
// module mux4(out, A, B, C, D, control);
//     output      out;
//     input       A, B, C, D;
//     input [1:0] control;

// endmodule // mux4


// output is A (when control == 0) or B (when control == 1)
module mux2(out, A, B, control);
    output out;
    input  A, B;
    input  control;
    wire   wA, wB, not_control;

    not n1(not_control, control);
    and a1(wA, A, not_control);
    and a2(wB, B, control);
    or  o1(out, wA, wB);
endmodule // mux2

// output is A (when control == 00) or B (when control == 01) or
//           C (when control == 10) or D (when control == 11)
module mux4(out, A, B, C, D, control);
    output      out;
    input       A, B, C, D;
    input [1:0] control;
    wire m1, m2;

    mux2 mu1(m1, A, B, control[0]);
    mux2 mu2(m2, C, D, control[0]);
    mux2 mu3(out, m1, m2, control[1]);

endmodule // mux4
