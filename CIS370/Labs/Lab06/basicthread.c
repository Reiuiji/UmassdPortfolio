/********************************************************************
 *  basicthread.c
 *
 *  This code showcases basic thread functionalities including:
 *    - Creation
 *    - Termination
 *    - Joining
 *    - Shared variables
 *******************************************************************/

/* Include the necessary header files */
#include<stdio.h>
#include<sys/types.h>
#include<pthread.h>

void *Runner(void *arg); 	// Function prototype

int shared_value;		// Variable shared by all Threads

int main()
{
	pthread_t tid;

	shared_value = 0;

	/* Creates a new Thread */
	pthread_create(&tid, NULL, Runner, NULL);

	/* Parent Thread waits for Child Thread to terminate */
	pthread_join(tid, NULL);

	shared_value += 10;
	printf("Parent Thread: Value = %d\n", shared_value);

	return 0;
}

/* Thread initialization function */
void *Runner(void *arg)
{
	shared_value += 5;
	printf("Child Thread: Value = %d\n", shared_value);

	/* Terminate Child Thread */
	pthread_exit(0);
}
