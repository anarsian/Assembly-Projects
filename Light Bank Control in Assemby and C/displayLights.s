/* 
 * Filename: displayLights.s
 * Author: Anish Narsian
 * Description: Display light
 * Date: Oct 30, 2013
 * Source of Help: Notes, Tutor
 */

.global displayLights
.section ".data"	
SPACE = ' ' 		 ! space bar
STAR = '*'               ! ON
DASH = '-'               ! OFF
NEW_LINE = '\n'          ! Enter
MSB_MASK = 0x80000000   
	
.section ".text"




		 

/*
 * Function name: displayLights()
 * Function protoype: void displayLights(const unsigned int lightBank[]);
 * Description: It displays the lights
 * Parameters:
 *	      arg 1: The light bank array
 * Side Effects: None
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 * %i0 - Where the lightbank is stored
 * %l0 - lbank 1
 * %l1 - lbank 2
 * %l2 - MSB
 * %l3 - Index
 * %o0 - Used to place the argument of printChar
 */




displayLights:
  save  %sp, -96, %sp
  ld    [%i0], %l0      !Load lbank 1
  ld    [%i0 + 4], %l1  !Load lbank 2
  clr   %l3             !Set %l3 as a index

display:
  cmp     %l3, 32         
  bl      displayFirst    !If %index < 32 then branch to displayFirst
  nop
  cmp     %l3, 64        
  bl      displaySecond   !If %l3 less than 64 then branch to displaySecond
  nop
  ba      end             !If greater than 64 go to end
  nop

displayFirst:  !Display bank 1
  set     MSB_MASK, %l2
  and     %l2,%l0,%l2     !%l2= the MSB of lightbank[0]
  sll     %l0, 1, %l0     !Shift it left by 1
  cmp     %g0, %l2        !Compare %l2 with 0
  bne     printSTAR         !If it's not equal to 0 branch to printON
  nop
  ba      printDASH       
  nop

displaySecond:
  set     MSB_MASK, %l2
  and     %l2, %l1, %l2   !%l2 now contains the MSB of lightbank[1]
  sll     %l1, 1, %l1     !Shift it left by 1
  cmp     %l2, %g0        !Compare %l2 with 0
  bne     printSTAR         
  nop
  ba      printDASH      
  nop

printSTAR:
  set     STAR, %o0         !Set STAR to %o0
  call    printChar       !Print STAR
  nop
  ba      increment        !Branch always to increase
  nop

printDASH:
  set     DASH, %o0        !Set OFF to %o0
  call    printChar       !Print OFF
  nop
  ba      increment        !Increments and does spacing
  nop

increment:
  inc     %l3             !Increment the counter
  mov     %l3, %o0        !Move %l3 to %o0
  mov     4, %o1          !Move 4 to %o1
  call    .rem            !get remainder
  nop


  cmp     %o0, 0        
  bne     display         !branch to display
  nop
  set     SPACE, %o0      
  call    printChar       !Print SPACE
  nop
  ba      display         !End incrementing and spcing
  nop

end:
  set     NEW_LINE, %o0   !Set NEW_LINE to %o0
  call    printChar       !Enter
  nop


ret
restore          !Ret restore
