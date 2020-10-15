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
    wire    Acknowledge, cE6, cE1, write_time, TimerRead, resettwo, equal;

    register count(a, b, clock, 1,reset);
    alu32 add_alu(b, , ,`ALU_ADD, a, 32'h1);
    register #(32, 32'hffffffff)
    cycle_intr(a2, data, clock, write_time, reset);

    assign equal = (a == a2);
    tristate #(32) three_read(cycle, a, TimerRead);

    assign resettwo = (Acknowledge | reset);

    dffe intr(TimerInterrupt, 1, clock, equal, resettwo);

    assign TimerAddress = (cE1 | cE6);
    assign Acknowledge = (cE6 & MemWrite);
    assign TimerRead = (cE1 & MemRead);
    assign write_time = (cE1 & MemWrite);

    assign cE1 = ('hffff001c == address);
    assign cE6 = ('hffff006c == address);

 endmodule