/* ECE161lab8 project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

*/

//stops the secure warnings
#define _CRT_SECURE_NO_WARNINGS

//grabs the standard input output library
#include <stdio.h>

//grabs the standard library
#include <stdlib.h>

//grabs the string library
#include <string.h>

//Head structure which points to the data
typedef struct Head
{
	//point to the top of the list
	struct Node *linkp;
} NODE;

//test structure that holds the score for each student
typedef struct test
{
	//integer that holds the test score
	int score;

	//pointer that points down to the next score for the student
	struct test *link;
}	TEST;

//student structure that holds the student main data
typedef struct student
{
	//character holder for each student name
	char name[50];

	//pointer that points to the next student
	struct student *NextStu;

	//pointer that points to the test scores
	struct test *pScore;
}	STUDENT;

//searches through the student list to find where it can be inserted in order
bool SearchStuList (STUDENT *Head, STUDENT **pPrev, STUDENT **pCurrent, char *name);

//Insert the Student data to the main list
STUDENT *InsertStudent (STUDENT *Head, STUDENT *pPrev, char *name, int NumScores);

//Insert the scores for each individual students
TEST InsertScore(STUDENT *pNew,TEST **Current, int InScore);

//Prints out the students and the scores to the screen
void PrintList(STUDENT *Head);

//main Program
int main(void)
{
	//set the pointer to the start of the students
	STUDENT *start = NULL;

	//set pointer to the prevous and current stack
	STUDENT *pPrev, *pCurrent;

	//set a temp holder that will hold the amount of scores for each student
	int score;

	//set a temp name holder for student
	char tmpName[50];

	//this is used to skip the first line in the student text file which is garbarge data
	char Gar[200];

	//set the variable for input and output file
	FILE *DATA;

	//set the input file and check to see if it is there (student_data_x.txt)
	if ((DATA=fopen("student_data_x.txt","rt")) == NULL)
	{

		//display student_data_x.txt not found
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)");

		//exit the program with a "EXIT_FAILURE"
		exit(0);
	}

	//skip the first line of the student_data_x.txt with fgets since it displays the header for the text file
	fgets(Gar,200,DATA);

	//grabs the needed data from the student_data_x.txt file
	while(fscanf(DATA,"%s %d",tmpName,&score) == 2)
	{

		//Search through the student list to put the next student
		SearchStuList (start, &pPrev,&pCurrent,tmpName);

		//inserts the student and the amount of scores to be input from the txt file
		start = InsertStudent(start,pPrev,tmpName, score);
	}

	//closes the file link (needed to reupload since i forgot to add this in)
	fclose(DATA);

	//print out the list of students and there scores
	PrintList(start);

	//return 0 back to show is succeded
	return 0;
}

//searches through the student list to find where it can be inserted in order
//*Head: points to the main list
//**pPrev: double pointer which will be used to locate the spot to insert the student
//**pCurrent: double pointer which is the current place the function is looking through
//*name: student name needed to compare to the other student names on the list
bool SearchStuList (STUDENT *Head, STUDENT **pPrev, STUDENT **pCurrent, char *name )
{
	//set found to false
	bool found = 0;

	//Reset *pPrev pointer to NULL
	*pPrev = NULL;

	//Reset *pCurrent to the top of the student list
	*pCurrent = Head;

	//goes through the student list until it reaches the end of the list or the name is larger than the previous name
	while(*pCurrent != NULL && strcmp(name,(*pCurrent)->name) > 0)
	{

		//set the previous pointer to the current pointer
		*pPrev = *pCurrent;

		//current pointer goes ahead and goes down the student list
		*pCurrent = (*pCurrent)->NextStu;
	}

	//if both names are the same then it found it and will return true
	if (*pCurrent && strcmp(name,(*pCurrent)->name) == 0)

		//set found to true since it found the exact same name
		found = true;

	//returns true or false wheather if found a student(just in case)
	return found;
}

