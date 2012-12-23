#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
main (int argc, char *argv[])
{
	int pid,ret,status,childPid;
	char *cmd[]= {"cat ","-b -v -t",argv[1], (char *)0};

	if (argc != 2)
	{
		printf("Usage: myfork [filename]\n");
		return 0;
	}
	
	if((pid = fork ()) == -1)
	{
		fprintf(stderr, "Fork error. Exiting \n");
		exit(1);
	}

	if (pid != 0) //Parent
	{
		childPid = wait(&status);
		printf ("Original Process ID: %d, Parent PID: %d, Process Group is: %d.\n",getpid (), getppid (),getgid());
	}
	else
	{
		printf ("In the CHILD process");		
		printf ("\nChild Process ID: %d, Parent PID: %d, Process Group is: %d.\n",getpid (), getppid (),getgid());
		//execl ("/bin/cat", "cat", "-bvt",argv[1], (char *)0); 
		execv("/bin/cat",cmd);
	}
	
	return 0;
}
