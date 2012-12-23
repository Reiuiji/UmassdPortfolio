#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
int main()
{
	int soc, ns, k;
	char buf[256];
	struct sockaddr_un self = {AF_UNIX, "serversoc"};
	struct sockaddr_un peer = {AF_UNIX};
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
	write(ns, buf, k);
	close(ns);   close(soc);
	unlink(self.sun_path); return(0);
}
