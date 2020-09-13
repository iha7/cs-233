
// module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, zero_length_array, clock, reset);
// 	output sorted, done, load_input, load_index, select_index;
// 	input go, inversion_found, end_of_array, zero_length_array;
// 	input clock, reset;

// endmodule
// module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, zero_length_array, clock, reset);
//     output sorted, done, load_input, load_index, select_index;
//     input go, inversion_found, end_of_array, zero_length_array;
//     input clock, reset;

//     wire sGarbage, sStart, sAsc, sReg, sTrue, sFalse;

//     wire sGarbage_next = reset | (sGarbage & ~go);
//     wire sStart_next = ~reset & ((sGarbage & go) | (sTrue & go) | (sFalse & go) | (sStart & go));
//     wire sAsc_next = ~reset & (~zero_length_array & ~end_of_array & ~inversion_found & sReg);
//     wire sReg_next = ~reset & ((sStart & ~go) | sAsc);
//     wire sTrue_next = ~reset & ((sReg & end_of_array) | (sTrue & ~go) | (sReg & zero_length_array));
//     wire sFalse_next = ~reset & ((sReg & inversion_found & ~end_of_array & ~zero_length_array) | (sFalse & ~go));

//     dffe fsGarbage(sGarbage, sGarbage_next, clock, 1'b1, 1'b0);
//     dffe fsStart(sStart, sStart_next, clock, 1'b1, 1'b0);
//     dffe fsAsc(sAsc, sAsc_next, clock, 1'b1, 1'b0);
//     dffe fsReg(sReg, sReg_next, clock, 1'b1, 1'b0);
//     dffe fsTrue(sTrue, sTrue_next, clock, 1'b1, 1'b0);
//     dffe fsFalse(sFalse, sFalse_next, clock, 1'b1, 1'b0);

//     assign sorted = sTrue;
//     assign done = sTrue | sFalse;
//     assign load_index = (sAsc | sStart);
//     assign select_index = sAsc;
//     assign load_input = sStart;

// endmodule

// module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, zero_length_array, clock, reset);
//     output sorted, done, load_input, load_index, select_index;
//     input go, inversion_found, end_of_array, zero_length_array;
//     input clock, reset;

//     wire sGarbage, sStart, sAsc, sReg, sTrue, sFalse;


//     wire sGarbage_next = (sGarbage & ~go) | reset;
//     wire sStart_next = ((sGarbage & go) | (sTrue & go) | (sFalse & go) | (sStart & go)) & ~reset;

//     wire sAsc_next = (~zero_length_array & ~end_of_array & ~inversion_found & sReg) & ~reset;
//     wire sReg_next = ((sStart & ~go) | sAsc) & ~reset;

//     wire sTrue_next = ((sReg & end_of_array) | (sTrue & ~go) | (sReg & zero_length_array)) & ~reset;
//     wire sFalse_next = ((sReg & inversion_found & ~end_of_array & ~zero_length_array) | (sFalse & ~go)) & ~reset;


//     dffe fsGarbage(sGarbage, sGarbage_next, clock, 1'b1, 1'b0);
//     dffe fsStart(sStart, sStart_next, clock, 1'b1, 1'b0);

//     dffe fsAsc(sAsc, sAsc_next, clock, 1'b1, 1'b0);
//     dffe fsReg(sReg, sReg_next, clock, 1'b1, 1'b0);

//     dffe fsTrue(sTrue, sTrue_next, clock, 1'b1, 1'b0);
//     dffe fsFalse(sFalse, sFalse_next, clock, 1'b1, 1'b0);


//     assign sorted = sTrue;
//     assign done = sTrue | sFalse;
//     assign load_index = (sAsc | sStart);
//     assign select_index = sAsc;
//     assign load_input = sStart;

// 	// wire unsorted;
//     // assign sorted = sTrue;
//     // assign unsorted = sFalse;
//     // assign done = sTrue | sFalse;
//     // assign load_index = (sAsc | sStart);
//     // assign select_index = sAsc;
//     // assign load_input = sStart;

// endmodule

module arraySortCheck_control(sorted, done, load_input, load_index, select_index, go, inversion_found, end_of_array, zero_length_array, clock, reset);
    output sorted, done, load_input, load_index, select_index;
    input go, inversion_found, end_of_array, zero_length_array;
    input clock, reset;

    wire sGarbage, sStart, sAsc, sReg, sTrue, sFalse;


    //next states
    wire sGarbage_next = (sGarbage & ~go) | reset;
    wire sStart_next = ((sGarbage & go) | (sTrue & go) | (sFalse & go) | (sStart & go)) & ~reset;

    wire sAsc_next = (~zero_length_array & ~end_of_array & ~inversion_found & sReg) & ~reset;
    wire sReg_next = ((sStart & ~go) | sAsc) & ~reset;

    wire sTrue_next = ((sReg & end_of_array) | (sTrue & ~go) | (sReg & zero_length_array)) & ~reset;
    wire sFalse_next = ((sReg & inversion_found & ~end_of_array & ~zero_length_array) | (sFalse & ~go)) & ~reset;


    //dffe modules
    dffe fsGarbage(sGarbage, sGarbage_next, clock, 1'b1, 1'b0);
    dffe fsStart(sStart, sStart_next, clock, 1'b1, 1'b0);

    dffe fsAsc(sAsc, sAsc_next, clock, 1'b1, 1'b0);
    dffe fsReg(sReg, sReg_next, clock, 1'b1, 1'b0);

    dffe fsTrue(sTrue, sTrue_next, clock, 1'b1, 1'b0);
    dffe fsFalse(sFalse, sFalse_next, clock, 1'b1, 1'b0);


    //final assignment
    //wire unsorted;
    assign sorted = sTrue;
    //assign unsorted = sFalse;
    assign done = sTrue | sFalse;
    assign load_index = (sAsc | sStart);
    assign select_index = sAsc;
    assign load_input = sStart;

endmodule
