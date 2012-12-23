/*Client-Mysocket-5.c*/
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#define MAX_Length 256
int sort(char* unsort);

int main()
{
	int soc;
	char buf[MAX_Length];
	struct sockaddr_un self = {AF_UNIX, "clientsoc"};
	struct sockaddr_un peer = {AF_UNIX, "/home/okuu/Dropbox/UMD/Semester#3/ECE-257/Homework/HW#8/serversoc"};
	soc = socket(AF_UNIX, SOCK_STREAM, 0);
	bind(soc, &self, sizeof(self));


	if (connect(soc, &peer, sizeof(peer)) == -1)
	{
		perror("client:connect"); close(soc);
		unlink(self.sun_path); exit(1);
	}
	write(soc, "Client 1:request items", MAX_Length);
	read(soc, buf, sizeof(buf));
	printf("SERVER replied: %s\n", buf);
	close(soc);   unlink(self.sun_path);
	sort(buf);

	return(0);
}
//sort the items
int sort(char* unsort)
{
	int i=0,j=0,k=0,INDEX[100],tmp,t;
	char sort[100][MAX_Length]={0};
	printf("unsorted %s", unsort);

	for(i=0;(unsort[i] != '\n');i++)
	{
		if(unsort[i] == 32)
		{
		    sort[j][k] = '\0';
			j++;
			k=0;
		}
		else
		{
            sort[j][k] = unsort[i];
            k++;
		}
	}

    for(i=0;i<100;i++)
        INDEX[i]=i;
    for(i=0;i<j;i++)
    {
        for(k=0;k<j;k++)
        {
		t=strncmp(sort[INDEX[j]],sort[INDEX[j+1]],20);
        if(t>0)
            {
            tmp=INDEX[j];
            INDEX[j]=INDEX[j+1];
            INDEX[j+1]=tmp;
            }
        }
    }
    printf("\nsorted: ");
	for(i=0;i<=j;i++)
	{
		printf("%s ",sort[INDEX[i+1]-1]);
	}
	printf("\n");
}
