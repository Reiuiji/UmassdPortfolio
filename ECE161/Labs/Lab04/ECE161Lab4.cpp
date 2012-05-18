/* ECE161lab4 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

This Lab recieves data from a txt document for name, id, exams for a student
Then it will print to the screen and sort it to a txt file with averages, highest and lowest from the data
*/

//stops the secure warnings
#define _CRT_SECURE_NO_WARNINGS

//grabs the standard input output libraries
#include <stdio.h>

//grabs the standard library
#include <stdlib.h>

//grabs the string library 
#include <string.h>

//set the max students for the program
#define MAXSTU 50


//test Global Declarations for real :D
typedef struct
{
	char name[26];
	int id;
	int exam[4];
	float avg;
} STUDENT ;

//set a sorting array for names
void Name_Sort (STUDENT names[],int array_lim);
//void Find_High(STUDENT list,int high[]);
int Average(STUDENT user[]);
 
int main()
{
	//time to go crazy with comments XD
	//define the definitions
	STUDENT student[MAXSTU];

	int ARRAY_LIM=0,i,j,high[4]={0},low[4]={100,100,100,100};

	float avg[4]={0},tmp;

	//set the variable for input and output file
	FILE *DATA, *OUT;

	//set the input file and check to see if it is there (student_data.txt)
	if ((DATA=fopen("student_data_4.txt","rt")) == NULL)
	{

		//display student_data.txt not found
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)");

		//exit the program with a "EXIT_FAILURE"
		exit(0);
	}

	//sets the output file and check to see if it is there (sorted_data.txt)
	if ( (OUT=fopen("sorted_data.txt", "wt")) == NULL)
	{

		//display sorted_data file not found
		printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");

		//exit the program  with a "EXIT_FAILURE"
		exit(2);
	}

	//grabs the information from the file student_data.txt

	//print to the terminal
	printf("_____________________________________________________________________________\n");
	printf("| Student Names       |  id  | Exam  1 | Exam  2 | Exam  3 | Exam  4 |Average|\n");
	printf("|---------------------|------|---------|---------|---------|---------|-------|\n");
	while(fscanf(DATA,"%s %d %d %d %d %d",student[ARRAY_LIM].name,&student[ARRAY_LIM].id,&student[ARRAY_LIM].exam[0],&student[ARRAY_LIM].exam[1],&student[ARRAY_LIM].exam[2],&student[ARRAY_LIM].exam[3]) == 6)
	{
		
		//calculate the average
		student[ARRAY_LIM].avg = (student[ARRAY_LIM].exam[0]+student[ARRAY_LIM].exam[1]+student[ARRAY_LIM].exam[2]+student[ARRAY_LIM].exam[3])/4;

		printf("| %-19s | %4d |   %3d   |   %3d   |   %3d   |   %3d   | %3.2f |\n",student[ARRAY_LIM].name,student[ARRAY_LIM].id,student[ARRAY_LIM].exam[0],student[ARRAY_LIM].exam[1],student[ARRAY_LIM].exam[2],student[ARRAY_LIM].exam[3],student[ARRAY_LIM].avg);
		ARRAY_LIM++;
	}

	//find the highest ,lowest and average of each exam
	for(i=0;i<4;i++)
	{
		tmp=0;
		for(j=0;j<ARRAY_LIM;j++)
		{
			if(high[i]<student[j].exam[i])
				high[i]=student[j].exam[i];
			if((low[i]>student[j].exam[i]) && (student[j].exam[i]!=0))
				low[i]=student[j].exam[i];
			tmp+=student[j].exam[i];
		}
		avg[i]=tmp/ARRAY_LIM;
	}
	printf("|----------------------------|---------|---------|---------|---------|-------|\n");
	printf("|  Highest grade per exam:   |   %3d   |   %3d   |   %3d   |   %3d   |       |\n",high[0],high[1],high[2],high[3]);
	printf("|  Lowest grade per exam:    |   %3d   |   %3d   |   %3d   |   %3d   |       |\n",low[0],low[1],low[2],low[3]);
	printf("|  Avererage grade per exam: |  %3.2f  |  %3.2f  |  %3.2f  |  %3.2f  |       |\n",avg[0],avg[1],avg[2],avg[3]);
	printf("|----------------------------|---------|---------|---------|---------|-------|\n");

	//finish grabing from student_data
	fclose(DATA);

	//sets up a sort program to sort the name of each student

	Name_Sort (student,ARRAY_LIM);

	//prints out to a text document (sorted_data.txt)
	fprintf(OUT,"____________________________________________________________________________________\n");
	fprintf(OUT,"| Student Names              |  id  | Exam  1 | Exam  2 | Exam  3 | Exam  4 |Average|\n");
	fprintf(OUT,"|----------------------------|------|---------|---------|---------|---------|-------|\n");

	//print out each student name, id, exams, and average for the exams
	for(i=0;i<ARRAY_LIM;i++)
	{
		fprintf(OUT,"| %-26s | %4d |   %3d   |   %3d   |   %3d   |   %3d   | %3.2f |\n",student[i].name,student[i].id,student[i].exam[0],student[i].exam[1],student[i].exam[2],student[i].exam[3],student[i].avg);
	}
	fprintf(OUT,"|-----------------------------------|---------|---------|---------|---------|-------|\n");
	fprintf(OUT,"|  Highest grade per exam:          |   %3d   |   %3d   |   %3d   |   %3d   |       |\n",high[0],high[1],high[2],high[3]);
	fprintf(OUT,"|  Lowest grade per exam:           |   %3d   |   %3d   |   %3d   |   %3d   |       |\n",low[0],low[1],low[2],low[3]);
	fprintf(OUT,"|  Avererage grade per exam:        |  %3.2f  |  %3.2f  |  %3.2f  |  %3.2f  |       |\n",avg[0],avg[1],avg[2],avg[3]);
	fprintf(OUT,"|-----------------------------------|---------|---------|---------|---------|-------|\n");

	//end of printing to file
	fclose(OUT);

	return 0;

	//return with interger type data, return without error
	//end of program :D

}

//sorting array for the names on a structure
void Name_Sort (STUDENT names[],int array_lim)
{

	int i,j;
	STUDENT tmpname;

	for(i=array_lim-1;i>=0;i--)
	{
		for(j=1;j<=i;j++)
		{
			if (strcmp(names[j-1].name,names[j].name) > 0)
			{
				tmpname = names[j-1];
				names[j-1]=names[j];
				names[j]=tmpname;
			}
		}
	}
}