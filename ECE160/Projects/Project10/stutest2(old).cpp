/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>


int main()
{
	int T1[100], T2[100], T3[100], T4[100];
	file *Sf;
	int numstu, I;
	if ((Sf=fopen("stutest2.txt","rt")) == NULL)
	{ printf("There is a Problem with the current file, please check to see ig it is there"); exit(0);}
	fgets(linbuf,200,f); 
	numstu = atoi(linbuf); 

	//gather the data

	for (i=0;i<numstu;i++)
	{
		fgets(linbuf,200,f);
		strncpy(name[i] , linbuf, 20); //limit the string copy to the first 20 arrays of the string
		name[i][20] = '\0';
		T1[i] = atoi(&linbuf[20]);
		T2[i] = atoi(&linbuf[24]);
		T3[i] = atoi(&linbuf[28]);
		T4[i] = atoi(&linbuf[32]);
	}
	fclose(f);

}