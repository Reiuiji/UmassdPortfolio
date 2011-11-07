/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#define MAXDIG 200
#define NUMTRM 10000000
#define PRTTRM 72
void PrintArray(int x[],int P);
void DivPIArray(int x[], int Divterm, int Ans[]);
void CopyArray(int x[],int y[]);
void AddSubPIArray(int x[],int y[],int z[],int N);

int main()
{
	int Term[MAXDIG]={0},Sum[MAXDIG]={0},NewTerm[MAXDIG]={0},N=0,J;
	FILE *FPI;
	char OUT;
	Term[0]=4;
	Sum[0]=4;
	printf("N=%3d ------------------------------------------------------------------------\n",N);
	//print term value
	printf("TRM=");PrintArray(Term,PRTTRM);printf("\n");
	//print sum value
	printf("SUM=");PrintArray(Sum,PRTTRM);printf("\n");

	for (N=1; N<NUMTRM; N++)
	{
		DivPIArray(Term,N,NewTerm);
		CopyArray(Term,NewTerm);
		AddSubPIArray(Sum,Term,Sum,N);
		if(N%10000==0)
		{
		printf("N=%3d ------------------------------------------------------------------------\n",N);
		printf("TRM=");PrintArray(Term,PRTTRM);printf("\n");
		printf("SUM=");PrintArray(Sum,PRTTRM);printf("\n");
		}
	}
	printf("calculated pi with %d times terms\n",NUMTRM);
	OUT=Sum[0];
	FPI = fopen("pi.txt", "wt");
	fprintf(FPI, "\ncalculated pi with %d iterations\n%d.",NUMTRM,OUT);
	for (J=1;J<MAXDIG;J++)
	{
	OUT=Sum[J];
	fprintf(FPI, "%d",OUT);
	}

	fputs ( "Press [Enter] to continue . . .", stdout );
	fflush ( stdout );
	getchar();
	return 0;
}

//print the arrays
void PrintArray(int x[],int P)
{
	printf("%1d.",x[0]);
	int i, NonZeroSeen=0;
	for(i=1;i<P;i++)
	{
		printf("%1d",x[i]);
	}
}
// Divide the Arrays for pi
void DivPIArray(int x[], int Divterm, int Ans[])
{
	int j,t=4, remain=0,B=Divterm*2+1;
for (j=0; j<MAXDIG; j++)
{
	Ans[j]=t/B;
	remain=t%B;
	t=(remain*10);
}
}

//copy one Array to another
void CopyArray(int x[],int y[])
{
	int i;
	for(i=0;i<MAXDIG;i++)
		x[i]=y[i];
}
void AddSubPIArray(int x[],int y[],int z[],int N)
{
	int Carry=0,t,J,l=N%2;
	if (l==0)
	{
		for (J=MAXDIG-1; J>=0; J--)
		{
			t=x[J]+y[J]+Carry;
			z[J]=t%10;
			Carry=t/10;
		}
	}
	else
		{
		for (J=MAXDIG-1; J>=0; J--)
		{
			z[J]=x[J]-y[J];
			if (z[J]<0)
			{
				z[J-1]--;
				z[J]=z[J]+10;
			}
		}
	}
}

