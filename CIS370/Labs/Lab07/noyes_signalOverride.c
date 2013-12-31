/*******************************************************************************************************
*	Lab 07 - Part 1
*	lastname_signalOverride.c
*
*	This program will continuously print out messages every 5 seconds until interrupted by a signal.
*
*	You will need to add functionality to handle signals as follows:
*	1. When the user presses (<ctrl> + c) the program should ignore it and SHOULD NOT EXIT.
*   2. When the user presses (<ctrl> + \) (SIGQUIT) the program should print out a message and exit.
*******************************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

void catchQUIT(int signo);		//Function prototype for handling SIGQUIT


/* Main() */
int main(int argc, char *argv[])
{
    long estimated_time_running = 0;

    static struct sigaction act,act2;

    // 1. Ignore (<ctrl> + c) -- To be completed by you
    act.sa_handler = SIG_IGN;;
    sigemptyset(&(act.sa_mask));
    sigaddset(&(act.sa_mask), SIGINT);
    sigaction(SIGINT, &act, NULL);

    // 2. Handle (<ctrl> + \) -- To be completed by you
    act2.sa_handler = catchQUIT;
    sigfillset(&(act2.sa_mask));
    sigdelset(&(act2.sa_mask), SIGINT);
    sigaction(SIGQUIT,&act2,NULL);



    /* Prints a message roughly once every 5 seconds */
    while(1)
    {
        printf("Hey! I've been running happily for about %ld seconds! I sure hope no signals mess up my execution flow!\n", estimated_time_running);
        estimated_time_running += 5;
        sleep(5);
    }

    return 0;
}


/* Trivial Function to handle SIQUIT */
void catchQUIT(int signo)
{
    printf("\nYou hit <ctrl> + \\, sending me a SIGQUIT signal.  Exiting. \n");
    exit(0);
}
