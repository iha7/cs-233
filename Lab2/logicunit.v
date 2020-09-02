// 00 -> AND, 01 -> OR, 10 -> NOR, 11 -> XOR
module mux4v(out, A, B, C, D, control);
  output      out;
  input       A, B, C, D;
  input [1:0] control;

  wire  wA, wB, wC, wD;

  assign wA = A & (control == 2'b00);
  assign wB = B & (control == 2'b01);
  assign wC = C & (control == 2'b10);
  assign wD = D & (control == 2'b11);

  or  o1(out, wA, wB, wC, wD);

endmodule // mux4v

// Design a logicunit that implements the specified truth table
//00 -> AND, 01 -> OR, 10 -> NOR, 11 -> XOR

module logicunit(out, A, B, control);
  output      out;
  input       A, B;
  input [1:0] control;
  wire an, o, no, xo;

  and na1(an, A, B);
  or a1(o, A, B);
  nor o1(no, A, B);
  xor no1(xo, A, B);
  mux4v mux4(out, an, o, no, xo, control);

endmodule // Logic Unit to Verilog