/* ECE161lab6 project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

*/

//stops the secure warnings
#define _CRT_SECURE_NO_WARNINGS

//grabs the standard input output libraries
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//set the max structures for the program
#define MAX_STACKS 100

//declairs the node for the stack
typedef struct node
	{
	void*        dataPtr;
	struct node* link;
	} STACK_NODE;

//declairs the stack structure
typedef struct
	{
	int         count;
	STACK_NODE* top;
	} STACK;


//menu
int menu(void);

//menu list printer
void mlist(char *word,int Number,int spacecount);

//create stack function
STACK*	createStack (void);

//push stack function that will add to the top of the stack
bool    pushStack    (STACK* stack, void* dataInPtr);

//pop stack function that will remove the top item in a stack
void*	popStack     (STACK* stack);

//check if the stack is empty
bool	emptyStack (STACK* stack);

//check if the stack is full
bool	fullStack (STACK* stack);

//removes a stack from the program
STACK* destroyStack (STACK* stack);

//copy stack
STACK* copyStack(STACK* stack);

//chech if two stacks are equal
bool eqStack(STACK* stack1, STACK* stack2);

//prints the contets of a stack
void prnStack(STACK* stack);

//pause the system until you hit a key
void pause(void);

//main
int main()
{
	//set the main definitions
	char stackname[MAX_STACKS][26];

	//set the stack
	STACK* stack[MAX_STACKS];

	//set the following
	//mpick: menu pick variable
	//end: set the end to a stack
	//select/select2: select
	//set temp functions of num and n.
	int mpick,end = 0,select,select2,num, n;

    //set a int point called digit
	int* digit;

    //set the leave function to false.
	bool leave = false;
	do	{
	    mpick = menu();
    if(mpick > 1 && mpick <= 12)
    {
    if(mpick != 12 && mpick != 10)
    {
    //this will print out the stack list
	select = 0;
	printf("\n");
	printf("|-------------------------------------------------------------|\n");
	printf("|          please select what stack you want to edit          |\n");
	printf("|-----|-------------------------------------------------------|\n");
    }
    else
    {
	printf("\n");
	printf("|-------------------------------------------------------------|\n");
	printf("|             currnet list of stack in the program            |\n");
	printf("|-----|-------------------------------------------------------|\n");
    }


	//this will print out the current list of stacks and have you select what you want
	for(n=0; n<end;n++)
	{
	printf("| %3d ",n);

	printf("|  %-53s|\n",&stackname[n]);
	}
	printf("|_____|_______________________________________________________|\n\n");

    if(mpick != 12 && mpick != 10)
    {
		do{
			if(select <0 || select >=end)
				printf("\nI did not get that, please try again\n");
        printf("\n\nplease select what stack you want to edit:");
        scanf("%d",&select);
		}while (select <0 || select >=end);
    }
	}

//this is the main function to pick what the program does
	switch(mpick)
	{
		//0:incase you miss type in the menu you will end up here, might not actually execute
		case 0:
			printf("exit the program, have a nice day :)\n");
			leave = true;
			break;


		//1: Creates a new stack
		case 1:
			printf("what do you want to name the stack:");
			scanf("%s",stackname[end]);
			stack[end] = createStack();
			end++;
			break;

		//2: add content to a stack
		case 2:
            digit = (int*) malloc (sizeof(int));
			printf("type in what you want to store in the stack %s:",stackname[select]);
			scanf("%d",&num);
			*digit = num;
			pushStack(stack[select],digit);
			break;

		//3: remove content from a stack
		case 3:
			printf("you have removed: %d from the stack",*(int*)popStack (stack[select]));
			break;

        //4: check what is top in a stack
        case 4:
			printf("the top of stack %s is : %d",stackname[select],*(int*)stack[select]->top->dataPtr);
            break;

        //5: check if a stack is empty
        case 5:
			if(emptyStack (stack[select])==true)
				printf("stack is empty\n");
			else
				printf("stack is not empty\n");
			system("pause");
            break;

        //6: check if a stack is full
        case 6:
			if(fullStack (stack[select])==true)
				printf("stack is full, try and free up some memory\n");
			else
				printf("stack is not full\n");
			system("pause");
            break;

        //7: count how many in the stack
        case 7:
            printf("\nThere are %d items in stack %s\n\n",stack[select]->count,stackname[select]);
            break;

        //8: destory a stack
        case 8:
			printf("do you want to destory %s? \n 1:yes\n 0:no\n",stackname[select]);
			do{
				scanf("%d",&num);
			} while (num < 0 || num > 1);
			if( num == 1)
			{
				if(select == end)
				{
					destroyStack(stack[select]);
					for (n=0;n<26;n++)
						stackname[select][n] = NULL;
				}
				else
				{
					destroyStack(stack[select]);
					for(n=select;n<end;n++)
					{
						stack[n]= stack[n+1];
						strncpy(stackname[n],stackname[n+1],26);
					}
				}
				end--;
				printf("Deleted the stack");
			}
			else
				printf("did not delete the stack");
            break;

        //9: copies from one stack to another
        case 9:
			printf("what do you want to name the stack copied stack:");
			scanf("%s",stackname[end]);
			stack[end] = copyStack(stack[select]);
			end++;
            break;

        //10: check if two stacks are equal
        case 10:
			printf("\n\nplease select first stack you want to check:");
			scanf("%d",&select);
			printf("\n\nplease select second stack you want to check:");
			scanf("%d",&select2);
			if(eqStack(stack[select], stack[select2]) == true)
				printf("Both stacks %s and %s are equal\n",stackname[select],stackname[select2]);
			else
				printf("Both stacks %s and %s are Not equal\n",stackname[select],stackname[select2]);
            pause();
            break;

        //11: prints the contents to the terminal
        case 11:
			printf("\n\nCurrently in stack %s: ",stackname[select]);
			prnStack(stack[select]);
			pause();
            break;

        //12: prints out the current list of stacks
        case 12:
            //getchar();
            pause();
            break;

        }
	} while(leave == false);

	//outputs if the program was a success
	return 0;
}


