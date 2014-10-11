/*
 * Filename: printChar.s
 * Author: Anish Narsian
 * Description : prints a single character
 *		 Called from displayDiamond
 * Date: October 16 2013
 * Sources of help: Notes
 * 
 */  


  .global printChar
  .section ".data"
fmt:
 .asciz "%c"
  .section ".text"


/*
 * Funtion name: printChar()
 * Funtion prototype: void printChar( char ch );
 * Description: Prints character via printf()
 * Parameters:
 * 		arg 1: char ch -- the character to be printed
 *
 *
 * Error Conditions: None [Arg 1 is not checked to ensure it is not null]
 * Return value: void
 *
 * Registers used.
 *		%i0 - arg 1: -- char value passed
 *
 *      	%o0 - param 1 tp printf() -- fmt string.
 *		%o1 - param 2 to printf() -- copy of arg1 being passed in.
 *
 */


printChar:
   save %sp,-96,%sp
   set  fmt,  %o0          !1st param
   mov %i0, %o1            !2nd param
   call printf, 2          !2 params
   nop


   ret                      !return
   restore
