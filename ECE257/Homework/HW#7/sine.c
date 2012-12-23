/* sine() function */
#include <stdio.h>
#include <math.h>
#define PI 3.1415926

int sine(double num)
{
	double sumr,sumd;
	sumr = sin(num);
	sumd = sin(num*(PI/180));
	printf("|   sine: %5.2f[deg], %5.2f[rad]   |\n", sumd,sumr);
	return sumd,sumr;
}

