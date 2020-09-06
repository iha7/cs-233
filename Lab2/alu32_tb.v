//implement a test bench for your 32-bit ALU
module alu32_test;
    reg [31:0] A = 0, B = 0;
    reg [2:0] control = 0;

//     define ALU_ADD    3'h2;
// define ALU_SUB    3'h3;
// define ALU_AND    3'h4;
// define ALU_OR     3'h5;
// define ALU_NOR    3'h6;
// define ALU_XOR    3'h7;

    initial begin
        $dumpfile("alu32.vcd");
        $dumpvars(0, alu32_test);

        # 10 A = 8; B = 4; control = 3'h2; // try adding 8 and 4
        # 10 A = 5; B = 2; control = 3'h3; // try subtracting 5 from 2
        # 10 A = 1; B = 7; control = 3'h4;
        # 10 A = 2; B = 3; control = 3'h5;
        # 10 A = 4; B = 9; control = 3'h6;
        # 10 A = 6; B = 8; control = 3'h7;

        // add more test cases here!

        # 10 $finish;
    end

    wire [31:0] out;
    wire overflow, zero, negative;
    alu32 a(out, overflow, zero, negative, A, B, control);
endmodule // alu32_test