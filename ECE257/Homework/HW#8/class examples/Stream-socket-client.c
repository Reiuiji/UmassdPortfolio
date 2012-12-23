#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
int main()
{
	int soc;
	char buf[256];
	struct sockaddr_un self = {AF_UNIX, "clientsoc"};
	struct sockaddr_un peer = {AF_UNIX, "serversoc"};
	soc = socket(AF_UNIX, SOCK_STREAM, 0);
	bind(soc, &self, sizeof(self));
  /* request connection to serversoc */
	if (connect(soc, &peer, sizeof(peer)) == -1)
	{
	perror("client:connect"); close(soc);
	unlink(self.sun_path); exit(1);
	}
	write(soc, "hello from client", 18);
	read(soc, buf, sizeof(buf));

	printf("SERVER ECHOED: %s\n", buf);
	close(soc);   unlink(self.sun_path);
	return(0);
}
