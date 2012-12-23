#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <sys/un.h> /* UNIX domain header */
int main()
{
	int soc;
	char buf[] = "Hello there";
	struct sockaddr_un peer={AF_UNIX, "receiver_soc"};
	int n;
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
