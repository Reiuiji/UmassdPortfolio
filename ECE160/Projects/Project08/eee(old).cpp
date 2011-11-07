/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
typedef unsigned short int uByte;
#define MAXDIG 200
#define NUMTRM 73
void PrintArray(int x[]);
void DivPIArray(int x[], int Divterm, int Ans[]);
void CopyArray(int x[],int y[]);
void AddSubPIArray(int x[],int y[],int z[],int N);

void main()
{
	int Term[MAXDIG]={0},Sum[MAXDIG]={0},NewTerm[MAXDIG]={0},N=0;
	Term[0]=1;
	Sum[0]=1;
	printf("N=%3d ------------------------------------------------------------------------\n",N);
	//print term value
	printf("TRM=");PrintArray(Term);printf("\n");
	//print sum value
	printf("SUM=");PrintArray(Sum);printf("\n");

	for (N=1; N<NUMTRM; N++)
	{
		DivPIArray(Term,N,NewTerm);
		CopyArray(Term,NewTerm);
		AddSubPIArray(Sum,Term,Sum,N);
		printf("N=%3d ------------------------------------------------------------------------\n",N);
		printf("TRM=");PrintArray(Term);printf("\n");
		printf("SUM=");PrintArray(Sum);printf("\n");
	}
}

//print the arrays
void PrintArray(int x[])
{
	printf("%1d.",x[0]);
	int i, NonZeroSeen=0;
	for(i=1;i<NUMTRM;i++)
	{
		printf("%1d",x[i]);
	}
}
// Divide the Arrays for pi
void DivPIArray(int x[], int Divterm, int Ans[])
{
	int j,t, remain=0,B=Divterm*2+1;
for (j=0; j<MAXDIG; j++)
{
	t=4+(remain*10);
	Ans[j]=t/B;
	remain=t%B;
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
	if (l=0)
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
