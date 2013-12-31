/* join -- join two commands by pipe*/
#include<stdio.h>
#include<stdlib.h>

int join(char *com1[], char *com2[])
{
	int p[2], status;

	/*create child to run commands*/
	switch(fork())
	{
		case -1:      /*error*/
			perror("1st fork call in join");
		case 0 :      /*child*/
			break;
		default: /*parent*/
			wait(&status);
			return(status);
	}

	/* remainder of routine executed by child */

	/* make pipe */
	if(pipe(p) == -1)
		perror("pipe call in join");

	/* create another process  */
	switch(fork())
	{
		case -1:
			/*error*/
			perror("2nd fork call in join");

		case 0:
			/* the writing process*/
			dup2(p[1],1); /* make std. output go to pipe */

			close(p[0]);
			close(p[1]);   /*save file descriptor */

			execvp(com1[0],com1);

			/*  if execvp returns error has occurred*/
			perror("1st execvp call in join");

		default:
			/* the reading process*/
			dup2(p[0],0);  /* make std. input come from pipe */

			close(p[0]);
			close(p[1]);

			execvp(com2[0],com2);
			perror("2nd execvp call in join");
	}
}


main()
{
	char *one[4] = {"ls", "-l", "/usr/lib", NULL};
	char *two[3] = {"grep", "^d", NULL};
	int ret;

	ret = join(one, two);
	printf("join returned %d\n",ret);
	exit(0);
}
