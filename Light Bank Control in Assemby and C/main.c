/*
 * Filename: main.c
 * Author: Anish Narsian
 * Description: Calls functions written in assembly and C.
 * Date: Oct. 30, 2013
 * Sources of Help: Piazza
 */

#include "header.h"
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
/*
 * Function name: main()
 * Function prototype: int main( int argc, char *argv[] )
 * Descriptions: This is the main program, it calls everything else
 * Parameters:
 *	     arg1: argc -- the number of args
 *	     arg2: char *argv[] -- array of args
 * Side effects: None
 * Error conditions: Many, returns error for wrong input and so on
 * Return value: 0 for succesful execution
 */

FILE *stdError = stderr;
int
main (int argc, char* argv[])
{
  (void) setvbuf(stdout, NULL, _IONBF, 0);
  if( argc > 2 )
  {
    (void) printf( "\n\tUsage: %s [filename] \n\n", argv[0]);
    return(0);
  }

 unsigned int lightBank[NUM_OF_BANKS];
    char *comStr;
  char *str1;
  char *str2;

  FILE *inFile = stdin;

  char buf[BUFSIZ];
  int index;
  const char *commands[] = {COMMANDS, NULL};


  long lightBank1, lightBank2;



  //Boolean vals. 
  //Promp and errFlags
  int prompt = TRUE;
  int errFlag = FALSE;
  int endLoop = FALSE;


  if (argc == 2)
  {
    inFile = fopen( argv[1], "r" );
    prompt = FALSE;
    if( inFile == NULL )
    {
      return(0);
    }
  }



//Display the lights now
  displayLights(lightBank);


  //Big outer For loop
  for( DISPLAY_PROMPT; fgets(buf, BUFSIZ, inFile ) != NULL; DISPLAY_PROMPT )
  {
    comStr = strtok(buf, TOKEN_SEPARATORS);
    if (comStr == NULL)
      continue;

    errFlag = FALSE;
    endLoop = FALSE;   //Set err flag to false


    str1 = strtok(NULL, TOKEN_SEPARATORS);
    str2 = strtok(NULL, TOKEN_SEPARATORS);

    //Check the command to that in file
    index = checkCmd (comStr, commands);

    //Switch statements
    switch (index)
    {
      case -1:	/* If index -1 then is a bad command */
        (void) printf( "\n\tBad command. "
			  "Type \"help\" for more info.\n\n" );
	  endLoop = TRUE;
         break;


      case 6:		/* If index is 6 then show help */
        (void) printf("The available commands are:\n"
                      "\tset bank0BitPattern bank1BitPattern\n"
                      "\tclear bank0BitPattern bank1BitPattern\n"
                      "\ttoggle bank0BitPattern bank1BitPattern\n"
                      "\tshift shiftCount\n"
                      "\trotate rotateCount\n"
                      "\tripple rippleCount\n"
                      "\thelp\n"
                      "\tquit\n");
	  endLoop = TRUE;
         break;


 
      case 7:		/* If index = 7 then quit */
	  endLoop = TRUE;
         return 0;
    }
    /* If there is no error and str1 is not null then convert */
    if (endLoop == FALSE && str1 != NULL) 
    {
      lightBank1 = strToULong(str1, BASE);
      if ( errno != 0)
        errFlag = TRUE;
    }




    if (errFlag == FALSE && endLoop == FALSE)
    {
      switch (index)
      {
        case 3:	/* If index = 3 then shift */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
          shift (lightBank, lightBank1);
          displayLights(lightBank);
	   endLoop = TRUE;
          break;

        case 4:	/* If index = 4 then rotate */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
          rotate (lightBank, lightBank1);
          displayLights(lightBank);
	   endLoop = TRUE;
          break;

        case 5:	/* If index = 5 then ripple */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
          ripple (lightBank, lightBank1);
	   endLoop = TRUE;
          break;
       }
    }








    /* If there is no error and str2 is not null then convert */
    if (endLoop == FALSE && str2 != NULL && errFlag == FALSE)
    {
      lightBank2 = strToULong(str2, BASE);
      if (errno != 0)
        errFlag = TRUE;
    }
    if (errFlag == FALSE && endLoop == FALSE)
    {
      switch (index)
      {
        case 0: 	/* If index = 0 then set */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
    	   if ( str2 == NULL)
          {
            (void) printf( "\n\tA 2nd argument is required for this command.\n\n");
	      break;
          }
          set (lightBank, lightBank1, lightBank2);
          displayLights(lightBank);
	   endLoop = TRUE;
          break;

        case 1:	/* If index = 1 then clear */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
    	   if ( str2 == NULL)
          {
            (void) printf( "\n\tA 2nd argument is required for this command.\n\n");
	      break;
          }

	   //displayLights(lightbank1)
          clear (lightBank, lightBank1, lightBank2);
          displayLights(lightBank);
	   endLoop = TRUE;
          break;

        case 2:	/* If index = 2 then togle */
    	   if ( str1 == NULL)
          {
            (void) printf( "\n\tArgument(s) required for this command. "
                           "Type \"help\" for more info.\n\n");
	      break;
          }
    	   if ( str2 == NULL)
          {
            (void) printf( "\n\tA 2nd argument is required for this command.\n\n");
	      break;
          }
          toggle (lightBank, lightBank1, lightBank2);
	   displayLights(lightBank);
	   endLoop = TRUE;
          break;
       }
    }
  }
  return(0);
}
