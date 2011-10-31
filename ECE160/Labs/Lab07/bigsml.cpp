/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
void GetValues(int x[], int *pN);
int FindBig(int x[], int n);
int FindSml(int x[], int n);
float FindAvg(int x[], int n);

void main()
{
  int a[100], myBig, mySml,n;
  float myAvg;
  GetValues(a,&n);
  myBig=FindBig(a,n);
  mySml=FindSml(a,n);
  myAvg=FindAvg(a,n);
  printf("The Largest value is: %d\n",myBig);
  printf("The Smallest value is: %d\n",mySml);
  printf("The Average value is: %.2f\n",myAvg);
}
//input the variables
void GetValues(int x[], int *pN)
{
  int i;
  printf("Enter number of integer values:  ");
  scanf("%d",&*pN);
  for (i=0; i<*pN; i++)
    {
      printf("Enter value %d: ",i+1);
      scanf("%d",&x[i]);
    }
}

//find the largest variables
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

