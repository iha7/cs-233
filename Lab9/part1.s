.data
# syscall constants
PRINT_STRING            = 4
PRINT_CHAR              = 11
PRINT_INT               = 1

# memory-mapped I/O
VELOCITY                = 0xffff0010
ANGLE                   = 0xffff0014
ANGLE_CONTROL           = 0xffff0018

BOT_X                   = 0xffff0020
BOT_Y                   = 0xffff0024

TIMER                   = 0xffff001c

REQUEST_PUZZLE          = 0xffff00d0  ## Puzzle
SUBMIT_SOLUTION         = 0xffff00d4  ## Puzzle

BONK_INT_MASK           = 0x1000
BONK_ACK                = 0xffff0060

TIMER_INT_MASK          = 0x8000      
TIMER_ACK               = 0xffff006c 

REQUEST_PUZZLE_INT_MASK = 0x800       ## Puzzle
REQUEST_PUZZLE_ACK      = 0xffff00d8  ## Puzzle

PICKUP                  = 0xffff00f4

### Puzzle
GRIDSIZE = 8
has_puzzle:        .word 0                         
puzzle:      .half 0:2000             
heap:        .half 0:2000
#### Puzzle



.text
main:
# Construct interrupt mask
	    li      $t4, 0
        or      $t4, $t4, REQUEST_PUZZLE_INT_MASK # puzzle interrupt bit
        or      $t4, $t4, TIMER_INT_MASK	  # timer interrupt bit
        or      $t4, $t4, BONK_INT_MASK	  # timer interrupt bit
        or      $t4, $t4, 1                       # global enable
	    mtc0    $t4, $12

#Fill in your code here

                jal changetoE 
                jal changetoE

                li $s0, 7

        part1l:

                beq $s0, 0, part1l_done
                jal gotoS
                # checkhere 
                sub $s0, $s0, 1
                j part1l

        part1l_done:

                li $s0, 8

        part2l:

                beq $s0, 0, part2l_done
                jal changetoE
                sub $s0, $s0, 1
                j part2l

        part2l_done:

                li $s0, 8

        part3_:
                # remember
                beq $s0, 0, part3__done
                jal gotoS
                sub $s0, $s0, 1
                j part3_

        part3__done:

                jal changetoE  
                jal changetoE
                jal changetoE
                ; jal changetoE
                ; jal gotoN
                ; jal gotoN
                jal gotoS
                li $s1, 1
                sw $s1, PICKUP($0)

                jal gotoS

                li $s0, 12

        part4_:

                beq $s0, 0, part4__done
                jal changetoE
                sub $s0, $s0, 1
                j part4_

        part4__done:

                jal gotoN
                jal gotoN
                jal changetoE
                jal gotoN
                jal gotoN
                jal gotoN
                jal gotoN
                jal gotoN
                # fix N not workingg
                jal changetoE  
                jal changetoE
                jal changetoE
                sw $s1, PICKUP($0)

                jal gotoS
                jal gotoS
                jal gotoS
                jal gotoS
                jal changetoW
                jal changetoW
                ; jal changetoE
                ; jal gotoN
                ; jal gotoN
                jal changetoW
                jal gotoS
                jal changetoW

                li $s0, 8

        part5_:
                beq $s0, 0, part5__done
                jal gotoS
                sub $s0, $s0, 1
                j part5_

        part5__done:

                jal changetoE
                jal changetoE
                sw $s1, PICKUP($0)
                ; jal gotoS
                ; jal gotoS
                ; jal changetoW
                ; jal changetoW
                jal changetoE

                li $s0, 8

        part6_:
                beq $s0, 0, part6__done
                jal gotoS
                sub $s0, $s0, 1
                j part6_

        part6__done:

                ; jal gotoN
                ; jal gotoN
                ; jal changetoE
                ; jal gotoN
                ; jal gotoN
                ; jal gotoN
                ; jal gotoN
                ; jal gotoN
                ; # fix N not workingg
                ; jal changetoE  
                ; jal changetoE
                ; jal changetoE
                ; sw $s1, PICKUP($0)

                ; jal gotoS
                ; jal gotoS
                ; jal gotoS
                ; jal gotoS
                ; jal changetoW
                ; jal changetoW
                ; jal changetoW
                ; jal gotoS
                ; jal changetoW

                ; li $s0, 8


                jal changetoE
                jal changetoE
                jal changetoE
                jal changetoE
                jal changetoE
                jal gotoS
                jal gotoS
                jal gotoS
                jal changetoE
                jal changetoE
                sw $s1, PICKUP($0)
                # works here 
                #pick 5th
                jal changetoW
                ; jal gotoS
                ; jal gotoS
                ; jal changetoW
                ; jal changetoW
                jal changetoW
                jal gotoN
                jal gotoN
                jal gotoN
                jal gotoN
                jal gotoN

                li $s0, 9

        part7:

                beq $s0, 0, part7_done
                jal changetoW
                sub $s0, $s0, 1
                j part7

        part7_done:

                jal gotoN
                jal gotoN
                jal gotoN
                jal gotoN

                li $s0, 9

        part9:

                beq $s0, 0, part9_done
                jal changetoW
                sub $s0, $s0, 1
                j part9

        part9_done:

                jal gotoS
                jal changetoW
                jal changetoW
                jal changetoW
                jal changetoW
                jal changetoW
                jal gotoS
                jal gotoS

                ; jal changetoW
                ; jal changetoW
                ; jal gotoS
                ; jal gotoS

                jal gotoS
                sw $s1, PICKUP($0)

        j end_move      

        changetoE:

                lw $t0, BOT_X($0)

                li $a0, 1
                sw $a0, ANGLE($zero)
                li $a0, 1

                sw $a0, ANGLE_CONTROL($zero)

        goE:

                li $a0, 10
                sw $a0, VELOCITY($0)

                lw $t1, BOT_X($0)
                sub $t2, $t1, $t0
                ; li $a0, 1
                ; sw $a0, ANGLE($zero)
                ; li $a0, 1

                bne $t2, 8, goE

                li $a0, 0
                sw $a0, VELOCITY($0)
                jr $ra

        changetoW:

                ; lw $t0, BOT_X($0)

                ; li $a0, 1
                ; sw $a0, ANGLE($zero)
                ; li $a0, 1

                ; sw $a0, ANGLE_CONTROL($zero)

                # make sure W also
                lw $t0, BOT_X($0)
                li $a0, 181

                sw $a0, ANGLE($zero)
                li $a0, 1
                sw $a0, ANGLE_CONTROL($zero)

                li $a0, 10
                sw $a0, VELOCITY($0)

        staywest:

                li $a0, 10
                sw $a0, VELOCITY($0)

                lw $t1, BOT_X($0)
                sub $t2, $t1, $t0
                bne $t2, -8, staywest

                li $a0, 0
                sw $a0, VELOCITY($0)
                jr $ra
        gotoN:

                        ; # make sure W also
                        ; lw $t0, BOT_X($0)
                        ; li $a0, 181

                        ; sw $a0, ANGLE($zero)
                        ; li $a0, 1
                        ; sw $a0, ANGLE_CONTROL($zero)

                        ; li $a0, 10
                        ; sw $a0, VELOCITY($0)

                lw $t0, BOT_Y($0)
                li $a0, 269
                sw $a0, ANGLE($zero)
                li $a0, 1
                sw $a0, ANGLE_CONTROL($zero)
                li $a0, 10
                sw $a0, VELOCITY($0)

        stayN:

                li $a0, 10
                sw $a0, VELOCITY($0)

                lw $t1, BOT_Y($0)
                sub $t2, $t1, $t0
                
                ; sw $a0, ANGLE($zero)
                
                bne $t2, -8, stayN

                li $a0, 0
                sw $a0, VELOCITY($0)


                jr $ra

        gotoS:

                lw $t0, BOT_Y($0)
                li $a0, 91
                sw $a0, ANGLE($zero)
                li $a0, 1
                ; li $a0, 1
                ; sw $a0, ANGLE($zero)
                ; li $a0, 1
                sw $a0, ANGLE_CONTROL($zero)
                li $a0, 10
                sw $a0, VELOCITY($0)

        stayS:

                li $a0, 10
                sw $a0, VELOCITY($0)

                # stay not go

                lw $t1, BOT_Y($0)
                sub $t2, $t1, $t0
                bne $t2, 8, stayS

                li $a0, 0
                sw $a0, VELOCITY($0)
                jr $ra

