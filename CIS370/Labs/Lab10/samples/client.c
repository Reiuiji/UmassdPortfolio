/* client process */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define SIZE sizeof(struct sockaddr_in)

main()
{
	int serverSockfd;
	char userChar,serverChar;

	in_addr_t serverIPAddress = inet_addr("127.0.0.1");	// Server IP
	in_port_t serverPortNum = htons(7000);	   // Server port number

    // Initialize the internet socket at address 127.0.0.1:7000 //
    struct sockaddr_in server = {AF_INET,serverPortNum,serverIPAddress};

    // Set up the transport end point //
	if((serverSockfd = socket(AF_INET,SOCK_STREAM,0))==-1)
	{
		perror("socket call failed");
		exit(1);
	}

	// Request connection to server //
	if(connect(serverSockfd,(struct sockaddr *)&server,SIZE)==-1)
	{
		perror("connect call failed");
		exit(1);
	}

	/* Code to send/receive message to/from server goes here */
	while(1)
	{
		char userIn[1];
		printf("Input a lowercase character: ");
		scanf("%s", userIn);
		userChar = *userIn;

		if(userChar == '$')	// Loop exit condition
			break;
		else if(!islower(userChar))
			continue;
		else
			// Send character to server //
			send(serverSockfd, &userChar, 1, 0);

		// Receive updated character from server //
		if(recv(serverSockfd, &serverChar, 1, 0) > 0)
			printf("Uppercase: %c\n", serverChar);
		else
		{
			// Close socket //
			close(serverSockfd);
			printf("Server has died.\n");
			exit(1);
		}
	}

	// Close socket //
	close(serverSockfd);
}