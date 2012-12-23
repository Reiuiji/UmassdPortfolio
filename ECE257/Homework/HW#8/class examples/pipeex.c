#include <sys/types.h> 
#include <sys/stat.h> 
#include <unistd.h> 
#include <fcntl.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <errno.h> 
#define MAX_LINE 80 
int main(int argc, char** argv) { 
	char line[MAX_LINE]; 
	int pipe; 
// open a named pipe 
	pipe = open("/tmp/myFIFO", O_WRONLY); 
// get a line to send 
	printf("Enter line: "); 
	fgets(line, MAX_LINE, stdin); 
// actually write out the data and close the pipe 
	write(pipe, line, strlen(line)); 
// close the pipe 
	close(pipe); 
	return 0; } 
