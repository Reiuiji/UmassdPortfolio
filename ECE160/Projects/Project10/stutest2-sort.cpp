/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//set the student limit
#define MAXSTU 100
//set the test amount
#define NUMTEST 4
//set the name limit.
#define MAXCHAR 20

void main()
{
int i, j, t, tmp, NUMSTU, INDEX[MAXSTU], TEST[MAXSTU][NUMTEST];

float sum=0, STUAVG[MAXSTU], TESTAVG[NUMTEST]={0}, TOTALAVG=0;

char NAME[MAXSTU][MAXCHAR+1]={0}, linbuf[200];

char OUT[MAXSTU][200], OUTTMP[200]; 

FILE *SF;


//set the input file
if ((SF=fopen("stutest2.txt","rt")) == NULL)
{
	printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)\n");
	exit(0);
}

fgets(linbuf,200,SF);

NUMSTU=atoi(linbuf);
	
for (i=0; i<NUMSTU; i++)
{
	fgets(linbuf,100,SF);

	strncpy(NAME[i],linbuf,20);

	NAME[i][20]='\0';

	for (j=0;j<NUMTEST;j++)
		TEST[i][j]=atoi(&linbuf[21+j*4]);
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


//add name and test and test average to OUT string
for(i=0;i<NUMSTU;i++)
{
        strcpy(OUT[i],NAME[i]);
		for(j=0;j<NUMTEST;j++)
		{
			sprintf(OUTTMP," %3d    ",TEST[i][j]);
			strncat(OUT[i],OUTTMP,8);
		}

		sprintf(OUTTMP,"%6.2f\n",STUAVG[i]);
		strncat(OUT[i],OUTTMP,6);
}


//set up the index array to index the OUT string
for(i=0;i<MAXSTU;i++)
	INDEX[i]=i;


//sort the studenta-z

for(i=0;i<NUMSTU;i++)
{
	for(j=0;j<NUMSTU;j++)
	{
		t=strncmp(OUT[INDEX[j]],OUT[INDEX[j+1]],20);
	  if(t>0)
		{
		tmp=INDEX[j];
		INDEX[j]=INDEX[j+1];
		INDEX[j+1]=tmp;
		}
	}
}


//print the header to the table
printf("Name                ");

for(i=1;i<=NUMTEST;i++)
{
	if(i<10)
		printf("TEST %1d  ",i);
	if(i>10 && i<100)
		printf("Test %2d ",i);
}

printf("Average\n");


//print the student data
for(i=0;i<NUMSTU;i++)
{
	printf("%s\n",OUT[INDEX[i]]);
}


//print the test average
	printf("Averages           ");

	for(i=0;i<NUMTEST;i++)
	{
		printf("%8.2f",TESTAVG[i]);
	}

	printf(" %6.2f\n",TOTALAVG);

}
