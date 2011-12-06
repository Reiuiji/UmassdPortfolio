/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PIMAX 1000000

int main()
{
	int NUM[10]={0}, i, check, PI;


	//NUM[3] is one because pi.txt start after the '.' in 3.14
	NUM[3]=1;

	
	//check how many of 0-9 in pi based on scanf input
	for(i=0;i<(PIMAX);i++)
	{
		scanf("%1d", &PI);
	
		switch(PI)
		{
			case 0:
				NUM[0]++;
				break;
			case 1:
				NUM[1]++;
				break;
			case 2:
				NUM[2]++;
				break;
			case 3:
				NUM[3]++;
				break;
			case 4:
				NUM[4]++;
				break;
			case 5:
				NUM[5]++;
				break;
			case 6:
				NUM[6]++;
				break;
			case 7:
				NUM[7]++;
				break;
			case 8:
				NUM[8]++;
				break;
			case 9:
				NUM[9]++;
				break;
		}
	}


	//print out the number and the amount of each

	for(i=0;i<10;i++)
		printf("%d:%8d\n",i,NUM[i]);
}
