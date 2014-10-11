/* 
 * Filename: toggle.s
 * Author: Anish Narsian
 * Description: Toggle lights
 * Date: Oct 30, 2013
 * Source of Help: Piazza
 */

.global toggle	
.section ".data"	
.section ".text"	

/*
 * Function name: toggle()
 * Function prototype: 
 *      void toggle(unsigned int lightBank[], const unsigned int bank0,
 *                       const unsigned int bank1);
 * Description: Toggle lights
 * Paramters:
 *	arg 1: lightBank arr
 *	arg 2: bank0 change 
 *	arg 3: bank1 change
 *
 * Side Effects: None
 * Error Conditions: none
 * Return Value: None
 * Registers used:
 * %i0 - light banke arr
 * %i1 - bank0 change
 * %i2 - bank1 change
 * %l0 - load store
 * %l1 - load store
 */


toggle:
  save	%sp, -96, %sp
  ld	[%i0], %l0		!Load 
  ld	[%i0 + 4], %l1	!Load 
  xor	%l0, %i1, %i1		
  xor	%l1, %i2, %i2		



  st	%i1, [%i0]		!Store 
  st	%i2, [%i0+4]		!Store 



ret
restore
