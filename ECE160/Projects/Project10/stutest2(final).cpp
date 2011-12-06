/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//set the number of test
#define NUMTEST 4
//set the student limit
#define STULIM 100
//set the name limit.
#define NAMELIM 20
int main()
{
int i,j, TEST[STULIM][NUMTEST],NUMSTU;
float sum=0,STUAVG[STULIM],TESTAVG[NUMTEST]={0},TOTALAVG=0;
char NAME[100][NAMELIM]={0}, linbuf[200]; 
FILE *SF;
//set the input file
if ((SF=fopen("stutest2.txt","rt")) == NULL)
{ printf("Sorry Could not find the File\nIt might have ran away from you"); exit(0);}
      
fscanf(SF,"%d\n",&NUMSTU);
for (i=0;i<NUMSTU;i++)
{
	fgets(linbuf,200,SF);
	strncpy(NAME[i] , linbuf,NAMELIM); //limit the string copy to the first 20 arrays of the string
	NAME[i][NAMELIM-1] = '\0';

	for(j=0;j<NUMTEST;j++)
	{
	TEST[i][j] = atoi(&linbuf[NAMELIM+(j*4)]);
	}
	for (j=0;j<200;j++)
		linbuf[i]=0;
}
fclose(SF);


//calculate to individual test average
for (i=0; i<NUMTEST;i++)
    {
	sum=0;
    for (j=0; j<NUMSTU; j++)
			sum=sum+TEST[j][i];
    TESTAVG[i]=(float)(((float)sum)/NUMSTU);
    }
//find the individual student average
for(i=0;i<NUMSTU;i++)
    {
    sum=0;
    for(j=0;j<NUMTEST;j++)
        sum+=TEST[i][j];
    STUAVG[i]=(float)(((float)sum)/NUMTEST);
    }
//calculate total avergage
for (i=0; i<NUMTEST;i++)
    {
	TOTALAVG+=TESTAVG[i];
    }
TOTALAVG=TOTALAVG/NUMTEST;

//print the header to the table
printf("Name             ");
for(i=1;i<=NUMTEST;i++)
    {
        if(i<10)
        printf("TEST %1d  ",i);
        if(i>10 && i<100)
       printf("Test %2d ",i);
    }
printf(" Average\n");
//print the student data
for(i=0;i<NUMSTU;i++)
{
    printf("%s",NAME[i]);
    for(j=0;j<NUMTEST;j++)
    {
        printf(" %3d    ",TEST[i][j]);
    }
    printf("%6.2f\n",STUAVG[i]);
}

//print the test average
    printf("Averages       ");
    for(i=0;i<NUMTEST;i++)
    {
        printf("%8.2f",TESTAVG[i]);
    }
    printf(" %9.2f\n",TOTALAVG);
    
}

