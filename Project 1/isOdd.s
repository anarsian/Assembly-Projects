/*
 * Filename: isOdd.s
 * Author: Anish Narsian
 * Description : checek if the given number is odd
 * Date: October 16, 2013
 * Sources of Help: Notes
 */


  .global isOdd
  .section ".data"
  .section ".text"



/*
 * Funtion name: isOdd()
 * Funtion prototype: int isOdd( long num );
 * Description: Checks if the value is odd. 
 *              Returns 0 if false 1 if true
 * Parameters:
 * 		arg 1: long num -- value to check 
 *
 * Side Effects: None
 * Error Conditions: None
 * Return value: 0 if false 1 if ture
 *
 * Registers used.
 *		%i0 - arg 1
 */

isOdd:
  save %sp, -96, %sp
  mov %i0, %o0
  mov 2, %o1
  call .rem          !value/2 remainder
  nop
  mov %o0, %i0
  
  cmp %i0, 1
  bne,a label1         !rem !=1 then return 0
  nop
  mov 1, %i0           !else return 1 
  ret
  restore


label1:
  mov 0, %i0
  ret
  restore



