/*
 * Daniel Noyes
 * noyesProdigies.c
 * Lab 6
 *
 * Modified from basicthread.c (c) J.Plante
 */

#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <math.h>
#define maxBuff 256
int FibonacciNum[maxBuff]; /* this data is shared by the thread(s) */
void *sum(void *param); //sum thread
void *product(void *param); //product thread
void *sumsqr(void *param); //sum of squares thread
int info(int arg);
int sumn, productn, sumsqrn, Val[3];

int main(int argc, char *argv[])
{
	
	pthread_t tid[3]; /* the thread identifier */
	pthread_attr_t attr; /* set of thread attributes */

	if (argc != 4) {
		fprintf(stderr,"usage: noyesProdigies <num1> <num2> <num3>\n");
		return -1;
	}
 
        Val[0] = atoi(argv[1]);
	Val[1] = atoi(argv[2]);
	Val[2] = atoi(argv[3]);
	
	/* get the default attributes */
	pthread_attr_init(&attr);

	/* create the thread: Sum*/
	pthread_create(&tid[0],&attr,sum,Val);
        /* create the thread: product*/
	pthread_create(&tid[1],&attr,product,Val);
        /* create the thread: sumsqr*/
	pthread_create(&tid[2],&attr,sumsqr,Val);

	/* wait for the thread sum to exit */
	pthread_join(tid[0],NULL);
	/* wait for the thread product to exit */
	pthread_join(tid[1],NULL);
	/* wait for the thread sumsqr to exit */
	pthread_join(tid[2],NULL);

//output what the threads calculated
 printf("\nThe Sum of the 3 int: %i\n",sumn);
 printf("The Product of the 3 int: %i\n", productn);
 printf("The sum of square of the 3 int: %i\n",sumsqrn);
	printf("\n");

	info(1);
	return 0;
}
/* As you were reading, you felt like something was watching you. Everytime you looked, there was nothing there. The next second you see a little flying mysterious creature just playing with the book you were reading. In your mind you mumur that you read about these trickster spirits. They were called fairies and If you befriend them, you might learn more about them.

	After a few minutes you found out that the fairy can talk and the entire night you two were talking about each others lives. After the conversation she told you she had friends and would like to help with your studies. The fairy wispered and out comes faries from around the entire room. There were 20 just curious and observing your every movement. The fairy you were talking to proceeded to talk in a language u never heard of then all of them came down and asked what work they can do to help.

	You then proceeded to write a todo list and everyone worked together and you learned that teamwork makes life easier.
 */

/*This thread is degined to calculate the factorial of a set of intergers */
void *sum(void *param)
{
	printf("[Info] T1:[TID:%i|PID %d] Created\n",syscall(SYS_gettid),getpid());
	sumn = Val[0] + Val[1] + Val[2];
        info(0);
	pthread_exit(0);
}
/*This thread is degined to calculate the factorial of a set of intergers */
void *product(void *param)
{
	printf("[Info] T2:[TID:%i|PID %d] Created\n",syscall(SYS_gettid),getpid());
	productn = Val[0] * Val[1] * Val[2];
        info(0);
	pthread_exit(0);
}
/*This thread is degined to calculate the factorial of a set of intergers */
void *sumsqr(void *param)
{
	printf("[Info] T3:[TID:%i|PID %d] Created\n",syscall(SYS_gettid),getpid());
	sumsqrn = pow(Val[0],2) + pow(Val[1],2) + pow(Val[2],2);
        info(0);
	pthread_exit(0);
}

int info(int arg)
{
 	pid_t tid;
	tid = syscall(SYS_gettid); 

	if(arg == 0)
		printf("[Info] Child Thread  [TID:%i|PID %d] Finished\n",tid,getpid()); 
	else
		printf("[Info] Parent Thread [TID:%i|PID %d] Exiting\n",tid,getpid()); 

        return 0;
}

