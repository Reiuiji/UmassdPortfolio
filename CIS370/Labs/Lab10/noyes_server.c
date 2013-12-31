/* server process */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <signal.h>
#include <math.h>

#define SIZE sizeof(struct sockaddr_in)
#define BUFSIZE 1024


int main()
{
    int sockfd,	newsockfd;
    in_addr_t serverIPAddress = inet_addr("127.0.0.1");	// Server IP
    in_port_t serverPortNum = htons(6789);	// Host port in correct format

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

    printf("Listening for Clients:\n\n");
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
            char Buffer[BUFSIZE];
            double input;
            // Receive character from client //
            while(recv(newsockfd,&Buffer,BUFSIZE,0)>0)
            {

                input = atof(Buffer);
                printf("Client: Input %lf\n",input);

                sprintf(Buffer, " Sin: %lf \n Cos: %lf \n Tan: %lf \n Log: %lf \n exp: %lf\n", sin(input), cos(input), tan(input), log(input), exp(input));
                printf(" Sin: %lf \n Cos: %lf \n Tan: %lf \n Log: %lf \n exp: %lf\n\n", sin(input), cos(input), tan(input), log(input), exp(input));


                if(send(newsockfd, &Buffer, BUFSIZE, 0) == -1)
                {
                    perror("Send call failed");
                    continue;
                }
            }

            // When client closes connection, server's	   //
            //	 socket can be closed and the child killed //
            close(newsockfd);
            exit(0);
        }

        // Close parent's copy of newsockfd //
        close(newsockfd);
    }
    return 0;
}
