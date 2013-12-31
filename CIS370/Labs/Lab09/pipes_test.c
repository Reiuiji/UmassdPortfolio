/* pipes_4.c -- fourth pipe example */
#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>

#define MSGSIZE 16


main()
{
 char inbuf[MSGSIZE], msg[MSGSIZE];
 int p[2][2], j;
 pid_t pid;

 /* open pipe */
 if(pipe(p[0]) == -1)
 {
   perror("pipe call");
   exit(1);
 }

 switch(pid = fork())
 {
	case -1:
		perror("Fork Failure");
		exit(2);

	case 0:
		/* if child, close read file, 
		 * then write down pipe,
		 * then close write file.
		 */
		printf("- Message: ");
		scanf("%s",msg);
		close(p[0][0]);
		write(p[0][1],msg,MSGSIZE);	
		close(p[0][1]);
		break;

	default:
		/* if parent, close write file,
		 * then read from pipe until
		 * pipe is empty.
		 */
		close(p[0][1]);
		while(read(p[0][0],inbuf,MSGSIZE) != 0)
			printf("%s\n",inbuf);
		
		wait(NULL);
 }

 exit(0);
}