//Insert the Student data to the main list
//*Head: points to the main list
//*pPrev: points to the pointer which will be used to put the student data in
//*name: student name
//NumScores: how many scores needed to be implemented
STUDENT *InsertStudent (STUDENT *Head, STUDENT *pPrev, char *name, int NumScores)
{
	STUDENT *pNew;
	int list, InScore;
	TEST *pWalk = NULL;

	//set up the student structure
	pNew = (STUDENT *)malloc(sizeof(STUDENT));

	//checks if it succeded 
	if(pNew == NULL)
	{

		//if it fails, there is no memory to hold it
		printf("Not enought memory, please free up some and try again");

		//closes the program with exit(1)
		exit(1);
	}

	//grabs the student name and put it into the new node
	strncpy(pNew->name,name,50);

	//set the pointer for the score to null, prevents miss point
	pNew->pScore =NULL;

	//checks if this is the first student in the list
	if (pPrev == NULL)
	{
		//if it is true, it sets the new pointer to the head
		pNew->NextStu = Head;

		//Sets the Head to the new node
		Head = pNew;
	}
	else
	{
		//if its not the first, it will be inserted into the list
		//will set the new node to the prevois pointer so it can be inserted between two
		pNew->NextStu = pPrev->NextStu;

		//set the previous pointer to the new node
		pPrev->NextStu = pNew;
	}

	//Inserts the scores for this individual Student
	for(list=0;list<NumScores;list++)
	{

		//promts the user to input the scores
		printf("Please enter score %d for %s:",list+1,name);

		//grabs the input data from the user
		scanf("%d",&InScore);

		//inputs the scores with the InsertScore function
		*pWalk = InsertScore(pNew,&pWalk,InScore);
	}

	//return the Header back to the program
	return Head;
}

//Insert the scores for each individual students
//*pNew: points to the individual Student
//**Current:Is used to progress through the Test Structure
//InScore: the score data that will be inserted into the Test list
TEST InsertScore(STUDENT *pNew,TEST **Current, int InScore)
{
	TEST *pNewScore;
	
	//creates the newscore so it can be implemented
	pNewScore = (TEST *)malloc(sizeof(TEST));

	//checks if it succeded
	if(pNewScore == NULL)
	{
		//if it fails, means no more memory
		printf("Not enought memory, please free up some and try again");

		//closes the program with a exit(1)
		exit(1);
	}

	//sets the new nodes data
	pNewScore->score = InScore;

	//set the new nodes pointer to null
	pNewScore->link = NULL;

	//check if this is the first score for the student
	if (*Current == NULL)
	{

		//first score, set the students score pointer to the new node
		pNew->pScore = pNewScore;

		//set the progressor to the next Node, so it can follow through the data nicely
		*Current = pNewScore;

	}

	//if it fails the check, there is already data in it. so it just latches on
	else
	{

		//sets the progressor link to the new score so the score is linked to the list
		(*Current)->link = pNewScore;

		//progress the current pointer down to the newly implemented node
		*Current = pNewScore;
				
	}

	//return the current progressor to the main program
	return **Current;
}


//Prints out the students and the scores to the screen
//Head: points to the main List to be printed
void PrintList(STUDENT *Head)
{
	//Declair a pointer variable to go through the Student Structure 
	STUDENT *pWalker;

	//Declair a pointer variable to go through each individual score list
	TEST *pTWalker;

	//count increment that will limit the output to only four times for this program has a limit of four scores
	int count;

	//adds each score per student to calculate the total and average
	float Sum;

	//set the pwalker to the top of the student list
	pWalker = Head;

	//print the header of the list to the consol
	printf("\n\n");
	printf("+=====================+========+========+========+========+=========+=========+\n");
	printf("| Student Names       |  Sc 1  |  Sc 2  |  Sc 3  |  Sc 4  |  total  |   Avg   |\n");
	printf("|---------------------|--------|--------|--------|--------|---------|---------|\n");

	//checks through the student list until pwalker becomes a null and end's the printing the list
	while (pWalker)
	{
		//print only 19 lines for the name
		printf("| %-19s |",pWalker->name);

		//sets the scores walker so it can go down the individual student scores
		pTWalker = pWalker->pScore;

		//reset sum
		Sum = 0;

		//reset count
		count = 0;

		//checks through the scores list and prints them until the score walker is null or count hits 4
		while (pTWalker != NULL && count <4)
		{
			//prints out the scores
			printf("  %4d  |",pTWalker->score);

			//adds the scores together
			Sum = Sum + (float)pTWalker->score;

			//goes down the list in the score
			pTWalker = pTWalker->link;

			//add to count
			count++;
		}

		//when there is no more scores, and less than 4, it will print out white space
		while(count<4)
		{
			
			//print out white space
			printf(" - -- - |");
			
			//add to count
			count++;
		}

		//prints out the total and the average of each individual students scores
		printf(" %7.2f | %7.2f |\n",Sum, Sum/count);

		//goes to the next student down the list
		pWalker = pWalker->NextStu;
	}

	//footer of the list to be printed out to the consol
	printf("+=====================+========+========+========+========+=========+=========+\n");
	printf("\n\n");

}
//end of program
//sooo long, finally done with comments
//if only it was 2 hours earlier XD