/*
 * Filename: checkRange.s
 * Author: Anish Narsian
 * Description : Checks if the values is in the given range
 * Date: October 16, 2013
 * Sources of help: Notes
 * 
 */

  .global checkRange
  .section ".text"


 /*
 * Funtion name: checkRange()
 * Funtion prototype: int checkRange(long value,long minRange,long maxRange);
 * Description: checks if the value is within the given range
 * Parameters:
 * 		arg 1: long value -- the value to be checked
 *              arg 2: long minRange -- the minimum possible value of arg 1
 *              arg 3: long maxRange -- the maximum possible value of arg 1
 *
 * Side Effects: None
 * Error Conditions: None
 * Return value: return 1 if test passes
 *               return 0 if test fails
 *
 * Registers used.
 *		%i0 - arg 1 - %o0
 *              %i1 - arg 2 - %o1
 *		%i2 - arg 3 - %o1
 */

checkRange:
  save  %sp,-96,%sp
  mov %i0, %o0
  mov %i1, %o1
  cmp %o0,%o1
  bge label1               !if value>=min the true and move on
  nop
  mov 0,  %i0              !return 0(false) if not
  ret
  restore

label1:
  mov %i2, %o1   
  cmp %o0,%o1
  ble label2              !if value<=max true and move on
  nop
  mov 0, %i0
  ret 
  restore

label2:
  mov 1, %i0              !return 1(true)
  ret
  restore
  
  
