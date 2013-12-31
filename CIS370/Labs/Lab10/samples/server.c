/* server process */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>

#define SIZE sizeof(struct sockaddr_in)

void lostConnectionHandler(int signal);

main()
{
	int sockfd,	newsockfd;
	in_addr_t serverIPAddress = inet_addr("127.0.0.1");	// Server IP
	in_port_t serverPortNum = htons(7000);	// Host port in correct format

    // Initialize the internet socket at address 127.0.0.1:7000 //
	struct sockaddr_in server = {AF_INET,serverPortNum,serverIPAddress};

    // Set up the transport end point //
	if((sockfd = socket(AF_INET,SOCK_STREAM,0))==-1)
	{
		perror("socket call failed");
		exit(1);
	}

    // Bind server address to the end point //
	if(bind(sockfd,(struct sockaddr *)&server,SIZE)==-1)
	{
		perror("bind call failed");
		exit(1);
	}

	// Start listening for incoming connections //
	if(listen(sockfd,5)==-1)
	{
		perror("listen call failed");
		exit(1);
	}

	/* Code to send/receive message from client */
	while(1)
	{
		// Accept a connection - can accept more than one //
		if((newsockfd=accept(sockfd,NULL,NULL))==-1)
		{
			perror("accept call failed");
			continue;
		}

		// While parent is listening for connections,	//
		//   spawn a child to perform IPC 				//
		if(fork()==0)
		{
			char clientChar;
			// Receive character from client //
			while(recv(newsockfd,&clientChar,1,0)>0)
			{
				clientChar=toupper(clientChar);

				// Send uppercase character back to client //
				send(newsockfd,&clientChar,1,0);
			}

			// When client closes connection, server's	   //
			//	 socket can be closed and the child killed //
			close(newsockfd);
			exit(0);
		}

		// Close parent's copy of newsockfd //
	    close(newsockfd);
  	}
}