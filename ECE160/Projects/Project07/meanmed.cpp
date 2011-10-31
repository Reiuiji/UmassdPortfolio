/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

void main()
{
	int a[100],b[100],t,n,i,j;
	float sum,avg,m;
	printf("Enter number of integer values:  ");
	scanf("%d",&n);
	while(n!=0 && n<=100)
	{
		//get values
		for (i=0; i<n; i++)
		{
			printf("Enter value %d: ",i+1);
			scanf("%d",&a[i]);
			b[i]=a[i];
		}

		//sort the values
		for (i=0; i<n; i++)  
		{
			for (j=0; j<(n-1); j++)
			{
				if (b[j]>b[j+1])
				{
					t=b[j];
					b[j]=b[j+1];
					b[j+1]=t;
				}
			}
		}

		//print original and sorted values
		printf("\n    Original      Sorted\n");
		for (i=0; i<n; i++)
		{
			printf("%12d%12d\n",a[i],b[i]);
		}
		printf("\n");

		//calculate mean
		sum=0;
		for (i=0; i<n; i++)
			sum+=a[i];
		avg=(float)(((float)sum)/n);
		printf("Mean:  %8.2f\n",avg);

		//calculate median
		if (n%2==0)
			m=(float)((float)b[(n/2)]+(float)b[(n/2)-1])/2;
		else
			m=(float)((float)b[(n-1)/2]);
		printf("Median:%8.2f\n",m);

		printf("Enter number of integer values:  ");
		scanf("%d",&n);
	}
}