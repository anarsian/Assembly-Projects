/*
 * Filename: testisOdd.c
 * Author: Anish Narsian
 * Userid: cs30xke
 * Description: Unit test program to test the function isOdd.
 * Date: 16 October 2013
 * Sources of Help: The provided tester file
 */ 

#include <stdlib.h>	/* For rand() function prototype */
#include <limits.h>	/* For LONG_MIN and LONG_MAX */
#include "header.h"	/* For checkRange() function prototype */
#include "test.h"	/* For TEST() macro and stdio.h */

/*
 * Testing int isOdd( long value) 
 * @return(for isOdd) 1 if value is odd. Otherwise returns 0.
 * Precondition: None
 */


void
testisOdd()
{
    printf( "Testing isOdd()\n" );

    //checking with multiple values.
    TEST( isOdd( 3 ) == 1 );
    TEST( isOdd( 38 ) == 0 );
    TEST( isOdd( 3003 ) == 1 );
    TEST( isOdd( 84 ) == 0 );
    TEST( isOdd( 15823 ) == 1 );
    TEST( isOdd( 2000 ) == 0 );
    TEST( isOdd( -10 ) == 0 );


    printf( "Finished running tests on testisOdd()\n" );
}

//calling the tests from here.
int
main()
{
    testisOdd();

    return 0;
}
