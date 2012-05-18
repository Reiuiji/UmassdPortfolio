/* ECE161lab7 project
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

//declairs the node for the Queue
typedef struct nodeQueue 
	{
		void*        dataPtr;
		struct nodeQueue* next;
	} QUEUE_NODE;

//declairs the Queue Structure
typedef struct
	{
		QUEUE_NODE* front; 
		QUEUE_NODE* rear; 
		int         count; 
	} QUEUE;

//menu
int menu(void);

//menu list printer
void mlist(char *word,int Number,int spacecount);

//create stack function
STACK*	createStack (void);

//push stack function that will add to the top of the stack
bool    pushStack    (STACK* stack, void* dataInPtr);

//pop stack function that will remove the top item in a stack
bool popStack (STACK* stack, void** dataOutPtr);

//check if the stack is empty
bool emptyStack (STACK* stack);

//removes a stack from the program
STACK* destroyStack (STACK* stack);

//create queue function
QUEUE* createQueue (void);

//insert queue function
bool enqueue (QUEUE* queue, void* itemPtr);

//remove queue function
bool dequeue (QUEUE* queue,	void** itemPtr);

//destroy queue function
QUEUE* destroyQueue (QUEUE* queue);

//check if queue is empty
bool  emptyQueue (QUEUE* queue);

//main
int main()
{
	//set the temp variables
	int num,tmp1=0,tmp2=0;

	//set the end action for the program
	bool end = false;
	
	//create the input stack
	STACK* InputStack = createStack();

	//create the output stack
	STACK* OutputStack = createStack();

	//create the input queue
	QUEUE* InputQueue = createQueue();

	//create the output queue
	QUEUE* OutputQueue = createQueue();


	do{
	switch(menu())
	{
	case 1:
		printf("What value do you want to insert: ");
		scanf("%d",&num);
		pushStack(InputStack,(int*)num);
		enqueue(InputQueue,(int*)num);
		break;
	case 2:
		if(emptyStack(InputStack) == false)
		{
			popStack(InputStack,(void**)&tmp1);
			dequeue(InputQueue,(void**)&tmp2);
			pushStack(OutputStack,(int*)tmp2);
			enqueue(OutputQueue,(int*)tmp1);
			printf("what was moves:%2d, %2d\n",tmp1,tmp2);
		}
		else
		{
			printf("\nOutput Stack: ");
			while(emptyStack(OutputStack) == false)
			{
				popStack(OutputStack,(void**)&tmp1);
				printf("%2d ",tmp1);
			}
			printf("\nOutput Queue: ");
			while(emptyQueue(OutputQueue) == false)
			{
				dequeue(OutputQueue,(void**)&tmp2);
				printf("%2d ",tmp2);
			}
			printf("\n");

			//empty out each stack and queue
			destroyStack(InputStack);
			destroyStack(OutputStack);
			destroyQueue(InputQueue);
			destroyQueue(OutputQueue);

			//set end to true so it will close the program
			return 0;
		}
		break;
	}
	} while(end == false);
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
	printf("|        welcome to Lab 7: stack and queue test driver        |\n");
	printf("|         Please select what operation you want to do         |\n");
	printf("|-----|-------------------------------------------------------|\n");
	printf("|   1 |  Input                                                |\n");
	printf("|   2 |  Delete                                               |\n");
	printf("|_____|_______________________________________________________|\n\n");

	//this do while loop will constanly go untill you type the write number
	do{
		printf("Please select the action you want to do:");
		scanf("%d",&pick);
		if (pick != 1 && pick != 2)
		{
			printf("|========================================|\n");
			printf("|  you missed type, please try again :D  |\n");
			printf("|========================================|\n");
		}
	}while (pick != 1 && pick != 2);

	return pick;
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
bool popStack (STACK* stack, void** dataOutPtr)
{
//Definitions
	STACK_NODE* temp;

	//checks if count is zer, if it is true then the pointer to the data will be null
	if (stack->count == 0)
	    dataOutPtr = NULL;
	else
	   {
            //sets a temp node to the top node
            temp       = stack->top;

            //grabs the data from the top node
            *dataOutPtr = stack->top->dataPtr;

            //set the stack top to the topnode link so it points the the next nodes under the top node
            stack->top = stack->top->link;

            //free up some memory by removing the top node
            free (temp);

            //decrese the stack count by 1
            (stack->count)--;
	   }

	   //returns the value that was previous in the top node data
        return true;
}

//checks if the stack is empty
bool emptyStack (STACK* stack)
{
    //check if stack count is zero, if true then it will output true etc.
	return (stack->count == 0);
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


/*
This is all the functions for queue
*/

//This will create a queue
QUEUE* createQueue (void)
{
//definition
	QUEUE* queue;

	queue = (QUEUE*) malloc (sizeof (QUEUE));
	if (queue)
	   {
	    queue->front  = NULL;
	    queue->rear   = NULL;
	    queue->count  = 0;
	   }
	return queue;
}

//This will insert data in the queue
bool enqueue (QUEUE* queue, void* itemPtr)
{
//definitions
	QUEUE_NODE* newPtr;

	if (!(newPtr = 
	   (QUEUE_NODE*)malloc(sizeof(QUEUE_NODE))))
	   return false;

	newPtr->dataPtr = itemPtr; 
	newPtr->next    = NULL; 
	 
	if (queue->count == 0)
	   queue->front  = newPtr;
	else
	   queue->rear->next = newPtr; 

	(queue->count)++;
	queue->rear = newPtr;
	return true;
}

//This will remove data in the queue
bool dequeue (QUEUE* queue,	void** itemPtr) 
{
//Definitions
	QUEUE_NODE* deleteLoc;

	if (!queue->count)
	    return false;
	 
	*itemPtr  = queue->front->dataPtr;
	deleteLoc = queue->front;
	if (queue->count == 1)
	   queue->rear  = queue->front = NULL;
	else
	   queue->front = queue->front->next;
	(queue->count)--;
	free (deleteLoc);

	return true;
}

//This will Destory a queue
QUEUE* destroyQueue (QUEUE* queue) 
{
//	Local Definitions 
	QUEUE_NODE* deletePtr;

//	Statements 
	if (queue)
	   {
	    while (queue->front != NULL) 
	       {
	        free (queue->front->dataPtr);
	        deletePtr    = queue->front;
	        queue->front = queue->front->next; 
	        free (deletePtr); 
	       } // while 
	    free (queue);
	   } // if 
	return NULL;
}

//this will check if a queue is empty
bool emptyQueue (QUEUE* queue) 
{
	return (queue->count == 0);
}