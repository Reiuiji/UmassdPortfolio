/* project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
typedef unsigned short int uByte;
#define MAXDIG 1000
#define NUMTRM 300
void PrintArray(int x[]);
void DivArray(int x[], int Div, int Ans[]);
void CopyArray(int x[],int y[]);
void AddArray(int x[],int y[],int z[]);

int main()
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
		DivArray(Term,N,NewTerm);
		CopyArray(Term,NewTerm);
		AddArray(Sum,Term,Sum);
		printf("N=%3d ------------------------------------------------------------------------\n",N);
		printf("TRM=");PrintArray(Term);printf("\n");
		printf("SUM=");PrintArray(Sum);printf("\n");
	}
	return 0;
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
// Divide the Arrays
void DivArray(int x[], int Div, int Ans[])
{
	int j,t, remain=0;
for (j=0; j<MAXDIG; j++)
{
	t=x[j]+(remain*10);
	Ans[j]=t/Div;
	remain=t%Div;
}
}

//copy one Array to another
void CopyArray(int x[],int y[])
{
	int i;
	for(i=0;i<MAXDIG;i++)
		x[i]=y[i];
}
void AddArray(int x[],int y[],int z[])
{
	int Carry=0,t,J;
  for (J=MAXDIG-1; J>=0; J--)
  {
	  t=x[J]+y[J]+Carry;
	  z[J]=t%10;
	  Carry=t/10;
  }
}
