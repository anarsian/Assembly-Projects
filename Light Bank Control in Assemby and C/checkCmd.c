/* Filename: checkCmd.c
 * Author: Anish Narsian
 * Description: This file is used to check passed in commands with
 *              those that are allowable
 * Date: October 30th, 2013
 * Sources:
 */
  
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
 #include "header.h"
 #include "string.h"

/* Fucntion name: checkCmd()
 * Function prototype:
 * int checkCmd(const char * const cmdString, const char * const commands[])
 * Description: It is used to check the commands to ensure only passable ones
 *              are allowed
 * parameters:
 *           arg1: cmdString, string passed in
 *           arg2: commands: strings possible
 * Side Effects: None
 * Error Condition: None
 * Return Value: Integer, returns index of command if match, -1 if not
 */
 
 int checkCmd(const char * const cmdString, const char * const commands[]){
    int cmp; 
    int i=0;



    while( commands[i] != NULL){
    /* compares the string passed in with those possible using index i
     * if same, returns 0*/
      cmp = strcmp(cmdString, commands[i]); 
      /* if cmp equals 0 then match, return index */
      if(cmp == 0){
        return i;
      }
      i++; 
    }
    return -1; 
 }
