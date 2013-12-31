/** pv_template.c -- Implementations of initsem(), wait(), and signal() **/

#include "pv.h"


/* Create and initialize a semaphore with a value of 1 */
int initsem(key_t semkey)
{
	int semid;
	int status = 0;

	/* Creates a semaphore set containing a single semaphore */
	if((semid = semget(semkey, 1, SEMPERM|IPC_CREAT|IPC_EXCL)) == -1)
	{
		if(errno == EEXIST)
			semid = semget(semkey, 1, 0);
	}
	else
	{
		semun arg;
		arg.val = 1;

		/* Sets the semval parameter of the semaphore to 1 */
		status = semctl(semid, 0, SETVAL, arg);
	}

	if(semid == -1 || status == -1)
	{
		perror("initsem failed");
		return -1;
	}

	/* All okay */
	return(semid);
}

/* Semaphore wait() procedure */
int wait(int semid)
{
	struct sembuf p_buf;

	// TO BE COMPLETED BY YOU
	// 1. Set p_buf parameter values

	p_buf.sem_num = 0;
	p_buf.sem_op = -1;
	p_buf.sem_flg = SEM_UNDO;

	// 2. Use p_buf to implement the appropriate semaphore operation

	if( semop(semid, &p_buf, 1) == -1 )
	{
		printf("[Error]: count not semop|wait()\n");
	}
	return 0;
}

/* Semaphore signal() procedure */
int signal(int semid)
{
	struct sembuf v_buf;

	// TO BE COMPLETED BY YOU
	// 1. Set v_buf parameter values
	v_buf.sem_num = 0;
	v_buf.sem_op = 1;
	v_buf.sem_flg = SEM_UNDO;

	// 2. Use v_buf to implement the appropriate semaphore operation

	if( semop(semid, &v_buf, 1) == -1 )
	{
		printf("[Error]: count not semop|signal()\n");
	}

	return 0;
}
