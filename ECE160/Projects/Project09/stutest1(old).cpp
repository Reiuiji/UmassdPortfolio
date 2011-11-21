/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
//set the number of test
#define NUMTEST 4

int main()
{
int NUMSTU,i,j;
//set the input file
FILE *SF;
FILE *SFO;
SF=fopen("stutest1.txt","rt");
if ( SF == NULL)
{
    printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
    exit(1);
}
fscanf(SF,"%d\n", &NUMSTU);
//setup the arrays based on the number of students
int id[NUMSTU], TEST[NUMSTU][NUMTEST];
float sum=0,STUAVG[NUMSTU],TESTAVG[NUMTEST],TOTALAVG;

//dump the data from the stutest.txt file
for (i=0; i<NUMSTU; i++)
{
    fscanf(SF,"%d ", &id[i]);
    for (j=0; j<NUMTEST;j++)
        fscanf(SF,"%d ", &TEST[i][j]);
}
        
fclose(SF);

//calculate to individual test average
for (i=0; i<NUMTEST-1;i++)
    {
    for (j=0; j<NUMSTU; j++)
			sum+=TEST[i][j];
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
for (i=0; i<NUMTEST-1;i++)
    {
	TOTALAVG+=TESTAVG[i];
    }


//print out the file to a txt file
SFO=fopen("stutest2.txt", "wt");
	if ( SFO ==0)
	{
        printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
        exit(2);
	}

    //print the header to the table
fprintf(SFO," STU ID \t");
    for(i=1;i<=NUMTEST;i++)
    {
        if(i<10)
        fprintf(SFO,"TEST %1d  ",i);
        if(i>10 && i<100)
        fprintf(SFO,"Test %2d ",i);
    }
fprintf(SFO,"Average\n");
//print the student data
for(i=0;i<NUMSTU;i++)
{
    fprintf(SFO,"%08d        ",id[i]);
    for(j=0;j<NUMTEST;j++)
    {
        fprintf(SFO," %3d    ",TEST[i][j]);
    }
    fprintf(SFO,"%6.2f\n",STUAVG[i]);
}

//print the test average
    fprintf(SFO,"Averages       ");
    for(i=0;i<NUMTEST;i++)
    {
        fprintf(SFO,"%8.2f",TESTAVG[i]);
    }
    fprintf(SFO,"%6.2f\n",TOTALAVG);
    
}
