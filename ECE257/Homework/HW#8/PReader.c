/*PReader.c*/
#include <fcntl.h>
#include <stdio.h>
#include <time.h>

#define MAX_Length 200
#define PIPE_Location "/tmp/mypiper"
 
int main(int argc, char* argv[])
{
	char line[MAX_Length];
	int pipe;
	time_t rawtime;
	struct tm *timeinfo;

	time(&rawtime);
	timeinfo = localtime(&rawtime);

	//open a pipe mypiper as read only
	pipe = open(PIPE_Location, O_RDONLY);
	read(pipe, line, MAX_Length);
	close(pipe);
	printf("\n%s \n%s\n",line,asctime(timeinfo));
	return 0;
}
