#include<sys/time.h>
#include<sys/wait.h>
#include<stdio.h>
#include<stdlib.h>

#define MSGSIZE 6

char *msg1 = "hello";
char *msg2 = "bye";

void parent(int [][2]);
int child(int []);

main()
{
	int pip[3][2];
	int i;

	/* creates three communication pipes and spawn three children */
	for(i=0;i<3;i++)
	{
		if(pipe(pip[i])==-1)
			printf("pipe call");

		switch(fork())
		{
			case -1:
				printf("fork call");
			case 0: /* child */
				child(pip[i]);
		}
	}
	parent(pip);

	exit(0);
}

/* parent sits listening on all three pipes */
void parent(int p[3][2])
{
	char buf[MSGSIZE],ch;
	fd_set set,master;
	int i;

	/* close all unwanted write file descriptors */
	for(i=0;i<3;i++)
		close(p[i][1]);

	/* set the bit masks for the select system call */
	FD_ZERO(&master);
	FD_SET(0,&master);

	for(i=0;i<3;i++)
		FD_SET(p[i][0],&master);

	/* select is called with no timeout
	 * it will block until an event occurs */
	while(set = master,select(p[2][0]+1,&set,NULL,NULL,NULL) > 0)
	{  /* we musn't forget information on standard input, i.e fd =0 */
		if(FD_ISSET(0,&set))
		{
			printf("From standard input..");
			read(0,&ch,1);
			printf("%c\n",ch);
		}

		for(i=0;i<3;i++)
		{
			if(FD_ISSET(p[i][0],&set))
			{
				if(read(p[i][0],buf,MSGSIZE)>0)
				{
					printf("Message from child%d\n",i);
					printf("MSG=%s\n",buf);
				}
			}
		}

		/* The server will return to the main program if all its children have died */

		if(waitpid(-1,NULL,WNOHANG)==-1)
			return;
	}
}

int child(int p[2])
{
	int count;

	close(p[0]);

	for(count=0;count<2;count++)
	{
		write(p[1],msg1,MSGSIZE);
		/* pause for a random amount of time */
		sleep(getpid() % 4);
	}

	/* send final message */
	write(p[1],msg2,MSGSIZE);
	exit(0);
}