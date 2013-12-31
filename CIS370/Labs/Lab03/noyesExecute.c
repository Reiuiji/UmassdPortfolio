/* noyesExecute.c
 * created by Daniel Noyes
 * catnate funciton for CIS370
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
int main (int argc, char *argv[])
{
	pid_t pid;
	int status, exec_status;
	if (argc != 3)
	{
		printf("Usage: noyesExecute <file1> <file2>\n");
		return 0;
	}
	if((pid = fork()) < 0)
	{
		perror("[Error]: Fork failed");
		exit(1);
	}
		
	if(pid == 0) //child
	{
	printf("Beginning execution of sampleCP.\n");
	exec_status = execl("./sampleCP","sampleCP",argv[1],argv[2],(char *)0);
	//printf("[Info] exec status %i\n",exec_status);
	exit(exec_status);
}
	else //parent
	{
		waitpid(pid, &status, WUNTRACED);
		//printf("[Info] exit status %i\n",WEXITSTATUS(status));
if(WEXITSTATUS(status) == 0)
{
	printf("%s successfully copied to %s  [Exiting]\n", argv[1], argv[2]);
}
else
{
	printf("[Error]: copy failed!\n");
}
}
	return 0;
}
