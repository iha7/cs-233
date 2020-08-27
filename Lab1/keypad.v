module keypad(valid, number, a, b, c, d, e, f, g);
   output 	valid;
   output [3:0] number;
   input 	a, b, c, d, e, f, g;


wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9;

   and a0(w0, b, g);
   and a1(w1, a, d);
   and a2(w2, b, d);
   and a3(w3, c, d);
   and a4(w4, a, e);
   and a5(w5, b, e);
   and a6(w6, c, e);
   and a7(w7, a, f);
   and a8(w8, b, f);
   and a9(w9, c, f);

   or valid_or(valid, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9);


assign number[3] = (b && f) || (c && f);
assign number[2] = (a && e) || (b && e) || (c && e) || (a && f);
assign number[1] = (b && d) || (c && d) || (c && e) || (a && f);
assign number[0] = (a && d) || (c && f) || (c && d) || (a && f) || (b && e);




   
endmodule // keypad
