/*PWriter.c*/
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#define MAX_Length 100
#define PIPE_Location "/tmp/mypiper"
 
int main(int argc, char* argv[])
{
	char line[MAX_Length];
	int pipe;
	FILE *file;
	if(argc != 2)
	{
		printf("[Usage]: %s file\n",argv[0]);
		return 0;
	}
	if((file=fopen(argv[1],"rt")) == NULL)
	{
		printf("Error with file\n");
		exit(0);
	}
	fgets(line, MAX_Length, file);
	fclose(file);

	//open a pipe mypiper
	pipe = open(PIPE_Location, O_WRONLY);
	write(pipe, line, strlen(line));
	close(pipe);
	return 0;
}
