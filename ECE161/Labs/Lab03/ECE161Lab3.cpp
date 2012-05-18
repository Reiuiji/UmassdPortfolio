/* ECE161lab3 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

This Lab recieves data from a txt document for name, midterm, and final for a student
Then it will print to the screen and sort it to a txt file
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
	int midterm[3];
	int final;
} STUDENT ;

//set a sorting array for names
void Name_Sort (STUDENT names[],int &array_lim);

//input command
void STUDENT_INPUT (FILE INPUT,STUDENT student[],int array_lim);

int main()
{
	//time to go crazy with comments XD
	//test local Definitions
	STUDENT student[MAXSTU];
	int ARRAY_LIM=0,i;

	//set the variable for input and output file
	FILE *DATA, *OUT;

	//set the input file and check to see if it is there (student_data.txt)
	if ((DATA=fopen("student_data.txt","rt")) == NULL)
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

	STUDENT_INPUT (*DATA,student,ARRAY_LIM);

	//finish grabing from student_data
	fflush(DATA);

	//sets up a sort program to sort the name of each student

	Name_Sort (student,ARRAY_LIM);

	//prints out to a text document (sorted_data.txt)
	fprintf(OUT,"_________________________________________________________________________\n");
	fprintf(OUT,"| Student Names              | midterm 1 | midterm 2 | midterm 3 | Final |\n");
	fprintf(OUT,"|----------------------------|-----------|-----------|-----------|-------|\n");

	//print out each student name, midterm, final
	for(i=0;i<ARRAY_LIM;i++)
	{
		fprintf(OUT,"| %-26s |    %3d    |    %3d    |    %3d    |  %3d  |\n",student[i].name,student[i].midterm[0],student[i].midterm[1],student[i].midterm[2],student[i].final);
	}
	fprintf(OUT,"|____________________________|___________|___________|___________|_______|\n");

	//end of printing to file
	fflush(OUT);

	return 0;

	//return with interger type data, return without error
	//end of program :D

}

//input function
void STUDENT_INPUT (FILE *INPUT,STUDENT STU[],int &ARRAY_LIM)
{
	//grabs the information from the file student_data.txt
	//print to the terminal
	printf("_________________________________________________________________________\n");
	printf("| Student Names              | midterm 1 | midterm 2 | midterm 3 | Final |\n");
	printf("|----------------------------|-----------|-----------|-----------|-------|\n");
	while(fscanf(INPUT,"%s %d %d %d %d",STU[ARRAY_LIM].name,&STU[ARRAY_LIM].midterm[0],&STU[ARRAY_LIM].midterm[1],&STU[ARRAY_LIM].midterm[2],&STU[ARRAY_LIM].final) == 5)
	{
		printf("| %-26s |    %3d    |    %3d    |    %3d    |  %3d  |\n",STU[ARRAY_LIM].name,STU[ARRAY_LIM].midterm[0],STU[ARRAY_LIM].midterm[1],STU[ARRAY_LIM].midterm[2],STU[ARRAY_LIM].final);
		ARRAY_LIM++;
	}
	printf("|____________________________|___________|___________|___________|_______|\n");
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