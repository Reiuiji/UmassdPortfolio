/* O_NONBLOCK example */
#include<fcntl.h>
#include<errno.h>
#include<stdio.h>
#include<stdlib.h>

#define MSGSIZE 6

int parent(int *);
int child(int *);

char *msg1 = "hello";
char *msg2 = "bye";

main()
{
	int pfd[2];

	/* open pipe */
	if(pipe(pfd)==-1)
		printf("pipe call");

	/* set 0_NONBLOCK flag for p[0] */
	if(fcntl(pfd[0],F_SETFL,O_NONBLOCK)==-1)
		printf("fcntl call");

	switch(fork())
	{
		case -1:
	        printf("fork call");
		case 0:
	       child(pfd);
		default:
		 	parent(pfd);
 	}
}

int parent(int p[2]) /* code for parent */
{
	int nread;
	char buf[MSGSIZE];

	close(p[1]);

	for(;;)
	{
		switch(nread = read(p[0],buf,MSGSIZE))
		{
     		case -1:
         		/* check to see if nothing is in pipe */
         		if(errno == EAGAIN)
	 			{
					printf("pipe empty\n");
					sleep(1);
					break;
				}
				else
  	 				printf("read call");
			case 0:
				/* pipe has been closed */
    			printf("End of conversation\n");
				exit(0);
			default:
				printf("MSG=%s\n",buf);
		}
	}
}

int child(int p[2])
{
	int count;

	close(p[0]);

	for(count=0;count<3;count++)
	{
		write(p[1],msg1,MSGSIZE);
		sleep(3);
	}

 	/* send final message */
	write(p[1],msg2,MSGSIZE);
	exit(0);
}