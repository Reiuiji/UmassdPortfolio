/* client process */

/* include the necessary header files */
#include<ctype.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>

#define SIZE sizeof(struct sockaddr_in)

main()
{
	int sockfd;
	char c;

	/* the local port on the client */
	struct sockaddr_in client = {AF_INET,INADDR_ANY,INADDR_ANY};

	/* the remote address of the server */
	struct sockaddr_in server = {AF_INET,7000};
	/* convert and store the server's IP Address */
	server.sin_addr.s_addr = inet_addr("");

    /* set up the transport end point */
	if((sockfd = socket(AF_INET,SOCK_DGRAM,0))==-1)
	{
		perror("socket call failed");
		exit(1);
	}

	/* bind the local address to the end point */
	if(bind(sockfd,(struct sockaddr *)&client,SIZE)==-1)
	{
		perror("Bind call failed");
		exit(1);
	}

	/* read a character from the keyboard */
	while(read(0,&c,1)!=0)
	{
		/* send a character to the server */
		if(sendto(sockfd,&c,1,0,&server,SIZE)==-1)
		{
			perror("client:sending");
			continue;
		}

		/* receive the message back */
		if(recv(sockfd,&c,1,0)==-1)
		{
			perror("client:receiving");
			continue;
		}

		write(1,&c,1);
	}
}