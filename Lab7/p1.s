# #define NULL 0

# // Note that the value of op_add is 0 and the value of each item
# // increments as you go down the list
# //
# // In C, an enum is just an int!
# typedef enum {
#     op_add,         
#     op_sub,         
#     op_mul,         
#     op_div,         
#     op_rem,         
#     op_neg,         
#     op_paren,
#     constant
# } node_type_t;

# typedef struct {
#     node_type_t type;
#     bool computed;
#     int value;
#     ast_node* left;
#     ast_node* right;
# } ast_node;

# int value(ast_node* node) {
#     if (node == NULL) { return 0; }
#     if (node->computed) { return node->value; }

#     int left = value(node->left);
#     int right = value(node->right);

#     // This can just implemented with successive if statements (see Appendix)
#     switch (node->type) {
#         case constant:
#             return node->value;
#         case op_add:
#             node->value = left + right;
#             break;
#         case op_sub:
#             node->value = left - right;
#             break;
#         case op_mul:
#             node->value = left * right;
#             break;
#         case op_div:
#             node->value = left / right;
#             break;
#         case op_rem:
#             node->value = left % right;
#             break;
#         case op_neg:
#             node->value = -left;
#             break;
#         case op_paren:
#             node->value = left;
#             break;
#     }
#     node->computed = true;
#     return node->value;
# }
.globl value
value:
        sub    $sp, $sp, 32
        sw     $ra, 0($sp)

        sw     $s4, 16($sp)

        sw     $s5, 20($sp)

        sw     $s6, 24($sp)
        sw     $s7, 28($sp)

        sw     $s1, 4($sp)
        sw     $s2, 8($sp) 

        sw     $s3, 12($sp)
        add     $s3, $s3, $0


        move    $s1, $a0                       
        add     $s2, $s1, 4                      

        add     $s3, $s1, 8                   

        add     $s4, $s1, 12                       

        add     $s5, $s1, 16                           

        add     $s3, $s3, $0
        add     $s3, $s3, $0

        add     $s3, $s3, $0

        bne    $a0, $zero, first_check         
        move   $v0, $zero                           

        j      give_me_the_answer

first_check:
        li      $t0, 1                       

        lbu     $t3, 0($s2)

        bne     $t3, $t0, after_check            

        lw      $v0, 0($s3)

        j       give_me_the_answer

after_check:
        lw      $a0, 0($s4)                        
        jal     value
        move    $s6, $v0                           
        add     $s3, $s3, $0

        lw      $a0, 0($s5)                       
        jal     value
        move    $s7, $v0                             



check_constant:
        li      $t0, 7                                  
        lw      $t3, 0($s1)
        
        bne     $t3, $t0, Addition_branch        
        add     $s3, $s3, $0         

        move    $v0, $s3                    
        j       finish



Addition_branch:
        lw      $t3, 0($s1)

        bne     $t3, $zero, Subtraction_branch           

        add     $t1, $s6, $s7


        add     $s3, $s3, $0                      
        sw      $t1, 0($s3)                       

        j       finish


Multiply_branch:
        lw      $t3, 0($s1)

        li      $t0, 2                               
        bne     $t3, $t0, Division_branch                 
        mul     $t1, $s6, $s7   


        add     $s3, $s3, $0                
        sw      $t1, 0($s3)                       

        j       finish



Subtraction_branch:
        lw      $t3, 0($s1)

        li      $t0, 1                             
        add     $s3, $s3, $0
        bne     $t3, $t0, Multiply_branch                  
        sub     $t1, $s6, $s7                      

        sw      $t1, 0($s3)                          
        add     $s3, $s3, $0
        add     $s3, $s3, $0
        add     $s3, $s3, $0
        j       finish





Negative_branch:
        lw      $t3, 0($s1)
        li      $t0, 5                              

        bne     $t3, $t0, check_paren            
        sub     $t1, $zero, $s6                        

        sw      $t1, 0($s3)                             
        j       finish



Division_branch:
        lw      $t3, 0($s1)
        li      $t0, 3                         
        
        bne     $t3, $t0, Remainder_branch               
        div     $t1, $s6, $s7                         

        sw      $t1, 0($s3)                           

        j       finish



Remainder_branch:
        lw      $t3, 0($s1)


        li      $t0, 4             

        bne     $t3, $t0, Negative_branch      

        rem     $t1, $s6, $s7        
        add     $s3, $s3, $0
        sw      $t1, 0($s3)         

        j       finish




        
check_paren:
        lw      $t3, 0($s1)

        li      $t0, 6                       

        bne     $t3, $t0, finish            

        sw      $s6, 0($s3)          
        add     $s3, $s3, $0

        j       finish 



finish:
        li      $t0, 1              

        sb      $t0, 0($s2)          
        add     $s3, $s3, $0
        lw      $v0, 0($s3)           

        j       give_me_the_answer



        
give_me_the_answer:        
        lw     $ra, 0($sp)

        lw     $s4, 16($sp)

        lw     $s5, 20($sp)
        lw     $s6, 24($sp)
        lw     $s7, 28($sp)

        lw     $s1, 4($sp)
        lw     $s2, 8($sp) 

        lw     $s3, 12($sp)

        add    $sp, $sp, 32
        jr      $ra