module timer(TimerInterrupt, cycle, TimerAddress,
             data, address, MemRead, MemWrite, clock, reset);
    output        TimerInterrupt;
    output [31:0] cycle;
    output        TimerAddress;
    input  [31:0] data, address;
    input         MemRead, MemWrite, clock, reset;

    // complete the timer circuit here

    // HINT: make your interrupt cycle register reset to 32'hffffffff
    //       (using the reset_value parameter)
    //       to prevent an interrupt being raised the very first cycle

    wire    [31:0] a, b, a2;
    wire    a_var_kno, c_e6, c_e1, write_time, read_time, set_two, equal;

    register count(a, b, clock, 1, reset);
    alu32 add_alu(b, , ,`ALU_ADD, a, 32'h1);



    //reset
    register #(32, 32'hffffffff)
    cycle_intr(a2, data, clock, write_time, reset);
    assign equal = (a == a2);
    tristate #(32) three_read(cycle, a, read_time);

    assign set_two = (a_var_kno | reset);
    dffe intr(TimerInterrupt, 1, clock, equal, set_two);



    //assign rest
    assign a_var_kno = (c_e6 & MemWrite);
    assign read_time = (c_e1 & MemRead);
    assign c_e1 = ('hffff001c == address);
    assign c_e6 = ('hffff006c == address);
    assign TimerAddress = (c_e1 | c_e6);
    assign write_time = (c_e1 & MemWrite);

 endmodule