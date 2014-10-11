/* 
 * Filename: set.s
 * Author: Anish Narsian
 * Description: This function sets the lights 
 * Date: Oct 27, 2013
 * Source of Help: Piazza
 */

.global set
.section ".data"
.section ".text"		

/*
 * Function name: set()
 * Function prototype: void set(unsigned int lightBank[], 
 * 			      const unsigned int bank0, const unsigned int bank1);
 * Description: This function sets the lights based on which bits are 
 *		  set in the bit patterns specified.
 * Paramters:
 *	arg 1: lightBank array
 *	arg 2: bank0 patterm
 *	arg 3: bank1 pattern
 *
 * Side Effects: None 
 * Error Conditions: 
 * Return Value: None
 * Registers used:
 * %i0 - light bank
 * %i1 - set light bank 1
 * %i2 - set light bank 2
 * %l0 - load store
 * %l1 - load store
 */

set:
  save  %sp, -96, %sp
  ld    [%i0], %l0		!Load
  ld    [%i0 + 4], %l1	        !second lightbank
  or	%l0, %i1, %i1		 
  or	%l1, %i2, %i2		

  st   %i1, [%i0]		!Store the change in 1st lightbank
  st   %i2, [%i0+4]		!Store the change in 2nd lightbank

ret
restore
	
