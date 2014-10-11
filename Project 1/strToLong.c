/*
 * Filename: strToLong.c
 * Author: Anish Narsian
 * Description : Converts string to the given base
 *               outputs respective errors
 * Date: 16 October 2013
 * Sources of Help: Notes, Tutors
 *
 * */

#include "header.h"
#include <errno.h>
#include <stdlib.h>


 /*
  * Function name: strToLong()
  * Function prototype: long strToLong( char *str, int base );
  * Description: Converts string to the given base
  *               outputs respective errors
  * @param: arg1 : char *str(string to convert)
  *         arg2 : int base(base used for conversion)
  * @return : long
  * Error Conditions: Check value of errno and *endptr
  *                   for them != 0
  */

long strToLong(char *str, int base) {
  char *endptr;  //Checks for non-integer
  long num = strtol(str, &endptr, base);
  char errMsg[BUFSIZ]; //Constant
  errno = 0;
  
  num = strtol(str, &endptr, base);
  if(errno != 0) {
   
    (void)snprintf(errMsg,BUFSIZ,
		    "\n\tConverting \"%s\" base \"%d\"", str, base);
    perror(errMsg );
    
    return NULL;
  }


  //If endPointer points to something other than null character
  if(*endptr != '\0') {  
    (void)fprintf(stderr, "\n\t\"%s\" is not an integer\n", str);
    errno = 1;
    return NULL;
  } 
  return num;
}
