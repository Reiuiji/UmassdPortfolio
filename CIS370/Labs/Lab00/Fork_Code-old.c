/* Fork_Code.c
 * created by Daniel Noyes
 * Will Demonstrate the four various of fork in the bonus lab00
 */

//story should talk about a time machine, reverting the family tree a few times.

#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/mman.h>

pid_t child[6]; // the Family of A
/*
   child[i]
	0:B
	1:C
	2:D
	3:E
	4:F
	5:G
*/

int CPrint(char a, char *childtype);
pid_t ForkC();
//int FamilyReset();
int pidList();

int SixFork();
int FiveFork();
int FourFork();
int ThreeFork();

int main( int argc, char *argv[])
{
	
	if( argc!= 1)
	{
		printf("  Usage: Fork_Code \n");
		exit(1);
	}

	SixFork();
//	FamilyReset();
		FiveFork();
//		FamilyReset();
		FourFork();
//		FamilyReset();
	ThreeFork();
//		FamilyReset();

	return 0;
}

int SixFork()
{
printf("Time to make a family with 6 forks\n");
	char childtype = 'A';
	//B
	child[0] = ForkC();
	if(child[0] == 0) //New born child
	{
		CPrint('B',&childtype);
		exit(0);
	}
	wait(NULL);

	//C
	child[1] = ForkC();
	if(child[1] == 0) //New born child
	{
		CPrint('C',&childtype);
		//E
		child[3] = ForkC();
		if(child[3] == 0) //New born child
		{
			CPrint('E',&childtype);
			exit(0);
		}
		wait(NULL);

		//F
		child[4] = ForkC();
		if(child[4] == 0) //New born child
		{
			CPrint('F',&childtype);
			exit(0);
		}
		wait(NULL);
		exit(0);
	}

	//D
	child[2] = ForkC();
	if(child[2] == 0) //New born child
	{
		CPrint('D',&childtype);
		//G
		child[5] = ForkC();
		if(child[5] == 0) //New born child
		{
			CPrint('G',&childtype);
			exit(0);
		}
		wait(NULL);
		exit(0);
	}
	wait(NULL);

	return 0;
}

int FiveFork()
{
	printf("Time to make a family with 5 forks\n");
	char childtype = 'A';
	//B
	child[0] = ForkC();
	if(child[0] == 0) //New born child
	{
		CPrint('B',&childtype);
		exit(0);
	}
	wait(NULL);

	//C
	child[1] = ForkC();
	if(child[1] == 0) //New born child
	{
		CPrint('C',&childtype);
		//E
		child[3] = ForkC();
		if(child[3] == 0) //New born child
		{
			CPrint('E',&childtype);
			exit(0);
		}
	wait(NULL);
		//F
		goto FiveFork_1; // magically teleport F to pair with D for forking
	}
	wait(NULL);


	//D
	child[2] = ForkC();
	if(child[2] == 0) //New born child
	{
		CPrint('D',&childtype);
FiveFork_1: ; // for F to fork with D, goto setup
	    pid_t pid = ForkC();
	    if(pid == 0)
	    {
		    if(childtype == 'D')
		    {
			    child[5] = pid;
			    CPrint('G',&childtype);
		    }
		    else
		    {
			    child[4] = pid;
			    CPrint('F',&childtype);
		    }
		    exit(0);
	    }
	wait(NULL);
	    if(childtype == 'D')
	    {
		    child[5] = pid;
	    }
	    if(childtype == 'C')
	    {
		    child[4] = pid;
	    }

	    exit(0);
	}
	wait(NULL);
	return 0;
}

