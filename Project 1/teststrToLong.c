/*
 * Filename: teststrToLong.c
 * Author: Anish Narsian
 * Userid: cs30xke
 * Description: Unit test program to test the function checkRange.
 * Date: October 16 2013
 * Sources of Help: The porvided tester file
 */

#include <stdlib.h>	/* For rand() function prototype */
#include <limits.h>	/* For LONG_MIN and LONG_MAX */
#include "header.h"	/* For strToLong() function prototype */
#include "test.h"	/* For TEST() macro and stdio.h */

/*
 * Testing long strToLong
 * @return long value of string
 */


void
teststrToLong()
{
   printf( "Testing strToLong()\n" );
 
   /*Test for incorrect*/
   TEST( strToLong( "abcde", 10 ) == 0 );
   /* Test for 0*/
   TEST( strToLong(0,10) == 0);
   /*Test for one other random value*/
   TEST( strToLong("1000",10) == 1000);
   TEST( strToLong( "999999999999",10) == LONG_MAX);
   TEST( strToLong( "-999999999999",10) == LONG_MIN);
 
   /* Test for Correct strings in each base */
   TEST( strToLong( "2",2 )  == 10 );
 
   TEST( strToLong( "15",2 ) == 1111);
 
 
 
 
 
   printf( "Finished running tests on strToLong()\n" );
}
 
/*main*/
int
main()
{
   teststrToLong();
   
   return 0;
}


