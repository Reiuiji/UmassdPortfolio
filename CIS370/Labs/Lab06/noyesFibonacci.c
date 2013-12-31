/*
 * Daniel Noyes
 * noyesFibonacci.c
 * Lab 6
 *
 * Modified from basicthread.c (c) J.Plante
 */

#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/syscall.h>
#define maxBuff 256
int FibonacciNum[maxBuff]; /* this data is shared by the thread(s) */
void *Fibonacci(void *param); // Fibonacci thread
 int info(int arg);


int main(int argc, char *argv[])
{
	int i;
	pthread_t tid; /* the thread identifier */
	pthread_attr_t attr; /* set of thread attributes */

	if (argc != 2) {
		fprintf(stderr,"usage: a.out <integer value>\n");
		return -1;
	}
	if (atoi(argv[1]) < 0) {
		fprintf(stderr,"%d must be >= 0\n",atoi(argv[1]));
		return -1;
	}

	/* get the default attributes */
	pthread_attr_init(&attr);
	/* create the thread Fibonacci*/
	pthread_create(&tid,&attr,Fibonacci,argv[1]);
	/* wait for the thread to exit */
	pthread_join(tid,NULL);

	printf("Fibonacci Number = %i",FibonacciNum[0]);
	for(i = 1 ; i < atoi(argv[1]) ; i++)
	{
		printf(", %i",FibonacciNum[i]);
	}
	printf("\n");

	info(1);
	return 0;
}


/*This thread is degined to calculate the Fibonacci of a set of intergers */
void *Fibonacci(void *param)
{
	int i, upper = atoi(param);
	int Fib[3] = {0,1,0};

	for(i = 1; i < upper; i++)
	{

		Fib[0] = Fib[1] + Fib[2];
		Fib[1] = Fib[2];
		Fib[2] = Fib[0];
		FibonacciNum[i] = Fib[0];
	}
        info(0);
	pthread_exit(0);
}

int info(int arg)
{
 	pid_t tid;
	tid = syscall(SYS_gettid); 
	printf("[Info] ");
	if(arg == 0)
		printf("Child Thread  ");
	else
		printf("Parent Thread ");
	printf("[TID:%i|PID %d] Exiting\n",tid,getpid()); 
        return 0;
}

