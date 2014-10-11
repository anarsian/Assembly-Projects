/* 
 * Filename: strToULong.s
 * Author: Anish Narsian
 * Description: convert a string into a long
 * Date: Oct 30, 2013
 * Source of Help: Notes
 */

.global strToULong
.section ".data"            

BUFSIZ = 1024

BUFOFFSET = 1028

PTRSIZ = 4

PTROFFSET = 4

errMsg1:
    .asciz  "\n\tConverting \"%s\" base \"%d\""

errMsg2:
    .asciz  "\n\t\"%s\" is not an integer \n"

.section ".text"

/*
 * Function name: strToULong()
 * Function prototype: 
 *             void strToULong (const char* str, const int base)
 * Description: convert a string into a unsigned long
 * Parameters:
 *    arg 1: string to convert
 *    arg 2: the base which we need to convert it to
 * Side Effects: None
 * Return Value: A unsigned long
 * Registers Used:
 * %i0 - String to convert
 * %i1 - base
 * %l0 - pointer to end pointer
 * %l1 - number
 * %l2 - errno register
 * %l3 - errMsg register
 */

strToULong:
  save	%sp, -(92+BUFSIZ+PTRSIZ)&-8, %sp	! Save
  sub	%fp, PTROFFSET, %l0                 	! & of *endptr
  sub	%fp, BUFOFFSET, %l3		        
  set 	errno, %l2		                
  st	%g0, [%l2]			        ! clear errno
  mov	%i0, %o0			        
  mov	%l0, %o1		                
  call	strtoul		                        ! convert string to uns long
  mov	%i1, %o2				!Base move to 02
  mov	%o0, %l1				                

errnoErr:
  ld	[%l2], %l5				  !Errno
  cmp	%l5,0 					  ! Compares errno with 0
  bne	errnoErrTrue				  
  nop						  	
  ba	endptrErr				  ! Else 
  nop

errnoErrTrue:
				
  mov	%l3, %o0				  
  mov	BUFSIZ, %o1				 
  set	errMsg1, %o2				  ! Set the fmt to %o2


  mov	%i0, %o3		

		 
  mov	%i1, %o4				 
  call	snprintf, 5				  ! Call snprintf
  nop
  mov	%l3, %o0				
  call	perror					 
  nop
 
  mov	%g0, %i0				  ! Return null


ret
restore

endptrErr:

  ld	[%fp-PTROFFSET], %l0			   
  ldub	[%l0], %l0				       ! Get the uns bit from *endptr
  cmp	%l0, %g0				       ! Compare *enptr with 0
  bne	endptrErrTrue			                ! If *endptr != 0 then branch
  nop						       ! to ErrTrue
  ba	end					       
  nop

endptrErrTrue:			


	
  set	stdError, %o0				            
  ld	[%o0], %o0				                ! Load the stdError to %o0
  set	errMsg2, %o1				            ! Set the format to %o1
  mov	%i0, %o2				                ! Move the string to %o2
  call	fprintf, 3				            ! Call fprintf
  nop
  mov	-1, %l5
  st	%l5, [%l2]
  mov	0, %i0					    ! Return null


ret
restore

end:
  mov	%l1, %i0				    ! Return num

ret
restore
