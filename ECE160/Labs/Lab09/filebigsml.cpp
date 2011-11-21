/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
int FindBig(int x[], int n);
int FindSml(int x[], int n);
float FindAvg(int x[], int n);


int main()
{
	int Num[1000],NUMVAL,i,BIG,SML;
	float AVG;

FILE *NINP;
FILE *NOUT;
//set the numbers input file
NINP=fopen("numbers-inp.txt","rt");
if ( NINP == NULL)
{
    printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
    exit(1);
}

//grab the number value
fscanf(NINP,"%d\n",&NUMVAL);
//grab the values off the file
for (i=0; i<NUMVAL; i++)
{
    fscanf(NINP,"%d/n", &Num[i]);
}    
fclose(NINP);

BIG=FindBig(Num,NUMVAL);
SML=FindSml(Num,NUMVAL);
AVG=FindAvg(Num,NUMVAL);

//print out the file to a txt file
NOUT=fopen("numbers-out.txt", "wt");
	if ( NOUT ==0)
	{
        printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
        exit(2);
	}
fprintf(NOUT,"Biggest: %d\n",BIG);
fprintf(NOUT,"Smallest %d\n",SML);
fprintf(NOUT,"Average: %.2f\n",AVG);
fclose(NOUT);
}
int FindBig(int x[], int n)
{
  int i,big;
  big=x[0];
  for (i=1; i<n; i++)
    if (x[i]>big) big=x[i];
  return big;
} 

//find the smallest variables
int FindSml(int x[], int n)
{
  int i,sml;
  sml=x[0];
  for (i=1; i<n; i++)
    if (x[i]<sml) sml=x[i];
  return sml;
} 

//find the average value
float FindAvg(int x[], int n)
{
  int i,sum=0;
  float avg;
  for (i=0; i<n; i++)
    sum+=x[i];
  avg=(float)((float)sum/(float)n);
  return avg;
}
