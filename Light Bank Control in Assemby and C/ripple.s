/* 
 * Filename: ripple.s
 * Author: Anish Narsian
 * Description: Create a Ripple effect
 * Date: Oct 30, 2013
 * Source of Help: Notes
 */

.global ripple		
.section ".data"		 
MSB_MASK    = 0x80000000    
LSB_MASK    = 0x00000001
SIXBIT_MASK = 0x0000003F
.section ".text"



/*
 * Function name: ripple()
 * Function prototype: void ripple(unsigned int lightBank[], const int rippleCnt)
 * Description: Create ripple effect
 * Paramters:
 *        arg 1: light bank array
 *        arg 2: shiftCnt
 * Side Effects: None
 * Error Conditions: None
 * Return Value: None
 * Registers used:
 * %i0 - where light bank is saved
 * %i1 - The shift count
 * %l0 -  first light bank
 * %l1 -  second light bank
 * %l2 - sign bi
 * %l3 -  count
 * %l4 -  MSB or LSB 
 * %l5 -  MSB or LSB  
 */


ripple:
  save  %sp, -96, %sp
  ld  [%i0], %l0	
  ld  [%i0 + 4], %l1	

  set MSB_MASK, %l2   !Singn mask
  and %l2, %i1, %l2   !%l2 = sign bit
  mov %i1, %l3	  

  cmp %g0, %l2        !Compare 0 and sign bit
  bne ripple_right     !sin !=0 then ripple right
  nop
  ba  ripple_left      
  nop
ripple_right:
  cmp %g0, %i1        !Compare that count is not 0
  be  end_loop        !If that then no ripple
  nop
  and %l0, LSB_MASK,%l4
            !%l4 now holds the LSB of the lightbank[0] preShift
  sll %l4, 31, %l4
            !%l4 now holds the LSB of the lightbank[0] preshift in its MSB
  and %l1, LSB_MASK, %l5
            !%l5 now holds the LSB of the lightbank[1] preShift
  sll %l5, 31, %l5
            !%l5 now holds the LSB of the lightbank[1] preshift in its MSB
  srl %l0, 1, %l0 
            !%l0 now holds the shifted value of lightbank[0]
  srl %l1, 1, %l1
            !%l1 now holds the shifted value of lightBank[1]
  or  %l4, %l1, %l1
            !%l1 now has the correct MSB based on lightBanks[0]'s LSB
  or  %l5, %l0, %l0
            !%l0 now has the correct MSB based on lightBanks[1]'s LSB




  inc %i1              !Increments %l3 by one
  st  %l0, [%i0]      !Store it in %o0
  st  %l1, [%i0 + 4]  !Store it in %o0 + 4
  mov %i0, %o0
  call displayLights	!Calls displayLights
  nop
  ba ripple_right      !Always shift back
  nop







ripple_left:
  cmp %g0, %l3        
  be end_loop        
  nop

  set  MSB_MASK, %l6
  and %l0, %l6, %l4
            !%l4 now holds the MSB of the lightbank[0] preShift
  srl %l4, 31, %l4
            !%l4 now holds the MSB of the lightbank[0] preshift in its LSB
  and %l1, %l6, %l5
            !%l5 now holds the MSB of the lightbank[1] preShift
  srl %l5, 31, %l5
            !%l5 now holds the MSB of the lightbank[1] preShift in its LSB
  sll %l0, 1, %l0
            !%l0 now holds the shifted value of the lightbank[0]
  sll %l1, 1, %l1
            !%l1 now holds the shifted value of the lightbank[1]
  or  %l5, %l0, %l0
            !%l0 now has the correct LSB based on lightBanks[1]'s MSB
  or  %l4, %l1, %l1
            !%l1 now has the correct LSB based on lightBank[0]'s MSB

  dec %l3              !Decrement
  st  %l0, [%i0]	
  st  %l1, [%i0 + 4]

	
  mov %i0, %o0
  call	displayLights	!Calls displayLights
  nop

  ba ripple_left       !Always shift back
  nop

end_loop:
  st  %l0, [%i0]      !Store the new value in the first lightbank
  st  %l1, [%i0 + 4]  !Store the new value in the second lightbank 



ret
restore











