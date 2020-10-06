# Performs a selection sort on the data with a comparator
# void selection_sort (int* array, int len) {
#   for (int i = 0; i < len -1; i++) {
#     int min_idx = i;
#
#     for (int j = i+1; j < len; j++) {
#       // Do NOT inline compare! You code will not work without calling compare.
#       if (compare(array[j], array[min_idx])) {
#         min_idx = j;
#       }
#     }
#
#     if (min_idx != i) {
#       int tmp = array[i];
#       array[i] = array[min_idx];
#       array[min_idx] = tmp;
#     }
#   }
# }
.globl selection_sort
selection_sort:
        add $t1, $t1, 0
            add $t1, $0, $0 

    add $t0, $0, $0 

    add $t4, $0, $0 

    add $t5, $0, $0 
    add $t5, $0, $t5 

    sub             $sp, $sp, 24    

    sw              $ra, 0($sp)   

    sw              $s0, 4($sp)   

    sw              $s1, 8($sp)    

    sw              $s2, 12($sp)    

    sw              $s3, 16($sp)    

    sw              $s4, 20($sp)    


    move            $s0, $a0               
    move            $s1, $a1              
    li              $s2, 0                 
   

for_loop: 
    sub             $t1, $s1, 1          

    bge             $s2, $t1, end          

    move            $s4, $s2           

    add             $s3, $s2, 1           
    j for_loop2

for_loop2:
    bge             $s3, $s1, end3        

    mul             $t2, $s3, 4             

    add             $t3, $s0, $t2

    lw              $t4, 0($t3)         

    move            $a0, $t4              

    mul             $t2, $s4, 4     

    add             $t3, $s0, $t2

    lw              $t4, 0($t3)           

    move            $a1, $t4            

    jal             compare
                  
    bne             $v0, 1, end4       

    move            $s4, $s3              

    add             $s3, $s3, 1          
    j for_loop2

end3:
    beq             $s4, $s2, for_back         

    mul             $t2, $s2, 4          

    add             $t3, $s0, $t2        

    lw              $t4, 0($t3)            


    mul             $t5, $s4, 4

    add             $t6, $s0, $t5          

    lw              $t7, 0($t6)             

    move            $t0, $t4              
     
    sw              $t7, 0($t3)          

    sw              $t0, 0($t6)           

    add             $s2, $s2, 1           

    j               for_loop                 

end4:
    add             $s3, $s3, 1             
    j for_loop2                                

for_back:
    add             $s2, $s2, 1
    j for_loop

end:
    move            $a0, $s0
    lw              $ra, 0($sp)             
    lw              $s0, 4($sp)            
    lw              $s1, 8($sp)            
    lw              $s2, 12($sp)           
    lw              $s3, 16($sp)          
    lw              $s4, 20($sp)
    add             $sp, $sp, 24            
    jr              $ra



# Draws points onto the array
# int draw_gradient(Gradient map[15][15]) {
#   int num_changed = 0;
#   for (int i = 0 ; i < 15 ; ++ i) {
#     for (int j = 0 ; j < 15 ; ++ j) {
#       char orig = map[i][j].repr;
#
#       if (map[i][j].xdir == 0 && map[i][j].ydir == 0) {
#         map[i][j].repr = '.';
#       }
#       if (map[i][j].xdir != 0 && map[i][j].ydir == 0) {
#         map[i][j].repr = '_';
#       }
#       if (map[i][j].xdir == 0 && map[i][j].ydir != 0) {
#         map[i][j].repr = '|';
#       }
#       if (map[i][j].xdir * map[i][j].ydir > 0) {
#         map[i][j].repr = '/';
#       }
#       if (map[i][j].xdir * map[i][j].ydir < 0) {
#         map[i][j].repr = '\';
#       }

#       if (map[i][j].repr != orig) {
#         num_changed += 1;
#       }
#     }
#   }
#   return num_changed;
# }

.globl draw_gradient
draw_gradient:

    add $t1, $0, $0 

    add $t0, $0, $0 

    add $t4, $0, $0 

    add $t5, $0, $0 
    add $t5, $0, $t5 


    firstLoop:

        add $t3, $0, 15

        bge $t1, $t3, end

        add $t4, $0, $0 


        secondLoop:

            add $t3, $0, 15

            bge $t4, $t3, add1

            mul $t5, $t1, 12 

            mul $t5, $t5, 15

            mul $t6, $t4, 12

            add $t6, $t5, $t6 

            add $t7, $a0, $t6

            add $t4, $t4, $0 

            add $t5, $t5, $0 

            lb $t2, 0($t7) 

            lw $t5, 4($t7) 

            lw $t6, 8($t7) 


        if1:

            bne $t5, $0, if2

            bne $t6, $0, if2
            add $t3, $t3, $0 

            add $t3, $t3, $0 

            li $t3, '.'

            sb $t3, 0($t7)



        if2:
            beq $t5, $0, if3
            bne $t6, $0, if3
                        add $t3, $t3, $0 

            add $t3, $t3, $0 
            li $t3, '_'
            sb $t3, 0($t7)


        if3:
            bne $t5, $0, if4
            beq $t6, $0, if4
                        add $t3, $t3, $0 

            add $t3, $t3, $0 
            li $t3, '|'
            sb $t3, 0($t7)


        if4:
            mul $t3, $t5, $t6
            ble $t3, $0, fifth_if
            li $t3, '/'
            sb $t3, 0($t7)


        fifth_if:
            mul $t3, $t5, $t6
            bge $t3, $0, sixth_if
                        add $t3, $t3, $0 

            add $t3, $t3, $0 
            li $t3, '\\'
            sb $t3, 0($t7)


        sixth_if:

            lb $t3, 0($t7)
            beq $t3, $t2, add2
            add $t0, $t0, 1


        add2:

            add $t4, $t4, 1
            add $t1, $t1, 0
            add $t4, $t4, 0
            j secondLoop


    add1:
        add $t1, $t1, 1
        add $t1, $t1, 0
        add $t1, $t1, 0
        add $t1, $t1, 0
        j firstLoop
    end:

        add $v0, $t0, 0
        jr      $ra