int FourFork()
{
	printf("Time to make a family with 4 forks\n");
	char childtype = 'A';
	pid_t pid;

	//C
	child[1] = ForkC();//Fork 1
	if(child[1] == 0) 
	{
		CPrint('C',&childtype);
		//E
		goto FourFork_1;
	}

	wait(NULL);
	//D
	child[2] = ForkC();//Fork 2
	if(child[2] == 0) 
	{
		CPrint('D',&childtype);
		goto FourFork_2;
	}

	wait(NULL);
	//B:0 and E:3
FourFork_1: ;
	    pid = ForkC();//Fork 3
	    if(pid == 0) 
	    {
		    if(childtype == 'A')
		    {
			    CPrint('B',&childtype);
		    }
		    if(childtype == 'C')
		    {
			    CPrint('E',&childtype);
		    }
		    exit(0);
	    }
	wait(NULL);
	    if(childtype == 'A')
	    {
		    child[0] = pid;
	    }

	    if(childtype == 'C')
	    {
FourFork_2: ;
	    pid = ForkC();//Fork 4
	    if(pid == 0)
	    {
		    if(childtype == 'D')
		    {
			    CPrint('G',&childtype);
		    }
		    if(childtype == 'C')
		    {
			    CPrint('F',&childtype);
		    }
		    exit(0);
	    }
	    else
	    {
		    if(childtype == 'D')
		    {
			    child[5] = pid;
		    }
		    if(childtype == 'C')
		    {
			    child[4] = pid;
		    }
	    }
	wait(NULL);
	    exit(0);
	    }

	wait(NULL);
	    return 0;
}

int ThreeFork()
{

	printf("Time to make a family with 3 forks\n");
	char childtype = 'A';
	pid_t pid;

	pid = ForkC();//Fork 1
	if(pid == 0) 
	{
		CPrint('C',&childtype);
	}

	pid = ForkC();//Fork 2
	if(pid == 0) 
	{
		if(childtype == 'A')
		{
			CPrint('D',&childtype);
		}
		else
		{
			CPrint('E',&childtype);
			exit(1);
		}
	}
	if(childtype == 'C')
	{
		wait(NULL);//wait for E
	}

	pid = ForkC();//Fork 3
	if(pid == 0) 
	{
		if(childtype == 'A')
		{
			CPrint('B',&childtype);
		}
		if(childtype == 'C')
		{
			CPrint('F',&childtype);
		}
		if(childtype == 'D')
		{
			CPrint('G',&childtype);
		}
		exit(1);
	}
	wait(NULL);//wait for B,F,G

	if(childtype != 'A') // kills all but A so only C and D
	{
		exit(1);
	}
	wait(NULL);//wait for C and D
	wait(NULL);

	return 0;
}




/* CPrint(char a)
   Lets go and name our new child
   */

int CPrint(char a, char *childtype)
{
	printf("[INFO]: Child(%c) Spawned New Child(%c: %d)\n",*childtype,a,getpid());
	*childtype = a;
	return 0;
}

/* pid_t ForkC()
   Lets for and create a new child
   Coitains the only fork
*/

pid_t ForkC()
{
	pid_t pid;

	if((pid = fork()) < 0)
	{
		perror("[Error]: Fork failure");
		exit(1);
	}
	return(pid);
}
/*
//you did not like how your family was formed, you found a magical bathtub and proceeded to travel back in time to rewrite your families history. On the bathtub it said "Please no time paradox, I dont want to repair the universe from you stupid mistakes - Doctor" you have no Idea who this doctor was but you proceeded without caution

int FamilyReset()
{
	int status;
	int i;
	struct timespec tim,tim2;
	tim.tv_sec = 0;
	tim.tv_nsec = 100000000L; // 1/10 of a second
	nanosleep(&tim,&tim2);
	pidList();
	for(i=0; i< 6 ; i++)
	{
		waitpid(child[i], &status, WUNTRACED);	//WUNTRACED: return if a child has  stopped
	}
	printf("Time Traveled back to the begining of the family\n\n");
	return 0;
}

int pidList()
{
	int i;
	printf("pid List: %d", getpid());
	for(i=0;i<6;i++)
	{
		printf(", %d",child[i]);
	}
	printf("\n");
	return 0;
}
*/
