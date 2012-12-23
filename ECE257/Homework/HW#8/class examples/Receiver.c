#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

void cleanup(int soc, char *file)
{       close(soc);
        unlink(file);
}
int main()
{ int soc;
  char buf[64];
  struct sockaddr_un self={AF_UNIX, "receiver_soc"}; /* (A) */
  struct sockaddr_un peer;
  int n, len;
        soc = socket(AF_UNIX, SOCK_DGRAM, 0);        /* (B) */
        n = bind(soc, &self, sizeof(self));          		/* (C) */
        if ( n < 0 )
        {  fprintf(stderr, "bind failed\n");
           exit(1);
        }
        n = recvfrom(soc, buf, sizeof(buf),          	/* (D) */
                     0, &peer, &len);
        if ( n < 0 )
        {  fprintf(stderr, "recvfrom failed\n");
           cleanup(soc, self.sun_path); 
           exit(1);
        }
        buf[n] = '\0';                              		 /* (E) */
        printf("Datagram received = %s\n", buf);     	/* (F) */
        cleanup(soc, self.sun_path); 
        return(0);
}
