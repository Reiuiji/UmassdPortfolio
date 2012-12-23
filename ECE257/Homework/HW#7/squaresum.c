/* squaresum() function */
#include <stdio.h>

int squaresum(double num)
{
	int i;
	double sum=0;
	for(i=0; i <= num; i++)
		sum += i*i; 
	printf("|   Sum of Square: %-14.0f  |\n", sum);
	return sum;
}
