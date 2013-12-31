/* noyesFibonacci.c
 * created by Daniel Noyes
 * catnate funciton for CIS370
 */

#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>

int main( int argc, char *argv[])
{
	int Fib[3] = {0,1,0};// [main][holder_1]{holder_2]
	int max,i;
	pid_t pid;
	int status;
	//int i;
	
	if( argc!= 2)
	{
		printf("  Usage: dnoyesFibonacci <seq_num>\n");
		exit(1);
	}
	max=atoi(argv[1]);
	if(max < 0)
	{
		printf("[Error]: please insert a non-negative number\n");
		exit(-1);
	}

	if((pid = fork()) < 0)
	{
		perror("[Error]: Fork failed");
		exit(1);
	}
		
	if(pid == 0) //child
	{
		printf("[INFO]: ChildPID: %d\n",getpid());
		printf("%i ",Fib[0]);
		for(i = 1; i < max; i++)
		{

			Fib[0] = Fib[1] + Fib[2];
			Fib[1] = Fib[2];
			Fib[2] = Fib[0];
			printf(", %i ",Fib[0]);
		}
		printf("\n");
		exit(0);
	}
	else //parent
	{
		waitpid(pid, &status, WUNTRACED);
		printf("[INFO]: ParentPID: %d\n", getpid());

	}

	return 0;
}
