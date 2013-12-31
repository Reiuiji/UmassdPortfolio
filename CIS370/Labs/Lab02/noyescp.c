/* noyescp.c
 * created by Daniel Noyes
 * catnate funciton for CIS370
 */
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define BUFSIZE 512	// the size of the file it is parsing
#define PERMISSION 0644	// file perssiom for the new file

int copy(const char* file1, const char* file2);
void help(void);


int main ( int argc, char *argv[])
{
	if( argc!= 3)
	{
		help();
	exit(1);
	}
	else
	{
	//	if(argv[1] == "--help" || argv[1] = "-h")
	//	{
	//		help();
	//		return 0;
	//	}
		copy(argv[1], argv[2]);
	}
	return 0;
}

int copy(const char *file1, const char *file2)
{
char buffer[BUFSIZE];
int inputfile, outputfile;
int total[2]; //total size for each file
ssize_t nread, nwrite;


	//check if the input file can be read
	if(( inputfile = open(file1, O_RDONLY )) == -1)
	{
		printf("[Error]: %s cannot be read, exiting",file1);
		return -1;
	}

	//check if the outputfile is read ony
	if((outputfile = open(file2, O_WRONLY|O_CREAT|O_EXCL| O_APPEND, PERMISSION)) == -1)
	{
		//close (inputfile);
		printf("[INFO]: %s exist!\n", file2);
		//exit(1);
	} 
	//read file1 based on the buffersize
	while( (nread = read(inputfile, buffer, BUFSIZE)) > 0)
	{
		if( (nwrite = write(outputfile, buffer, nread)) < nread)
		{
			close(inputfile);
			close(outputfile);
			printf("[Error]: write error\n");
			return (-3);
		}
	}
	total[0] = lseek(inputfile,0,SEEK_END);
	total[1] = lseek(outputfile,0,SEEK_END);
	close(inputfile);
	close(outputfile);
	remove(file1);	
	printf("[info]: %s is %d bytes\n", file1, total[0]);
	printf("[info]: %s is %d bytes\n", file2, total[1]);
	if( nread == -1)
		return (-4);
	else
		return 0;
}


void help(void)
{
	printf("  Usage: dnoyescp <file1> <file2>\n");
	printf("  Help menu:\n");
	//printf("  --verion     Display version tag\n");
	printf("  --help       Display this help menu\n");
}
