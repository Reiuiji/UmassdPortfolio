/* noyesTriplets.c
 * created by Daniel Noyes
 * spawn three child and perform sum, product, and sum of squares funciton for CIS370
 */

#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int spawn(int act, int Val[3]);

int main( int argc, char *argv[])
{
		
	if( argc!= 4)
	{
		printf("  Usage: noyesTriplets <num1> <num2> <num3>\n");
		exit(1);
	}

	int Val[3] = {atoi(argv[1]), atoi(argv[2]), atoi(argv[3])};

	spawn(1,Val);
	spawn(2,Val);
	spawn(3,Val);
	
	printf("[INFO]: ParentPID: %d\n", getpid());

	return 0;
}

/*  spawn (int act, int Val[3])
	int act: select which function for the child to perform
		1: sum
		2: product
		3: sum of squares
	int Val[3]: values user input for the child to use.

*/

int spawn(int act,int Val[3])
{
	pid_t pid;
	int child_value;
	int status;
	if((pid = fork()) < 0)
	{
		perror("[Error]: Fork failed");
		exit(1);
	}
		
	if(pid == 0) //child
	{
		printf("[INFO]: ChildPID: %d\n",getpid());

		switch(act) //select which function the child would perform based on the act interger
		{
			case 1:
			child_value = Val[0] + Val[1] + Val[2];
		printf("The Sum of the 3 int: %i\n",child_value);
			break;
			case 2:
			child_value = Val[0] * Val[1] * Val[2];
		printf("The product of the 3 int: %i\n",child_value);
			break;
			case 3:
			child_value = pow(Val[0],2) + pow(Val[1],2) + pow(Val[2],2);
		printf("The sum of the squares of 3 int: %i\n",child_value);
			break;
			default:
			exit(-1);
			break;
		}
		printf("\n");
		exit(0);
	}
	else //parent
	{
		waitpid(pid, &status, WUNTRACED);
		return(0);

	}
	
}
