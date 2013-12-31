/* first pipe example */
#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>

/* this figure includes terminating null */
#define MSGSIZE 16

char *msg1 = "Hello, World #1";
char *msg2 = "Hello, World #2";
char *msg3 = "Hello, World #3";

main()
{
 char inbuf[MSGSIZE];
 int p[2], j;

 /* open pipe */
 if(pipe(p) == -1)
 {
   perror("pipe call");
   exit(1);
 }

 /* write down pipe */
 write(p[1],msg1,MSGSIZE);
 write(p[1],msg2,MSGSIZE);
 write(p[1],msg3,MSGSIZE);

 /* read from pipe */
 for(j = 0; j < 3; j++)
 {
   read(p[0],inbuf,MSGSIZE);
   printf("%s\n",inbuf);
 }

 exit(0);
}