/* 
 * Filename: shift.s
 * Author: Anish Narsian
 * Description: Shifts banks by desired amount 
 * Date: Oct 30, 2013
 * Source of Help: Discussion slides
 */



.global shift			
.section ".data"
MSB_MASK    = 0x80000000    
LSB_MASK    = 0x00000001
SIXBIT_MASK = 0x0000003F
.section ".text"

/*
 * Function name: shift()
 * Function prototype: void shift(unsigned int lightBank[], const int shiftCnt)
 * Description: shift lights by desired amount
 * Paramters:
 *      arg 1: lightBank array 
 *      arg 2: shiftCnt
 * Side Effects: None
 * Error Conditions: 
 * Return Value: None
 * Registers used:
 * %i0 - light bank array
 * %i1 - shift count
 * %l0 - load and store lb1
 * %l1 - load and store lb2
 * %l2 - sign bit of count
 * %l3 - lower six bits of count
 * %l4 - holds values that move out
 */


shift:
  save	%sp, -96, %sp
  ld	[%i0], %l0		!Load the first lightbank
  ld	[%i0 + 4], %l1	!Load the second lightbank

  set MSB_MASK, %l2   !get the sign
  and %l2, %i1, %l2   
  set SIXBIT_MASK, %l3!LOWER 6 bits
  and %l3, %i1, %l3   
  cmp %g0, %l3        !Compare that %l3 is not 0
  be  end_loop        !If equal the branch end loop
  cmp %g0, %l2        !Compare the sign bit with zero
  bne negate          !sign bit was set, jump to shift_right
  nop
  ba  shift_left      !Else jump to shift_left
  nop

negate:
  neg %i1, %i1
  set SIXBIT_MASK, %i5
  and %i5, %i1, %l3

shift_right:
  cmp %g0, %l3        
  be  end_loop        !If l3 = 0 then goto end loop
  nop

  and %l0, LSB_MASK,%l4
           !%l4 now holds the LSB of the lightbank[0] preShift
  sll %l4, 31, %l4
           !%l4 now holds the LSB of the lightbank[0] preshift in its MSB
  srl %l0, 1, %l0 
           !%l0 now holds the shifted value of lightbank[0]
  srl %l1, 1, %l1
           !%l1 now holds the shifted value of lightBank[1]
  or  %l4, %l1, %l1
           !%l1 now has the correct MSB based on lightBanks[0]'s LSB


  dec %l3             
  ba shift_right      
  nop
shift_left:
  cmp %g0, %l3        
  be end_loop         !Ifl3 = 0 then goto end loop
  nop



  set MSB_MASK, %l5
  and %l1, %l5, %l4
           !%l4 now holds the MSB of the lightbank[1] preShift
  srl %l4, 31, %l4
           !%l4 now holds the MSB of the lightbank[1] in its LSB
  sll %l0, 1, %l0
           !%l0 now holds the shifted value of the lightbank[0]
  sll %l1, 1, %l1
           !%l1 now holds the shifted value of the lightbank[1]
  or  %l4, %l0, %l0
           !%l0 now has the correct LSB based on lightBanks[1]'s MSB
   
  dec %l3             
  ba shift_left       
  nop

end_loop:
  st  %l0, [%i0]      
  st  %l1, [%i0 + 4]   



ret
restore
