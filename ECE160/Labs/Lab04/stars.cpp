/* LAB 4 - stars.cpp
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <math.h>

int main()
{
	int a,n,s,p;
	float b;
	/*
	a=variable for *
	n=variable for \n
	s=variable for " "
	p=variable for pattern
	b=just to use float variable
	*/
	printf("This wil show multiple patterns that will be between\n");
	printf("1-----10\n");
	printf("|--------------------|");
	printf("\n");

//#1

	printf("|     Pattern # 1    |\n");
	printf("|--------------------|\n");
		for (n=0;n<5;n++)
		{
			for(a=0;a<4;a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");

//#2
	printf("|     Pattern # 2    |\n");
	printf("|--------------------|\n");
		for (n=0;n<4;n++)
		{
			for(a=0;a<2*n+1;a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");

//#3
	printf("|     Pattern # 3    |\n");
	printf("|--------------------|\n");
		for (n=0;n<5;n++)
		{
			for(a=0;a<5-n;a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");

//#4
	printf("|     Pattern # 4    |\n");
	printf("|--------------------|\n");
		for (n=0;n<7;n++)
		{
			for(s=0;s<7-n;s++)
				printf(" ");
			for(a=0;a<n+1;a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");


//#5
	printf("|     Pattern # 5    |\n");
	printf("|--------------------|\n");
		for (n=0;n<7;n++)
		{
			for(s=0;s<0+n;s++)
				printf(" ");
			for(a=0;a<9;a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");

//#6
	printf("|     Pattern # 6    |\n");
	printf("|--------------------|\n");
		for(n=0;n<5;n++)
		{

			for(s=0;s<4-n;s++)
				printf(" ");

			for(a=0;a<2*n+5;a++)
				printf("*");

			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");

//#7
	printf("|     Pattern # 7    |\n");
	printf("|--------------------|\n");
		for(n=0;n<9;n++)
		{

			for(s=0;s<4-abs(4-n);s++)
				printf(" ");

			for(a=0;a<(abs(4-n)+3);a++)
				printf("*");

			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");


//#8
	printf("|     Pattern # 8    |\n");
	printf("|--------------------|\n");
		for(n=0;n<5;n++)
		{
			b=n;
			for(a=0;a<pow(5-b,2);a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");


//#9
	printf("|     Pattern # 9    |\n");
	printf("|--------------------|\n");
		for(n=0;n<9;n++)
		{
			b=5-abs(n-4);
			for(s=0;s<pow(b,2)-1;s++)
				printf(" ");

			for(a=0;a<26-pow(b,2);a++)
				printf("*");

			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");


//#10
	printf("|     Pattern # 10   |\n");
	printf("|--------------------|\n");
		for(n=0;n<11;n++)
		{
			for(s=0;s<abs(5-n);s++)
				printf(" ");
			for(a=0;a<11-2*(abs(5-n));a++)
				printf("*");
			printf("\n");
		}
		printf("\n");
		printf("|--------------------|\n");


}