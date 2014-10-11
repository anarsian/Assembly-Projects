/*
 * Filename: testset.c
 * Author: Anish Narsian
 */

#include "test.h"       /* For TEST() macro and stdio.h */
#include <stdlib.h>     /* For rand() function prototype */
#include <limits.h>     /* For LONG_MIN and LONG_MAX */
#include "pa2.h"        /* For rotate() function prototype */

void
testset()
{
  unsigned int mask[2];

  printf( "Testing set()\n");

  /*
   * Test turning off bits
   */
  
  mask[0] = 0x00000000;
  mask[1] = 0x00000000;

  set(mask, 0xFFFFFFFF, 0xFFFFFFFF);
  TEST( mask[0] == 0xFFFFFFFF && mask[1] == 0xFFFFFFFF );

 

int
main()
{
  testset();

  return 0;
}
