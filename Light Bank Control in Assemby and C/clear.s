/* 
 * Filename: clear.s
 * Author: Anish Narsian
 * Description: This clears bits 
 * Date: Oct 27, 2013
 * Source of Help: Notes
 */

.global clear
.section ".data"	
.section ".text"

/*
 * Function name: clear()
 * Function prototype: void clear(unsigned int lightBank[], 
 * 			      const unsigned int bank0, const unsigned int bank1
 * Description: This function clears the bits
 * Paramters:
 *	    arg 1: unsigned int lightBank[] -- array where the light bank is stored
 *	    arg 2: const unsigned int bank0 -- new pattern for the first bank
 *	    arg 3: const unsigned int bank1 -- new pattern for the second bank
 * Side Effects: None
 * Error Conditions: None
 * Return Value: Void
 * Registers used:
 * %i0 - where light bank is saved
 * %i1 - The light bank clearing
 * %i2 - The second light bank clearing
 * %l0 - 1st 32 bit bank 
 * %l1 - 2nd 32 bit bank
 */


clear:
  save	%sp, -96, %sp
  ld	[%i0], %l0		!Load the first lightbank
  ld	[%i0 + 4], %l1	!Load the second lightbank

  andn	%l0, %i1, %i1		
  andn	%l1, %i2, %i2		

  st  %i1, [%i0]		!Store the new value in the first lightbank
  st  %i2, [%i0+4]		!Store the new value in the second lightbank

ret
restore                   !ret restore
