/* 
 * Filename: rotate.s
 * Author: Anish Narsian
 * Description: rotate light pattern
 * Date: Oct 30, 2013
 * Source of Help: notes
 */

.global rotate
.section ".data"
MSB_MASK = 0x80000000
LSB_MASK = 0x00000001
SIXBIT_MASK = 0x0000003F


/*
 * Function name: rotate()
 * Function prototype: 
 *           void rotate(unsigned int lightBank[], const int rotateCnt)
 * Description: rotate light
 * Paramters:
 *       arg 1: lightBank array
 *       arg 2: shiftCnt
 * Side Effects: 
 * Error Conditions:
 * Return Value: None
 * Registers used:
 * %i0 - where light bank is saved
 * %i1 - The shift count
 * %l0 - first light bank
 * %l1 -  second light bank
 * %l2 - sign bit
 * %l3 -  lower six bits 
 * %l4 -  MSB or LSB 
 * %l5 -  MSB or LSB 
 * %l6 - MSB Mask
 */

.section ".text"
rotate:
  save %sp,-96,%sp
  ld      [%i0],%l0          !  Load
  ld      [%i0+4],%l1
  set 	MSB_MASK,%l6       
  and     %l6,%i1,%l2
  cmp     %g0,%l2
  bne     rotate_right
  nop

rotate_left:
  set  SIXBIT_MASK,%l3   !Get six bit val
  and  %l3,%i1,%l3
  mov  %g0,%l5     !Set index to 0
  cmp  %l5,%l3     !Index>= then end
  bge  end_loop
  nop

loop1:
  and     %l0,%l6,%l4  !LSB lb[0] preshift
  srl     %l4,31,%l4   ! l4 now has the lb[0]'s LSB in MSB
  and 	 %l1,%l6,%l7


  srl 	 %l7,31,%l7
  sll     %l0,1,%l0    !Shift left
  sll     %l1,1,%l1    ! Shift left


  or      %l1,%l4,%l1
  or 	 %l0,%l7,%l0    


  st 	 %l0,[%i0]            !Store values
  st	 %l1,[%i0 + 4]


  inc     %l5
  cmp     %l5,%l3
  bl      loop1
  nop

  cmp 	%l5,%l3
  bge     end_loop           !loop again if index<l3
  nop

rotate_right:
  neg 	 %i1                    !Negate
  set	 SIXBIT_MASK,%l3
  and 	 %l3,%i1,%l3
  mov     %g0,%l5
  cmp     %l5,%l3
  bge      end_loop
  nop

loop:
  and     %l1,LSB_MASK,%l4   !get LSB of lb[1]
  and 	 %l0,LSB_MASK,%l7    !get LSB of lb[0]


  sll     %l4,31,%l4           !Shift Left
  sll 	 %l7,31,%l7


  srl     %l0,1,%l0          !Shift Right Logical
  srl     %l1,1,%l1


  or      %l0,%l4,%l0
  or 	 %l1,%l7,%l1


  st 	 %l0,[%i0]
  st 	 %l1,[%i0+4]


  inc     %l5
  cmp     %l5,%l3
  bl      loop
  nop
end_loop:


ret
restore                      !ret restore









