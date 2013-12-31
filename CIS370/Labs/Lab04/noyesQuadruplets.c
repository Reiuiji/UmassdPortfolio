/* noyesQuadruplets.c
 * created by Daniel Noyes
 * spawn 4 child process and each will sleep(5) till all the childs are created
 */

#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <stdio.h>

int birth();

int main( int argc, char *argv[])
{
	pid_t child[4];
	int status;

	if( argc!= 1)
	{
		printf("  Usage: noyesQuadruplets \n");
		exit(1);
	}

	child[0] = birth();
	child[1] = birth();
	child[2] = birth();
	child[3] = birth();

	waitpid(child[0], &status, WUNTRACED);	//WUNTRACED: return if a child has  stopped
	waitpid(child[1], &status, WUNTRACED);
	waitpid(child[2], &status, WUNTRACED);
	waitpid(child[3], &status, WUNTRACED);

	printf("[INFO]: ParentPID: %d\n", getpid());

	return 0;
}

/*  The Book of Life: birth ()

	The Spell has been passed down from the ages. The page has some manatee tares that you can barely read the entire enchant. Unknown to you there is a darkness behind you waiting for you to make a mistake and destroy everything around you.

	You give it a try even with the uncertainly, you say it out loud and the ground around you shakes. You see right in front of you a small child, this child came out of the ground. You were preplexed wondering where this child came from. It looks at you with an aww and you go near it and touch it and the child turned to flesh and rotted away.

	You were Shocked when you see this and tried 3 more variations of the spell but in the end each one you spawn just fall's apart.

*/

pid_t birth()
{
	pid_t pid;

	if((pid = fork()) < 0)
	{
		perror("[Error]: Spell Failed (Fork failure)");
		exit(1);
	}

	if(pid == 0) //New born child
	{
		printf("[INFO]: New Spawned Child(PID): %d\n",getpid());
		sleep(5);
		exit(0);
	}
	else //Spell wielder
	{
		return(pid);
	}
}
