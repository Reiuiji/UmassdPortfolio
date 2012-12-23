/*Server-Mysocket-5.c*/
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#define MAX_Length 256
int main(int argc, char* argv[])
{
	int soc, ns, k;
	char buf[MAX_Length],Data[MAX_Length];
	struct sockaddr_un self = {AF_UNIX, "serversoc"};
	struct sockaddr_un peer = {AF_UNIX};
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
	fgets(Data, MAX_Length, file);
	fclose(file);

	printf("Item List: %s",Data);

	int peer_len = sizeof(peer);
  /* set up listening socket soc */
	soc = socket(AF_UNIX, SOCK_STREAM, 0);
	if (soc < 0)
	{
		perror("server:socket"); exit(1);
	}
	if (bind(soc, &self, sizeof(self)) == -1)
	{
		perror("server:bind"); close(soc);
		exit(1);
	}
	listen(soc, 1);
/* accept connection request */
	ns = accept(soc, &peer, &peer_len);
	if (ns < 0)
	{
		perror("server:accept"); close(soc);
		unlink(self.sun_path);     exit(1);
	}
  /* data transfer on connected socket ns */
	k = read(ns, buf, sizeof(buf));
	printf("SERVER RECEIVED: %s\n", buf);
	
	write(ns, Data, k);
	close(ns);   close(soc);
	unlink(self.sun_path); return(0);
}
