/* squareroot() function */
#include <stdio.h>
#include <math.h>

int squareroot(double num)
{
	double sum;
	sum = sqrt(num);
	printf("|   Square root: %-14.2f    |\n", sum);
	return sum;
}
