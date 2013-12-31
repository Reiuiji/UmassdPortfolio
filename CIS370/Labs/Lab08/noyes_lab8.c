/********************************************************************
 *  Lab 8 Template
 *
 *  Your assignment in this lab is to implement a Semaphore solution
 *  to the critical section problem presented in the template.
 *******************************************************************/

/* Include the necessary header files */
#include <pthread.h>

#include "noyes_pv.c"


#define NUMBER 1000000

void *ThreadAdd(void *a);		// Function prototype.

int critical_value; 			// Variable shared between all threads.
int semid;						//semaphore ID

int main()
{
	// INITIALIZE SEMAPHORE -- TO BE COMPLETED BY YOU
	key_t semkey;
	semkey = ftok("/tmp", 't');	//set la Key
	semid = initsem(semkey);	//initilize the semaphore

	pthread_t tid_t1;			// Thread 1
	pthread_t tid_t2;			// Thread 2

	pthread_create(&tid_t1, NULL, ThreadAdd, NULL);
	pthread_create(&tid_t2, NULL, ThreadAdd, NULL);

	pthread_join(tid_t1, NULL);
	pthread_join(tid_t2, NULL);

	printf("Both Threads have returned.  Value = %d\n", critical_value);

	// REMOVE SEMAPHORE -- TO BE COMPLETED BY YOU
	semctl(semid, 0, IPC_RMID);

	return 0;
}

/*
One Day while doing some work in the library, you notice a group a fairies fighting over across the hall. You proceeded to walk over and ask them why they were fighting. It turns out that both of them were editing records in the library and both messed each other up and all their work went in vain. They look at you like lost children waiting for guidance. You conjored up a white board of every fairy and told them "In order to change any record you must inform the others by the white board. That way we all can work together in improving the records".

As time went the books you read keep helping with life...

*/

/* This function should allow a thread to increment the critical_value by 1,000,000 */
void *ThreadAdd(void *a)
{
    int i, tmp;

    /* Critical Section -- Only one thread should access this at a time! */
	wait(semid);

    for(i = 0; i < NUMBER; i++)
    {
        tmp = critical_value;     	/* Copy the global count locally */
	 	tmp = tmp+1;       			/* Increment the local copy */
        critical_value = tmp;   	/* Store the local value into the global count */
    }

	signal(semid);
    pthread_exit(0);
}
