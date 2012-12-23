/*Receiver-Mysocket.c*/
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

void cleanup(int soc, char *file)
{       close(soc);
        unlink(file);
}
int main()
{
	int soc;
	char buf[64];
	struct sockaddr_un self={AF_UNIX, "Mysocket"};
	struct sockaddr_un peer;
	int n, len;
	soc = socket(AF_UNIX, SOCK_DGRAM, 0);
	n = bind(soc, &self, sizeof(self));
	if ( n < 0 )
	{
		fprintf(stderr, "bind failed\n");
		exit(1);
	}
	n = recvfrom(soc, buf, sizeof(buf),0, &peer, &len);
	if ( n < 0 )
	{
		fprintf(stderr, "recvfrom failed\n");
		cleanup(soc, self.sun_path);
		exit(1);
	}

	buf[n] = '\0';
	printf("receiver: %s\n", buf);
	cleanup(soc, self.sun_path); 
	return(0);
}
