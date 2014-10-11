/*
 * Filename: testclear.c
 * Author: Anish Narsian
 *
 */

#include "test.h"       /* For TEST() macro and stdio.h */
#include <stdlib.h>     /* For rand() function prototype */
#include <limits.h>     /* For LONG_MIN and LONG_MAX */
#include "pa2.h"        /* For rotate() function prototype */

void
testclear()
{
  unsigned int mask[2];

  printf( "Testing clear()\n");

  /*
   * Test turning off bits
   */
  
  mask[0] = 0xFFFFFFFF;
  mask[1] = 0xFFFFFFFF;

  clear(mask, 0xFFFFFFFF, 0xFFFFFFFF);
  TEST( mask[0] == 0x00000000 && mask[1] == 0x00000000 );

  /*
   * Test to see what happens if bit is on
   */

  mask[0] = 0x11111111;
  mask[1] = 0x11111111;

  clear(mask, 0x11111111, 0x11111111);
  TEST (mask[0] == 0x22222222 && mask[1] == 0x22222222);

  printf( "Finished running tests on clear()\n");
}

int
main()
{
  testclear();

  return 0;
}