//the main menu function
int menu(void)
{
	//define the pick variable that will return to the main program
	int pick;

	//prints out to the terminal the main menu for the program
	printf("\n");
	printf("|-------------------------------------------------------------|\n");
	printf("|           welcome to Lab 6: Stacks as Linked List           |\n");
	printf("|         Please select what operation you want to do         |\n");
	printf("|-----|-------------------------------------------------------|\n");

	//condense the list for the menu to a mlist function that will print the list properly
	mlist("Create a new Stack",1,61);
	mlist("Add to a stack",2,61);
	mlist("Remove from a stack",3,61);
	mlist("Check what is top in the stack",4,61);
	mlist("Check if a stack is empty",5,61);
	mlist("Check if a stack is full",6,61);
	mlist("Count how many in the stack",7,61);
	mlist("Destory a stack",8,61);
	mlist("Copies the contents of one stack into another",9,61);
	mlist("Check each stack whether the contents are equal",10,61);
	mlist("prints the contents of a stack",11,61);
	mlist("lookup the current list of stacks",12,61);

	//tells how to close the program
	mlist("close the program",0,61);

	//ends the menu being print out to the list
	printf("|_____|_______________________________________________________|\n\n");

	//this do while loop will constanly go untill you type the write number
	do{
		printf("Please select the action you want to do:");
		scanf("%d",&pick);
		if (pick <0 || pick >12)
		{
			printf("|========================================|\n");
			printf("|  you missed type, please try again :D  |\n");
			printf("|========================================|\n");
		}
	}while (pick <0 || pick >12);

	return pick;
}

//this will print out a list for the menu, (module test)
void mlist(char *word,int Number,int spacecount)
{
	//print out the number for your selection
	printf("| %3d ",Number);

	//print out the list and will print going left to right
	printf("|  %-*s%*s|\n",strlen(word),word,(spacecount-8-strlen(word))," ");
}



//this will create a stack
STACK* createStack (void)
{
//declair temp stack
	STACK* stack;

//set the stack with memmory allocated towards it
	stack = (STACK*) malloc( sizeof (STACK));

	//check if there is a valid place for the stack since malloc could get a full memory problem
	if (stack)
	   {
	        //set the count of the stack to 0
            stack->count = 0;

            //set the top stack pointer to NULL since there is nothing it should point to
            stack->top   = NULL;
	   }

	   //return stack to the main program
        return stack;
}

//this will add a new item to the stack
bool pushStack (STACK* stack, void* dataInPtr)
{
    //declair a new pointer node for the stack
	STACK_NODE* NewNode;

    //sets the new nod
	NewNode = (STACK_NODE*)malloc(sizeof(STACK_NODE));

    //if there is no new node since memory full, it will close the program
	if (!NewNode)
	    return 0;

	//set the data pointer from the iput given
	NewNode->dataPtr = dataInPtr;

	//set the data pointer to the previous top item
	NewNode->link    = stack->top;

	//set the stack top to the new node
	stack->top      = NewNode;

	//add one to the current stack
	(stack->count)++;
	return 1;
}

//this will remove the top item from the stack
void* popStack (STACK* stack)
{
//Definitions
	void*       dataOutPtr;
	STACK_NODE* temp;

	//checks if count is zer, if it is true then the pointer to the data will be null
	if (stack->count == 0)
	    dataOutPtr = NULL;
	else
	   {
            //sets a temp node to the top node
            temp       = stack->top;

            //grabs the data from the top node
            dataOutPtr = stack->top->dataPtr;

            //set the stack top to the topnode link so it points the the next nodes under the top node
            stack->top = stack->top->link;

            //free up some memory by removing the top node
            free (temp);

            //decrese the stack count by 1
            (stack->count)--;
	   }

	   //returns the value that was previous in the top node data
        return dataOutPtr;
}

