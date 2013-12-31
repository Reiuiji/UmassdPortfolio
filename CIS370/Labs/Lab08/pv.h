/* pv.h -- semaphore example header file */
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <errno.h>

#define SEMPERM  0600
#define TRUE	 	1
#define FALSE    	0

typedef union _semun {
	int val;
	struct semid_ds *buf;
	ushort *array;
} semun;

/* Create and initialize a semaphore with a value of 1 */
int initsem(key_t semkey);

/* Semaphore wait() procedure */
int wait(int semid);

/* Semaphore signal() procedure */
int signal(int semid);
