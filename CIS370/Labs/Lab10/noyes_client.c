/* client process */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdbool.h>

#define SIZE sizeof(struct sockaddr_in)
#define BUFSIZE 1024

int main()
{
    int serverSockfd;
    double input;
    char Buffer[BUFSIZE], InBuf[BUFSIZE];

    in_addr_t serverIPAddress = inet_addr("127.0.0.1");	// Server IP
    in_port_t serverPortNum = htons(6789);	   // Server port number

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
        printf("\nEnter Value or x to quit: ");

        if(scanf("%lf", &input) == 0)
        {
            printf("Entered a non digit(x)\n");
            printf("Closing Connection.\n");
            // Close socket //
            close(serverSockfd);
            exit(1);
        }
        sprintf(Buffer, "%lf", input);
        //printf("[Debug] Input : %lf\n", input);

        // Send Data to server //
        if(send(serverSockfd, &Buffer, BUFSIZE, 0) == -1)
        {
            perror("Send Fail");
            continue;
        }

        // Receive updated character from server //
        if(recv(serverSockfd, &InBuf, BUFSIZE, 0) > 0)
        {
            printf("\n%s", InBuf);
        }
    }
}
