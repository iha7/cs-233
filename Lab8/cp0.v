// `define STATUS_REGISTER 5'd12
// `define CAUSE_REGISTER  5'd13
// `define EPC_REGISTER    5'd14

// module cp0(rd_data, EPC, TakenInterrupt,
//            wr_data, regnum, next_pc,
//            MTC0, ERET, TimerInterrupt, clock, reset);
//     output [31:0] rd_data;
//     output [29:0] EPC;
//     output        TakenInterrupt;
//     input  [31:0] wr_data;
//     input   [4:0] regnum;
//     input  [29:0] next_pc;
//     input         MTC0, ERET, TimerInterrupt, clock, reset;

//     // your Verilog for coprocessor 0 goes here
// endmodule


`define STATUS_REGISTER 5'd12
`define CAUSE_REGISTER  5'd13
`define EPC_REGISTER   5'd14

module cp0(rd_data, EPC, TakenInterrupt,
           wr_data, regnum, next_pc,
           MTC0, ERET, TimerInterrupt, clock, reset);
    output [31:0] rd_data;
    output [29:0] EPC;
    output        TakenInterrupt;
    input  [31:0] wr_data;
    input   [4:0] regnum;
    input  [29:0] next_pc;
    input         MTC0, ERET, TimerInterrupt, clock, reset;

    // your Verilog for coprocessor 0 goes here

    wire exc_lvl;
    wire [29:0] ep;
    wire epc_enb;
    wire [31:0] STATUS_REGISTER, CAUSE_REGISTER, qu_31;
    wire [31:0] ustat, m_cnt;
    wire mtc_012, mtc_014;
    wire ext_res;

    register #(32) us_stat(ustat, wr_data, clock, mtc_012, reset);
    decoder32 decoder_1(m_cnt, regnum, MTC0);

    assign mtc_014 = m_cnt[14];
    assign mtc_012 = m_cnt[12];

    mux2v #(30) mux1(ep, wr_data[31:2], next_pc, TakenInterrupt);
    assign ext_res = (ERET | reset);
    dffe dffe_uno (exc_lvl, 1, clock, TakenInterrupt, ext_res);
    assign epc_enb = (mtc_014 | TakenInterrupt);
    register #(30) EPCregister(EPC, ep, clock, epc_enb, reset);

    assign CAUSE_REGISTER[15] = TimerInterrupt;
    assign CAUSE_REGISTER[31:16] = 16'b0;
    assign CAUSE_REGISTER[14:0] = 15'b0;
    assign STATUS_REGISTER[31:16] = 16'b0;
    assign STATUS_REGISTER[15:8] = ustat[15:8];
    assign STATUS_REGISTER[7:2] = 6'b0;
    assign STATUS_REGISTER[1] = exc_lvl;
    assign STATUS_REGISTER[0] = ustat[0];

    assign qu_31 = {EPC, 2'b0};
    mux32v #(32) mux2(rd_data, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
            STATUS_REGISTER, CAUSE_REGISTER, qu_31, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 
                        32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, regnum);

    assign TakenInterrupt = (STATUS_REGISTER[0] & !STATUS_REGISTER[1]) & (CAUSE_REGISTER[15] & STATUS_REGISTER[15]);
    
endmodule
