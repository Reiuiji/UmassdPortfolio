/* noyescat.c
 * created by Daniel Noyes
 * catnate funciton for CIS370
 */

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define BUFSIZE 512	// the size of the file it is parsing
#define PERMISSION 0644	// file perssiom for the new file

int cat(const char* file1, const char* file2, const char* file3);
void help(void);


int main ( int argc, char *argv[])
{
	if( argc!= 4)
	{
		help();
	exit(1);
	}
	else
	{
		cat(argv[1], argv[2], argv[3]);
	}
	return 0;
}

int cat(const char *file1, const char *file2, const char *file3)
{
char buffer[BUFSIZE];
int inputfile[2], outputfile;
ssize_t nread, nwrite;


	//check if the input file can be read
	if(( inputfile[0] = open(file1, O_RDONLY )) == -1)
	{
		printf("[Error]: %s cannot be read, exiting",file1);
		return -1;
	}

	//check if the input file can be read
	if(( inputfile[1] = open(file2, O_RDONLY )) == -1)
	{
		close(inputfile[0]);
		printf("[Error]: %s cannot be read, exiting",file2);
		return -1;
	}

	//check if the outputfile is read ony
	if((outputfile = open(file3, O_WRONLY|O_CREAT| O_APPEND, PERMISSION)) == -1)
	{
		close (inputfile[0]);
		close (inputfile[1]);
		printf("[INFO]: %s is read only!\n", file3);
		exit(1);
	} 
	//read file1 and write to file 3 
	while( (nread = read(inputfile[0], buffer, BUFSIZE)) > 0)
	{
		if( (nwrite = write(outputfile, buffer, nread)) < nread)
		{
			close(inputfile[0]);
			close(inputfile[1]);
			close(outputfile);
			printf("[Error]: write error\n");
			return (-3);
		}
	}
	//read file2 and write to file 3 
	while( (nread = read(inputfile[1], buffer, BUFSIZE)) > 0)
	{
		if( (nwrite = write(outputfile, buffer, nread)) < nread)
		{
			close(inputfile[0]);
			close(inputfile[1]);
			close(outputfile);
			printf("[Error]: write error\n");
			return (-3);
		}
	}

	close(inputfile[0]);
	close(inputfile[1]);
	close(outputfile);
	if( nread == -1)
		return (-4);
	else
		return 0;
}


void help(void)
{
	printf("  Usage: dnoyescp <inputfile1> <inputfile2> <outputfile>\n");
	//printf("  Help menu:\n");
	//printf("  --verion     Display version tag\n");
	//printf("  --help       Display this help menu\n");
}