end_move:

infinite:
        j       infinite              # Don't remove this! If this is removed, then your code will not be graded!!!

.kdata
chunkIH:    .space 8  #TODO: Decrease this
non_intrpt_str:    .asciiz "Non-interrupt exception\n"
unhandled_str:    .asciiz "Unhandled interrupt type\n"
.ktext 0x80000180
interrupt_handler:
.set noat
        move      $k1, $at              # Save $at
.set at
        la      $k0, chunkIH
        sw      $a0, 0($k0)             # Get some free registers
        sw      $v0, 4($k0)             # by storing them to a global variable

        mfc0    $k0, $13                # Get Cause register
        srl     $a0, $k0, 2
        and     $a0, $a0, 0xf           # ExcCode field
        bne     $a0, 0, non_intrpt

interrupt_dispatch:                     # Interrupt:
        mfc0    $k0, $13                # Get Cause register, again
        beq     $k0, 0, done            # handled all outstanding interrupts

        and     $a0, $k0, BONK_INT_MASK # is there a bonk interrupt?
        bne     $a0, 0, bonk_interrupt

        and     $a0, $k0, TIMER_INT_MASK # is there a timer interrupt?
        bne     $a0, 0, timer_interrupt

        and 	$a0, $k0, REQUEST_PUZZLE_INT_MASK
        bne 	$a0, 0, request_puzzle_interrupt

        li      $v0, PRINT_STRING       # Unhandled interrupt types
        la      $a0, unhandled_str
        syscall
        j       done

bonk_interrupt:
        sw      $0, BONK_ACK
#Fill in your code here
        j       interrupt_dispatch      # see if other interrupts are waiting

request_puzzle_interrupt:
        sw      $0, REQUEST_PUZZLE_ACK
#Fill in your code here
        j	interrupt_dispatch

timer_interrupt:
        sw      $0, TIMER_ACK
#Fill in your code here
        j   interrupt_dispatch
non_intrpt:                             # was some non-interrupt
        li      $v0, PRINT_STRING
        la      $a0, non_intrpt_str
        syscall                         # print out an error message
# fall through to done

done:
        la      $k0, chunkIH
        lw      $a0, 0($k0)             # Restore saved registers
        lw      $v0, 4($k0)

.set noat
        move    $at, $k1                # Restore $at
.set at
        eret
