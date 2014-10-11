/*
 *Filename: displayDiamond.s
 *Author: Anish Narsian
 *Description: SPARC assembly routine to print out a diamond
 *             using 4 args: width, height, inner character
 *             and outer character
 *Date: October 16 2013
 *Sources of Help: Notes
 */


  .global displayDiamond
  .section ".data"
  .section ".text"




/*
 *Function name: displayDiamond()
 * Function prototype: void displayDiamond(long width, long height, long borderCh, long diamondCh )
 *Description: Prints to stdout a a diamond shape
 *Parameters:
 *       arg1: long width which is the width
 *       arg2: long height which is the height
 *       arg3:long borderCh is the ASCII value of outerCH
 *       arg4: long diamondCh is the ASCII value of innerCh
 *Side Effects: 
 *Error Condtion: None. It is checked in main
 *Return Value: None
 *
 *Registers used:
 *      %i0 -  %i3 for 4 args 
 *      %l0 - %l5 for indexes and so on
 *      %o0 - %o5 for various operations 
 *
 */

displayDiamond:
  /*Move all arguments to output registers*/
  save %sp,-96,%sp
  mov %i2, %l1  !long borderCh
  mov %i3, %l2  !long diamondCh

  /*Display top row of outer border*/
  mov  1,%l0     !col mapped to %l0

  cmp %l0, %i0   
  bg end_loop   !index>width
  nop


loop:
  mov %l1, %o0
  call printChar   !print borderCh
  nop
  inc %l0
  cmp %l0,%i0
  ble loop
  nop

end_loop:
  
/*End of Loop 1*/

  mov '\n',%o0
  call printChar    !Is 0 the correct value for null char?
  nop

/*Display the top half of diamond pattern*/

  mov 1, %l0   !row mapped to lo. row = lo
  sub %i1, 2, %l3  !height-2 stored in l3
  cmp %l0, %l3
  bg end_loop1
  nop

loop1:

  /*First Inner Loop*/
  sub %i0, %l0, %l4  !outer=width-row;o0 gets overwritten .div later hence i0
  mov %l4, %o0
  mov 2, %o1
  call .div
  nop

  mov %o0, %l4  !Store the actual value of outer(result of division)
  mov 1, %l5
  cmp %l4, %l5  !compare outer to 1
  bl end_loop1a
  nop

loop1a:
  mov %l1,%o0         !Since argument must be in o registers
  call printChar  !print outerCh
  nop
  dec %l4
  cmp %l4, %l5
  bge loop1a
  nop

end_loop1a:

  /*Second Inner Loop*/
  mov 1, %l4  !inner index mapped to l4//
  cmp %l4,%l0 !Compare inner with row
  bg end_loop1b
  nop

loop1b:
  mov %l2, %o0
  call printChar  !print innerCh
  nop
  inc %l4
  cmp %l4, %l0
  ble loop1b
  nop

end_loop1b:

  /*Third Inner Loop*/
  sub %i0, %l0, %o5  !Store index outer = (width-row)
  mov %o5, %o0
  mov 2, %o1
  call .div
  nop
  mov %o0, %l4  !Store index outer = (width-row)/2
  cmp %l4, 1
  bl end_loop1c
  nop

loop1c:
  mov %l1, %o0
  call printChar  !print outerCh
  nop
  dec %l4
  cmp %l4, 1
  bge loop1c
  nop

end_loop1c:

  mov '\n',%o0
  call printChar
  nop

  
  
  
/*to run loop1 again, the condition check and incrementation for loop1*/
  add 2, %l0, %l0
  cmp %l0, %l3
  ble loop1
  nop
  
end_loop1:                       








/* Now printing middle row and lower half of Diamond Pattern */

  mov %i1, %l0  !Mapping index row to height !i1
  
  cmp %l0, 0
  bl end_loop2
  nop
loop2:
 ! mov %l2,%o0
  !call printChar
  !nop



  /*First inner loop to print border char*/
  sub %i0, %l0, %l4  !outer = width-row; o0 gets overwritten in .div
  mov %l4, %o0
  mov 2, %o1
  call .div
  nop
  
  mov %o0, %l4  !outer = (width-row)/2
  cmp %l4, 1
  bl end_loop2a
  nop
  
loop2a:
  mov %l1, %o0
  call printChar
  nop
  dec %l4   !Decrement outer
  cmp %l4, 1
  bge loop2a
  nop

end_loop2a:


/*Second inner loop to print the inner/diamond char */
  mov 1, %l3  !store index inner
  cmp %l3, %l0
  bg end_loop2b  
  nop

loop2b:
  mov %l2, %o0
  call printChar   !Call printchar with innerch
  nop

  inc %l3
  cmp %l3, %l0
  ble loop2b
  nop

end_loop2b:


/*Third inner loop to print the outer border*/


  sub %i0, %l0, %l4  !outer = width-row; o0 gets overwritten in .div later
  mov %l4, %o0
  mov 2, %o1
  call .div
  nop
  
  mov %o0, %l4  !outer = (width-row)/2
  cmp %l4, 1
  bl end_loop2c
  nop
  
loop2c:
  mov %l1, %o0
  call printChar
  nop
  dec %l4   !Decrement outer
  cmp %l4, 1
  bge loop2c
  nop

end_loop2c:

  mov '\n', %o0
  call printChar
  nop 
  
/*Incrementation for loop2 and redirection to loop2 label */
  dec %l0
  dec %l0
  cmp %l0, 0
  bge loop2  ! index lo>=0
  nop

end_loop2:





/*Display bottom row of the outer border*/
  mov 1, %l3  !index col =1
  cmp %l3, %i0
  bg end_loop3
  nop

loop3:
  mov %l1, %o0
  call printChar  
  nop

  inc %l3
  cmp %l3, %i0
  ble loop3       ! index<=width
  nop

end_loop3:

  mov '\n', %o0
  call printChar
  nop

  ret                   !Return from subroutine
  restore               !Restore callers window; in "ret" delay slo

