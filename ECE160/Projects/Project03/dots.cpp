/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main()
{
	float a,b,c,d,e,f ;
	printf("Eqn:");
	scanf("%f %f %f %f",&a,&b,&c,&d);

while (d!=0)
{
if((d>0) && (d<=4) && (a!=0))
{
	if(d==1)
	{
		printf("Output:\t");
		e=((c)-b)/a;
		printf("%16.2f   ",e);
			if(a>0)
		{
			printf("<-----o");
		}
			else
		{
			printf("o----->");
		}
	}

	if(d==2)
	{
		printf("Output:\t");
		e=(c-b)/a;
		printf("%16.2f   ",e);
		if(a>0)
		{
			printf("o----->");
		}
		else
		{
			printf("<-----o");
		}
	}

	if(d==3)
	{
		printf("Output:\t");
		e=((c)-b)/a;
		printf("%16.2f   ",e);
		if(a>0)
		{
			printf("<-----*");
		}
		else
		{
			printf("*----->");
		}
	}

	if(d==4)
	{
		printf("Output:\t");
		e=(c-b)/a;
		printf("%16.2f   ",e);
		if(a>0)
		{
			printf("*----->");
		}
		else
		{
		printf("<-----*");
		}
	}

}
else
{
	if((d>4) && (d<=8))
	{
	if(d==5)
	{
		printf("Output:\t");
		e=(c-b)/a;
		f=(-c-b)/a;
		printf("%8.2f%8.2f   ",e,f);
		printf("o-----o");
	}
	if(d==6)
	{
		printf("Output:\t");
		e=(c-b)/a;
		f=(-c-b)/a;
		printf("%8.2f%8.2f   ",e,f);
		printf("<-----o.....o----->");
	}
	if(d==7)
	{
		printf("Output:\t");
		e=(c-b)/a;
		f=(-c-b)/a;
		printf("%8.2f%8.2f   ",e,f);
		printf("*-----*");
	}
	if(d==8)
	{
		printf("Output:\t");
		e=(c-b)/a;
		f=(-c-b)/a;
		printf("%8.2f%8.2f   ",e,f);
		printf("<-----*.....*----->");
	}
	}
	else
	{
		break;
	}

}
	printf("\n");
	printf("Eqn:");
	scanf("%f %f %f %f",&a,&b,&c,&d);
}

}