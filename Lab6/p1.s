# Sets the values of the array to the corresponding values in the request
# void fill_array(unsigned request, int* array) {
#   for (int i = 0; i < 6; ++i) {
#     request >>= 3;
#
#     if (i % 3 == 0) {
#       array[i] = request & 0x0000001f;
#     } else {
#       array[i] = request & 0x000000ff;
#     }
#   }
# }


.globl fill_array
fill_array:

    li      $t0, 0              

    move    $t1, $a1           

loop:
    bge     $t0, 6, end        

    srl     $a0, $a0, 3       

    li      $t2, 3          

    div     $t3, $t0, $t2   

    mfhi    $t3             

    bne     $t3, $0, else      

    and     $t4, $a0, 31       

    mul     $t3, $t0, 4        

    add     $t5, $t1, $t3    

    sw     $t4, 0($t5)     

    addi    $t0, $t0, 1        

    j loop

else:
    mul    $t3, $t0, 4         

    add    $t5, $t1, $t3       

    and    $t4, $a0, 255      

    sw     $t4, 0($t5)       

    add    $t0, 1      
          
    j loop

end:
    jr    $r