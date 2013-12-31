/***********************************************************************************
*	sampleCP.c
*
*	This program:
*	Takes two paths and copies the content of path1 to path2.
**********************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#define BUFFER 512
#define PERM  0644

int copyfile(const char *name1, const char *name2)
{
 	int inp, outp;
	ssize_t reader;
	char buffer[BUFFER];

	// Open File 1 for reading
	if((inp = open(name1, O_RDONLY)) == -1) 
	{
	  printf("Error opening file: %s\n", name1);
	  return(-1);
	}

	// Open File 2 for writing/appending
	if((outp = open(name2, O_WRONLY |O_CREAT|O_APPEND, PERM)) == -1)
	{
	  printf("Error opening file: %s\n", name2);
	  return(-1);
	}


	// Copy
	while((reader = read(inp, buffer, BUFFER)) > 0)
	{
	  if(write(outp, buffer, reader) < reader)
	  {
		close(inp);
		close(outp);
		return(-2);
	  }
	}

	close(inp);
	close(outp);

	if(reader == -1)
	  return(-4);
	else
	  return(0);
}

/* Main() */
int main(int argc, char *argv[])
{
	if( argc != 3)			//Wrong number of command line arguments
	{
  	  printf("Usage: sampleCP file1 file2\n");
	  return 1;
	}

  	copyfile(argv[1], argv[2]);   

  return 0;
}

