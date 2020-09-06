module alu1_test;

    // define ALU_ADD    3'h2
    // define ALU_SUB    3'h3
    // define ALU_AND    3'h4
    // define ALU_OR     3'h5
    // define ALU_NOR    3'h6
    // define ALU_XOR    3'h7

    // cycle through all combinations of A, B, carryin every 16 time units
    reg A = 0;
    always #1 A = !A;
    reg B = 0;
    always #2 B = !B;
    reg carryin = 0;
    always #4 carryin = !carryin;

    reg [2:0] control = 0;

    initial begin
        $dumpfile("alu1.vcd");
        $dumpvars(0, alu1_test);

        // control is initially 0
        # 16 control = 010; // wait 16 time units (why 16?) and then set it to 1
        # 16 control = 011; // wait 16 time units and then set it to 2
        # 16 control = 100; // wait 16 time units and then set it to 3
        # 16 control = 101; // wait 16 time units and then set it to 4
        # 16 control = 110; // wait 16 time units and then set it to 5
        # 16 control = 111; // wait 16 time units and then set it to 6
        # 16 $finish; // wait 16 time units and then end the simulation
    end

    wire out;
    wire carryout;
    alu1 alu_1b(out, carryout, A, B, carryin, control);

    // you really should be using gtkwave instead
    /*
    initial begin
        $display("A B C D s o");
        $monitor("%d %d %d %d %d %d (at time %t)", A, B, C, D, control, out, $time);
    end
    */

endmodule
