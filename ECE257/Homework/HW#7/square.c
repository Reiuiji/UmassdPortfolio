/* square() function */
#include <stdio.h>
#include <math.h>

int square(double num)
{
	double sum;
	sum = pow(num,2);
	printf("|   Square: %-12.2f           |\n", sum);
	return sum;
}
