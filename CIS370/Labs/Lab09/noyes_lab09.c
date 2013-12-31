/* pipes_4.c -- fourth pipe example */
#include<unistd.h>
#include<stdio.h>
#include<stdlib.h>

#define MSGSIZE 16


int main()
{
	char inbuf[MSGSIZE], msgbuf[MSGSIZE], Message[MSGSIZE] = {0};

	int p[4][2],i,child;
	pid_t pid;

	/* open pipe */
	for(i=0; i<4; i++)
	{
		if(pipe(p[i]) == -1)
		{
			perror("pipe call");
			exit(1);
		}
	}
	//Spawn Child 1,2,3
	for(child = 0; child< 3; child++)
	{
		switch(pid = fork())
		{
			case -1:
				perror("Fork Failure");
				exit(2);

			case 0:

				//build the child part of the structure for the assignment
				//closes all the other pipes to write to
				for (i = 0; i < 4; i++)
				{
					if (!(child == 1 && i == 2) && !(child == 2 && i == 3)) // child 2 needs to write to P3 and child 3 needs to write to P4
						close(p[i][1]);
				}
				//closes all the other pipes to read to
				for (i = 0; i < 4; i++)
				{
					if (!(child == 0 && i == 0) && // child 1 need to read from P1
					!(child == 1 && (i == 1 || i == 3)) && // child 2 need to read from P2 & P4
					!(child == 2 && (i == 1 || i == 2)) // child 3 need to read from P2 & P3
					) 
						close(p[i][0]);
				}


				if(child==0)//child 1
				{
					while(read(p[0][0],inbuf,MSGSIZE) > 0)
					{
						sprintf(msgbuf, " %s", inbuf);
						strcat(Message, msgbuf);
					}
					printf("- Child %i read:%s.",child+1,Message);
				}

				if(child==1)//child 2
				{
					while(read(p[1][0],inbuf,MSGSIZE) > 0)
					{
						if(inbuf[0] == '!')
						{
							//shift inbuf contents over by 1 so the special char is removed
							for(i = 1; i < MSGSIZE; i++)
							{
								inbuf[i-1] = inbuf[i];
							}
							sprintf(msgbuf, " %s", inbuf);
							strcat(Message, msgbuf);
						}
						else
						{
							printf("   * Forwaring Message along Pipe P3.\n");
							//shift inbuf contents over by 1 so the special char is removed
							for(i = 1; i < MSGSIZE; i++)
							{
								inbuf[i-1] = inbuf[i];
							}

							write(p[2][1],inbuf,MSGSIZE); //C2 -> P3 -> C3
						}
					}
					close(p[2][1]);


					while(read(p[3][0],inbuf,MSGSIZE) > 0)
					{
						sprintf(msgbuf, " %s", inbuf);
						strcat(Message, msgbuf);
					}

					printf("- Child %i read:%s.",child+1,Message);
				}

				if(child==2)//child 3
				{
					while(read(p[1][0],inbuf,MSGSIZE) > 0)
					{
						if(inbuf[0] == '~')
						{
							//shift inbuf contents over by 1 so the special char is removed
							for(i = 1; i < MSGSIZE; i++)
							{
								inbuf[i-1] = inbuf[i];
							}
							sprintf(msgbuf, " %s", inbuf);
							strcat(Message, msgbuf);
						}
						else
						{
							printf("   * Forwaring Message along Pipe P4.\n");
							//shift inbuf contents over by 1 so the special char is removed
							for(i = 1; i < MSGSIZE; i++)
							{
								inbuf[i-1] = inbuf[i];
							}
							write(p[3][1],inbuf,MSGSIZE); //C3 -> P4 -> C2
						}
					}
					close(p[3][1]);

					while(read(p[2][0],inbuf,MSGSIZE) > 0)
					{
						sprintf(msgbuf, " %s", inbuf);
						strcat(Message, msgbuf);
					}

					printf("- Child %i read:%s.",child+1,Message);
				}
				printf(" C%i exiting...\n",child+1);
				exit(0);
		}
	}

//setup the parent structure
//closes every read pipe
for(i=0;i<4;i++)
{
    close(p[i][0]);
}

//remove write pipes with P3 and P4
close(p[2][1]);//P3
close(p[3][1]);//P4



	//parent user access:
	int msgnum = 0,Child;
	printf("- Hello, I am the parent. How many Messages should I send? ");
	scanf("%i",&msgnum);


	for(i = 0; i < msgnum; i++)
	{

		printf("- Message %i (<msg> <child>): ",i+1);
		scanf("%s",Message);
		scanf("%i",&Child);

		//printf("[DEBUG]:%i,%s\n",Child,Message);


		switch(Child)
		{
			case 1:
				printf("   + Sent Message along Pipe P1.\n");

				write(p[0][1],Message,MSGSIZE);

				break;
			case 2:
				printf("   + Sent Message along Pipe P2.\n");
				sprintf(msgbuf,"!%s",Message);//! means send to P2
				write(p[1][1],msgbuf,MSGSIZE);

				break;
			case 3:
				printf("   + Sent Message along Pipe P2.\n");
				sprintf(msgbuf,"~%s",Message);//~ means send to P3
				write(p[1][1],msgbuf,MSGSIZE);

				//printf("   * Forwaring Message along Pipe P3.\n");


				break;

		}
		sleep(1);//to prevent the child from printing out information while the promt is there
	}

//closes the remaining pipes for the parent
close(p[0][1]);//P1
close(p[1][1]);//P2

	//printf("- Waiting for childs to die\n");
	//wait for all childs to die off
	for(i = 0 ; i< 2; i++)
	{
		wait(NULL);
	}
	printf("- Parent exiting...\n");
	return(0);
}


