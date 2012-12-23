#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	double num;
	if(argc != 2)
	{
		printf("Usage: %s [number]\n", argv[0]);
		return;
	}
	num = atof(argv[1]);
	printf("\n/----------------------------------\\ \n");
	printf("|   Number:  %-12.2f          |\n",num);
	sine(num);
	squareroot(num);
	square(num);
	squaresum(num);
	printf("\\----------------------------------/\n");
	return 0;
	
}
