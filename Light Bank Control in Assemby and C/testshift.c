/*
 * Name: Anish Narsian
 * File:testshift
 */
#include "test.h"       /* For TEST() macro and stdio.h */
#include <stdlib.h>     /* For rand() function prototype */
#include <limits.h>     /* For LONG_MIN and LONG_MAX */
#include "pa2.h"        /* For rotate() function prototype */


/*
 * This file tests the shift method
 */
void
testshift()
{
    unsigned int mask[2];
    unsigned int mask1[2];
    //int savedRotateCnt;

    printf( "Testing test()\n" );

    /*
     * Test with rotateCnt of 0 - should be no change.
     */

    mask[0] = 0x12345679;
    mask[1] = 0x00000014;

    shift( mask, 9 );
    TEST( mask[0] == 0x68ACB200 && mask[1] == 0x00002800 );

    mask[0] = 0x68ACB200;
    mask[1] = 0x00002800;
    shift(mask,-9);
    TEST(mask[0] == 0x003456 && mask[1] == 0x00000016);
    //fprintf(stdout, "%d %d", mask[0], mask[1]);
  
    /*
     * Test rotating right 1 bit.
     */

    printf( "Finished running tests on shift()\n" );

}

int
main()
{
    testshift();

    return 0;
}

