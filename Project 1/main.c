/*
 * Filename: main.c
 * Author: Anish Narsian
 * Description : Checks the conditions and prints everything.
 * Date: 16 October 2013
 * Sources of help: Tutors, notes
 *
 */

#include "header.h"
#include <errno.h>


/*
 * Function name: main()
 * Function prototype: int main(int argc, char *argv[])
 *
 * Description: Checks args calls displayDiamond if no error messages printed
 * Parameters: int argc" the no. of args sent from command line.
 *             char *argv[]: array of command line arguments
 * Side Effects: None
 * Error Conditions: Returns 1 if finds any error in any argument
 * Return Value: 0 if the diamond was printed
 *               1 if error messages were printed
 */

int main(int argc, char *argv[] )  {


  typedef int bool;
  #define true 1
  #define false 0
 
 
  bool errFlag = false; //Error flag to prevent displayDiamond when errors

  
  /*Checks no. of args*/
  if(argc!= 5) {

    (void)fprintf(stderr, "\nUsage: %s width height border_ch diamond_ch\n",
		    argv[0]);
    (void)fprintf(stderr,
              "    width      (must be odd within the range of [%d - %d])\n",
		  WIDTH_MIN, WIDTH_MAX);
    (void)fprintf(stderr,
	      "    height     (must be odd within the range of [%d - %d])\n",
		  HEIGHT_MIN, HEIGHT_MAX);
    (void)fprintf(stderr, "               (must be less than width)\n");
    (void)fprintf(stderr,
	"    border_ch  (must be an ASCII value within the range [%d - %d])\n",
	ASCII_MIN, ASCII_MAX);
    (void)fprintf(stderr,
		  "               (must be different than diamond_ch)\n");
    (void)fprintf(stderr,
        "    diamond_ch (must be an ASCII value within the range [%d - %d])\n"
	,ASCII_MIN, ASCII_MAX);
    (void)fprintf(stderr,
		  "               (must be different than border_ch)\n\n");


    errFlag = true;
    return 1;
  }

  /*The width argument is argv[1]*/
  long arg1 = strToLong(argv[1],BASE);
  if(errno != 0) {
    errFlag = true;
  }

  //If errno is not zero different error message printed as from strToLong
  if(errno == 0) { 
    if(checkRange(arg1, WIDTH_MIN, WIDTH_MAX) == 0) {
      (void)fprintf(stderr,
		    "\n\twidth(%ld) must be within the range of [%d - %d]\n",
		    arg1, WIDTH_MIN, WIDTH_MAX);
      errFlag = true;
    }

    if(isOdd(arg1) == 0) {
      (void)fprintf(stderr,"\n\twidth(%ld) must be an odd number.\n", arg1);
      errFlag = true;
    }
  }

  /*The height argument is argv[2]*/
  long arg2 = strToLong(argv[2],BASE);
  if(errno != 0) {
     errFlag = true;
  }
  //If errno is not zero different error message printed as from strToLong
  if(errno == 0) {
    if(checkRange(arg2,HEIGHT_MIN, HEIGHT_MAX)== 0) {
      (void)fprintf(stderr,
		  "\n\theight(%ld) must be within the range of [%d - %d]\n",
		  arg2, HEIGHT_MIN, HEIGHT_MAX);
      errFlag = true;
    }

    if(isOdd(arg2) ==0) {
      (void)fprintf(stderr,"\n\theight(%ld) must be an odd number.\n" ,arg2);
      errFlag = true;
    }

    if(arg2>=arg1) {
      (void)fprintf(stderr,"\n\theight(%ld) must be less than width(%ld)\n",
		      arg2, arg1);
      errFlag = true;
    }
  }

  /*borderCh is argv[3]*/
  long arg3 = strToLong(argv[3], BASE);
  if(errno != 0) {
    errFlag = true;
  }

  //If errno is not zero different error message printed as from strToLong
  if(errno == 0) {
    if(checkRange(arg3,ASCII_MIN, ASCII_MAX) == 0) {
      (void)fprintf(stderr,
	  "\n\tborder_ch(%ld) must be an ASCII code in the range [%d - %d]\n",
          arg3,ASCII_MIN,ASCII_MAX);
      errFlag = true;
    }
  }
  
  /*DiamondCh is argv[4]*/
  long arg4 = strToLong(argv[4], BASE);
  if(errno != 0) {
    errFlag = true;
  }

  //If errno is not zero different error message printed as from strToLong
  if(errno == 0) {	  
    if(checkRange(arg4,ASCII_MIN, ASCII_MAX) == 0) {
      (void)fprintf(stderr,
	 "\n\tdiamond_ch(%ld) must be an ASCII code in the range [%d - %d]\n",
	 arg4, ASCII_MIN,ASCII_MAX);
      errFlag = true;
    }
  
    if(arg3 == arg4) {
      (void)fprintf(stderr,
	   "\n\tborder_ch(%ld) and diamond_ch(%ld) must be different\n",
	   arg3,arg4);
      errFlag = true;
    }
  }

  //If error flag is true then we return 1 and not displayDiamond
  if(errFlag  == true) {
    (void)fprintf(stderr, "\n");
    return 1;
  }

  //Display Diamond if errFlag is not true
  displayDiamond(arg1,arg2,arg3,arg4);
  return 0;

}  


