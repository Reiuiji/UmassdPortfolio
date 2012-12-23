/*Send-Mysocket.c*/
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <sys/un.h>
#define MAX_Length 100
int main(int argc, char* argv[])
{
	int soc,n;
	char buf[MAX_Length] ;
	struct sockaddr_un peer={AF_UNIX, "Mysocket"};
	FILE *file;

	if(argc != 2)
	{
		printf("[Usage]: %s (file with items)\n",argv[0]);
		return 0;
	}
	if((file=fopen(argv[1],"rt")) == NULL)
	{
		printf("Error with file\n");
		exit(0);
	}
	fgets(buf, MAX_Length, file);
	fclose(file);

	soc = socket(AF_UNIX, SOCK_DGRAM, 0);
	if ( access(peer.sun_path, F_OK) > -1 )
	{
		n = sendto(soc, buf, strlen(buf), 0, &peer, sizeof(peer));
		if ( n < 0 )
		{
			fprintf(stderr, "sendto failed\n");
			exit(1);
		}
		printf("Sender: %d characters sent!\n", n);
		close(soc);
	}
	return(0);
}