//checks if the stack is empty
bool emptyStack (STACK* stack)
{
    //check if stack count is zero, if true then it will output true etc.
	return (stack->count == 0);
}

//checks if the stack is full
bool fullStack (STACK* stack)
{
	//definition
	STACK_NODE* temp;

    //checks to see if you can put a new node in the stack
	if ((temp =
	   (STACK_NODE*)malloc (sizeof(*(stack->top)))))
	   {
	       //after finishing, frees up the temp node
            free (temp);

            //returns true since there is free memory
            return 0;
	   }

	// returns false since malloc fails
	return 1;
}

//destory a stack in the program
STACK* destroyStack (STACK* stack)
{
//definition
	STACK_NODE* temp;

    //checks to see if there is a actual stack
	if (stack)
	   {
            // Delete all nodes in stack
            while (stack->top != NULL)
            {

                // Delete data entry
                free (stack->top->dataPtr);

                //sets the temp node to the stack top pointer so i can point to the node it wants to delete
                temp = stack->top;

                //sets the stack top to the top node link, so it points to the previous node in the stack
                stack->top = stack->top->link;

                //frees up the old node memory by free the temp which links to the old node that was on top
                free (temp);
            }

	    // Stack now empty. Destroy stack head node.
	    free (stack);
        }

        //returns a null value since there should not be a return value, just a null
        return NULL;
}

//This will copy the stack in a parellel function, so goes down from the stack list and copy to the new one the same way
STACK* copyStack(STACK* stack)
{
    //definitions
	STACK* NewStack;
	STACK_NODE* NewNode;

	//link to the node it is copying to
	struct node* TempLinkNew;

	//link to the node your copying from
	struct node* TempLinkOrig;

	//link that will be used to set the null for the new node
	struct node* TempLinkEnd;

    //set the stack with memmory allocated towards it
	NewStack = (STACK*) malloc( sizeof (STACK));
	if (NewStack)
	   {
            //sets up the stack count
            NewStack->count = stack->count;

			//set up a templink to the original top pointer
			TempLinkOrig = stack->top;

			//if the templink has nothing then the job is done, just copied the stack head
			if(TempLinkOrig == NULL)
				return NULL;

			//creates first node for the new stack
			NewNode = (STACK_NODE*)malloc(sizeof(STACK_NODE));
			if (!NewNode)
				return 0;

			//set the newstack to point to the new node
			NewStack->top = NewNode;

			//sets the temp link to the first node in the new stack
			TempLinkNew = NewStack->top;

            //sets up rest of the nodes
            while(TempLinkOrig != NULL)
			{
			    //sets the templink end to equal the current link for the node
				TempLinkEnd = TempLinkNew;

				//set the data in the first node to the first node of the original
				TempLinkNew->dataPtr = TempLinkOrig->dataPtr;

				//sets up the new node
				NewNode = (STACK_NODE*)malloc(sizeof(STACK_NODE));

				//if there is a null in the node, it will output a false which indicate a fail
				if (!NewNode)
					 return 0;

                //sets the temp new link to the node
				TempLinkNew->link = NewNode;

				//goes down the path for the original stack
				TempLinkOrig = TempLinkOrig->link;

				//goes down the path of the new stack
				TempLinkNew = TempLinkNew->link;

			}
			//when it is finish, it will set the bottom node to a null, since templinknew will be a null, you have to have a previous link to set it to null
			TempLinkEnd->link = NULL;
        }
    else{
        //if it fails, will print a error and send out a null
        printf("error creating copy stack");

        //returns a null
        return NULL;
        }

    //if it successed then it will send the newstack out to the program
    return NewStack;
}

//check if two stacks are equal
bool eqStack(STACK* stack1, STACK* stack2)
{
    //set two links to the top of each stack
	struct node* TempLink1=stack1->top;
	struct node* TempLink2=stack2->top;

	//check if both stacks have the same amount of nodes
	if(stack1->count != stack2->count)
		return 0; // returns a false

	while (TempLink1 != NULL)
	{
		//contantly checks if both are eqaul, if not output false
		if(*(int*)TempLink1->dataPtr != *(int*)TempLink2->dataPtr)
			return 0;

		//set the new points
		TempLink1 = TempLink1->link;
		TempLink2 = TempLink2->link;
	}

	//if everything was success full print out a true
	return 1;
}

//prints the contets of a stack
void prnStack(STACK* stack)
{
    //definition
	struct node* TempLink;

	//set a templink to the top
	TempLink = stack->top;

	//constanly print out till it encounters a null
    while(TempLink != NULL)
	{
	    //print out the data for the node with a output of point int instead of node
		printf("%d ",*(int*)TempLink->dataPtr);

		//set the templink to the next link on the stack
		TempLink = TempLink->link;
	}
}

//pausing function in the program
void pause(void)
{
	//return the next value from stdin
    getchar();

    //wait until you hit anything
    fputs ( "\n\nPress [Enter] to continue . . .", stdout );

    //flush the stdout
	fflush ( stdout );

	//return the next value from stdin
	getchar();
}
