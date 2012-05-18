/* ECE161lab9 project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

most of the code was originated from bst2.cpp which was posted on costa's class lecture notes, BST functions
*/

//stops the secure warnings
#define _CRT_SECURE_NO_WARNINGS

//grabs the standard input output libraries
#include <stdio.h>

//grabs the standard library
#include <stdlib.h>

//grabs the string library
#include <string.h>

//grabs the ctype library
#include <ctype.h>

//Structure Declarations
//structure that will hold the customers data
typedef struct customers
{
    char names[40];
    char phonenumbers[20];
} CUSTOMERS;

//structure that holds the BST node
typedef struct node
{
    void*           dataPtr;
    struct node*    left;
    struct node*    right;
} NODE;

//structure that holds the bst head that points to root
typedef struct bst_tree
{
    int     count;
    int (*compare) (void* argu1, void* argu2);
    NODE* root;
} BST_TREE;

//prototype Declarations

    //Create a Binary Search Tree
    BST_TREE* BST_Create (int (*compare) (void* argu1, void* argu2));

    //Destroy a Binary Search Tree
    BST_TREE* BST_Destroy (BST_TREE* tree);

    //insert function for a Binary Search Tree
	bool  BST_Insert   (BST_TREE* tree, void* dataPtr);

	//Delete function for a Binary Search Tree
	bool  BST_Delete   (BST_TREE* tree, void* dltKey);

	//retrieve function for a Binary Search Tree
	void* BST_Retrieve (BST_TREE* tree, void* keyPtr);

	//traverse function for a Binary Search Tree
	void  BST_Traverse (BST_TREE* tree, void (*process)(void* dataPtr));

	//check if a BST is empty
	bool BST_Empty (BST_TREE* tree);

	//check if a BST is full
	bool BST_Full  (BST_TREE* tree);

	//return the count value from a BST tree
	int  BST_Count (BST_TREE* tree);

    //function to insert
	static NODE* _insert (BST_TREE* tree, NODE* root, NODE* newPtr);

	//function to delete
	static NODE* _delete (BST_TREE* tree, NODE* root, void* dataPtr, bool* success);

	//retrieve a node for a requestied value
	static void* _retrieve (BST_TREE* tree, void* dataPtr, NODE* root);

	//function that goes through a BST tree in order
	static void _traverse (NODE* root, void (*process) (void* dataPtr));

	//deletes all data in tree
	static void _destroy (NODE* root);

    //prototypes for main functions
    //	Prototype Declarations
    //menu for the program
    char Options    (void);

    //add a customer to the tree
    void addCust       (BST_TREE* list);

    //delete a customer to the tree
    void deleteCust    (BST_TREE* list);

    //find a customer in a tree
    void findCust      (BST_TREE* list);

    //print the list of customers in a tree
    void printList    (BST_TREE* list);

    //test the applications
    void testUtilties (BST_TREE* tree);

    //compare each customer number
    int  compareCust   (void* Cust1, void* Cust2);

    //prints one customers data
    void processCust   (void* dataPtr);

	//auto add list from a file
	void addfromlist (BST_TREE* list, FILE *file_list);

//main function
int main()
{
	//set the list variable which will point to the binary search tree
    BST_TREE* list;

	//set selection for the menu to a ' '(blank)
    char    selection = ' ';

	//points to a file to grab data
	FILE *DATA;

	//create the Binary search tree
	list = BST_Create (compareCust);

	//check if there is data in the lab9 file
	if ((DATA=fopen("/tmp/lab9_file.txt","rt")) == NULL)
	{
		//display input file not found
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)\n");
		printf("I am going to skip the inputing from a file");
	}
	//if the file is there, it will grab the data from the file
	else
		addfromlist(list, DATA);

	//menu selection
    while ((selection = Options()) != 'Q')
    {
        switch(selection)
        {
            //goes to adding a customer
            case 'A':   addCust(list);
                        break;
            //goes to deleting a customer
            case 'D':   deleteCust(list);
                        break;
            //goes to finding a customer
            case 'F':   findCust(list);
                        break;
            //prints customer list
            case 'P':   printList(list);
                        break;
            //test the application
            case 'U':   testUtilties(list);
                        break;
        }
    }
    //closes the application and clears the BST tree
    list = BST_Destroy (list);
    return 0;
}

//create a Binary search tree function
BST_TREE* BST_Create (int  (*compare) (void* argu1, void* argu2))
{
    //local Definition
	BST_TREE* tree;

    //allocates memory for the tree
	tree = (BST_TREE*) malloc (sizeof (BST_TREE));
	if (tree)
	   {
        //set the tree to point to null with 0 for count
	    tree->root    = NULL;
	    tree->count   = 0;
	    tree->compare = compare;
	   }

	return tree;
}

//Inserts a node into the tree
bool BST_Insert (BST_TREE* tree, void* dataPtr)
{
	NODE* newPtr;

	newPtr = (NODE*)malloc(sizeof(NODE));
	if (!newPtr)
	   return false;

	newPtr->right   = NULL;
	newPtr->left    = NULL;
	newPtr->dataPtr = dataPtr;

	if (tree->count == 0)
	    tree->root  =  newPtr;
	else
	    _insert(tree, tree->root, newPtr);

	(tree->count)++;
	return true;
}

//insert a new node in the tree, recursive function
NODE* _insert (BST_TREE* tree, NODE* root, NODE* newPtr)
{
	if (!root)
	   return newPtr;

	// Locate null subtree for insertion
	if (tree->compare(newPtr->dataPtr,
	                  root->dataPtr) < 0)
	   {
	    root->left = _insert(tree, root->left, newPtr);
	    return root;
	   } // new < node
	else
	   // new data >= root data
	   {
	    root->right = _insert(tree, root->right, newPtr);
	    return root;
	     } // else new data >= root data
	return root;
}	// _insert

//Delete a specific node in a tree
bool BST_Delete (BST_TREE* tree, void* dltKey)
{
//	Local Definitions
	bool  success;
	NODE* newRoot;

//	Statements
	newRoot = _delete (tree, tree->root, dltKey, &success);
	if (success)
	   {
	    tree->root = newRoot;
	    (tree->count)--;
	    if (tree->count == 0)
	        // Tree now empty
	        tree->root = NULL;
	   } // if
	return success;
}  // BST_Delete

//BST delete recursive function
NODE*  _delete (BST_TREE* tree, NODE* root, void* dataPtr, bool* success)
{
// Local Definitions
	NODE* dltPtr;
	NODE* exchPtr;
	NODE* newRoot;
	void* holdPtr;

//	Statements
	if (!root)
	   {
	    *success = false;
	    return NULL;
	   } // if

	if (tree->compare(dataPtr, root->dataPtr) < 0)
	     root->left  = _delete (tree,    root->left,
	                            dataPtr, success);
	else if (tree->compare(dataPtr, root->dataPtr) > 0)
	     root->right = _delete (tree,    root->right,
	                            dataPtr, success);
	else
	    // Delete node found--test for leaf node
	    {
	     dltPtr = root;
	     if (!root->left)
	         // No left subtree
	         {
	          free (root->dataPtr);       // data memory
	          newRoot = root->right;
	          free (dltPtr);              // BST Node
	          *success = true;
	          return newRoot;             // base case
	         } // if true
	     else
	         if (!root->right)
	             // Only left subtree
	             {
	              newRoot = root->left;
	              free (dltPtr);
	              *success = true;
	              return newRoot;         // base case
	            } // if
	         else
	             // Delete Node has two subtrees
	             {
	              exchPtr = root->left;
	              // Find largest node on left subtree
	              while (exchPtr->right)
	                  exchPtr = exchPtr->right;

	              // Exchange Data
	              holdPtr          = root->dataPtr;
	              root->dataPtr    = exchPtr->dataPtr;
	              exchPtr->dataPtr = holdPtr;
	              root->left       =
	                 _delete (tree,   root->left,
	                          exchPtr->dataPtr, success);
	             } // else
	    } // node found
	return root;
}	// _delete

//searches tree for a specific node
void* BST_Retrieve  (BST_TREE* tree, void* keyPtr)
{
	//check if there is a BST
	if (tree->root)
		//goes into the retrieve function
	    return _retrieve (tree, keyPtr, tree->root);
	else
	    return NULL;
}

//searches tree for a specific node recusive function
void* _retrieve (BST_TREE* tree, void* dataPtr, NODE* root)
{
	//check if there is a root
	if (root)
	    {
			//goes through the list recursively
			if (tree->compare(dataPtr, root->dataPtr) < 0)
				return _retrieve(tree, dataPtr, root->left);
			else if (tree->compare(dataPtr, root->dataPtr) > 0)
				return _retrieve(tree, dataPtr, root->right);
			else
				// found the node, output the pointer to that specific node
				return root->dataPtr;
	    }
	else
	    //no data in the tree
	    return NULL;
}

//process tree using inorder traversal
void BST_Traverse (BST_TREE* tree, void (*process) (void* dataPtr))
{
	//start the traverse process
	_traverse (tree->root, process);
	return;
}

//inorder tree traverse, used from function BST_Traverse
void _traverse (NODE* root, void (*process) (void* dataPtr))
{
	//check if there is a root/tree
	if  (root)
		{
			//goes through the tree recursively
			_traverse (root->left, process);
			process   (root->dataPtr);
			_traverse (root->right, process);
		}
	return;
}

//check if the BST is empty
bool BST_Empty (BST_TREE* tree)
{
	//check the tree count if there is no nodes
	return (tree->count == 0);
}

//check if the BST is full
bool BST_Full (BST_TREE* tree)
{
	//set a node pointer to the new node
	NODE* newPtr;

	//set the new node
	newPtr = (NODE*)malloc(sizeof (*(tree->root)));
	//check if creating is success
	if (newPtr)
	   {
		   //true then there is memory to hold a node so clear the tmp node and return false
			free (newPtr);
			return false;
	   }
	else
		//since
	     return true;
}

//return number of nodes in the tree
int BST_Count (BST_TREE* tree)
{
	//return the tree count
	return (tree->count);
}

//deletes all data in the tree
BST_TREE* BST_Destroy (BST_TREE* tree)
{
	//check if there is a BST tree
	if (tree)
		_destroy (tree->root);

	// free the tree since there is no more nodes
	free (tree);
	return NULL;
}

//deletes all data in the tree
void _destroy (NODE* root)
{
	//check if there is a BST tree
	if (root)
	   {
	    _destroy (root->left);
	    free (root->dataPtr);
	    _destroy (root->right);
	    free (root);
	   }
	return;
}

//menu for the program
char Options  (void)
{
	//set the variable for the menu option
	char option;

	//set a variable for a error check
	bool error;

	//prints out to the terminal the main menu for the application
	printf("\n\n");
	printf("+============================================================+\n");
	printf("|          welcome to Lab 9: Project 7.22 from book          |\n");
	printf("|         Please select what operation you want to do        |\n");
	printf("|-----+------------------------------------------------------|\n");
	printf("|  A  |    Add a Customer                                    |\n");
	printf("|  D  |    Delete a Customer                                 |\n");
	printf("|  F  |    Find a Customer                                   |\n");
	printf("|  P  |    Print Phone List                                  |\n");
	printf("|  U  |    Show Utilities                                    |\n");
	printf("+-----+------------------------------------------------------+\n");
	printf("|  Q  |    Quit                                              |\n");
	printf("+=====+======================================================+\n");


	do
	   {

		printf("\nPlease select the action you want to do: ");
		scanf(" %c", &option);
		option = toupper(option);

		//check what you typed and compare to the actually selection
		if   (option == 'A' || option == 'D' || option == 'F' || option == 'P' || option == 'U' || option == 'Q')
			error = false;

		//if the user accident misstyped
		else
			{
			printf("|========================================|\n");
			printf("|  you missed type, please try again :D  |\n");
			printf("|========================================|\n");
			error = true;
			}
		//continue until error becomes false
		} while (error == true);
	return option;
}

//add a customer fo the tree
//list: points to the tree
void addCust (BST_TREE* list)
{
	//set a new customer pointer
	CUSTOMERS* custPtr;
	//set a temp variables to capitalize the name
    char ctmp;
    int i,L;

	//allocate memory for the new node
	custPtr = (CUSTOMERS*)malloc (sizeof (CUSTOMERS));

	//if it fails to allocate, memory error
	if (!custPtr)
	    printf("Memory Overflow in add\n"), exit(101);

	//success, now enter the data for the new customer
	printf("Enter Customer name   ");
	scanf ("%s",  custPtr->names);

	//will set the first character of the name to a uppercase so all is the same
	ctmp = toupper(custPtr->names[0]);
	custPtr->names[0] = ctmp;

	//set the name after the comma a capital
	L=strlen(custPtr->names);
    for(i=0;i<L;i++)
	{
	    if(custPtr->names[i] == ',' && custPtr->names[i+1] != '\0')
	    {
	        ctmp = toupper(custPtr->names[i+1]);
	        custPtr->names[i+1] = ctmp;
	    }
	}

	//enter the data for the phone number
    printf("Enter Customer Phone Number: ");
	scanf ("%s", custPtr->phonenumbers);

	//insert customer into the tree
	BST_Insert (list, custPtr);
}

//delete a customer from the tree
//list: point to the tree
void deleteCust (BST_TREE* list)
{
	//set up a temp field to input the name to be deleted
	int i,L;
	char  name[40],ctmp;
	char* namePtr = name;

	//ask the user what custome to delete
	printf("Enter Customer Name to DELETE: ");
	scanf ("%s", namePtr);

    //set the first character capital
	ctmp = toupper(name[0]);
	name[0] = ctmp;

    L=strlen(name);
	//set the second part of the name, first letter to a capital
	for(i=0;i<L;i++)
	{
	    if(name[i] == ',' && name[i+1] != '\0')
	    {
	        ctmp = toupper(name[i+1]);
	        name[i+1] = ctmp;
	    }
	}

	//delete the customer and if it fails, then it will print no student found
	if (!BST_Delete (list, namePtr))
	   printf("ERROR: No Customer: %10s\n", namePtr);
}

//find a customer and prints there name and telephone number
void findCust (BST_TREE* list)
{
	//set a name character for user to use to find the customer
	char      findname[40],ctmp;
	int i,L;

	//sets a pointer that will point to a customer
	CUSTOMERS* CustPtr;

	//user input to get the customer name
	printf("Enter customer name: ");
	scanf ("%s", findname);

    //set the first character capital
	ctmp = toupper(findname[0]);
	findname[0] = ctmp;

    L=strlen(findname);
	//set the second part of the name, first letter to a capital
	for(i=0;i<L;i++)
	{
	    if(findname[i] == ',' && findname[i+1] != '\0')
	    {
	        ctmp = toupper(findname[i+1]);
	        findname[i+1] = ctmp;
	    }
	}

	//set the customer pointer to what the BST_retrieve found
	CustPtr = (CUSTOMERS*)BST_Retrieve (list, &findname);

	//if there is data, it will print it out
	if (CustPtr)
	   {
	    printf("\nCustomer name: %s\n",    CustPtr->names);
	    printf("Customer phone number:  %s\n", CustPtr->phonenumbers);
	   }

	//if it fails there there is no name in file
	else
	   printf("Customer %s not in file\n", findname);
}

//print a list of customers
//list: points to the tree
void printList  (BST_TREE* list)
{
	//header of the list to be printed out
	printf("\n\n");
	printf("+======================+==================+\n");
	printf("| Customer Names       | Telephone number |\n");
	printf("+----------------------+------------------+\n");

	//prints out each customer
	BST_Traverse (list, processCust);

	//footer of the list to be printed out
	printf("+======================+==================+\n\n\n");
	return;
}

//this will test the tree and print results
//tree: points to the BST tree
void testUtilties (BST_TREE* tree)
{
	//print out how many nodes are in the program
	printf("Tree contains %3d nodes: \n", BST_Count(tree));
	if (BST_Empty(tree))
	    printf("The tree IS empty\n");
	else
	    printf("The tree IS NOT empty\n");

	//checks if the tree is full or empty
	if (BST_Full(tree))
	    printf("The tree IS full\a\n");
	else
	    printf("The tree IS NOT full\n");
	return;
}

//compare two customers with the name
//low -1, equal 0, high +1
//stu1
int  compareCust (void* Cust1, void* Cust2)
{
	//set temp holders for the customer
	CUSTOMERS C1;
	CUSTOMERS C2;

	//set the temps to the actual customer
	C1 =  *(CUSTOMERS*)Cust1;
	C2 =  *(CUSTOMERS*)Cust2;

	//check if the first customer is less than the second
	if ( strncmp(C1.names,C2.names,20) < 0)
	      return -1;

	//check if the first customer is equal than the second
	if ( strncmp(C1.names,C2.names,20) == 0)
	      return 0;

	//returns true if the first customer is more than the second
	return +1;
}

//prints the customer name and phonenumber
//CustPtr: points to the customer
void processCust (void* CustPtr)
{
	//set a temp structure to print out the list
	CUSTOMERS aCust;

	//set aCust to the current customer its pointing to
	aCust = *(CUSTOMERS*)CustPtr;

	//prints out to the screen(consol/terminal)
	printf("| %-20s | %-16s |\n", aCust.names, aCust.phonenumbers);

	//return back to the program
	return;
}

//adds data from a file to the BST
//list: points to the BST tree
//*file_list: points to the file we are getting the data from
void addfromlist (BST_TREE* list, FILE *file_list)
{
	//set a temp holder for name
	char tmpname[40]={0};

	//set a temp holder for phonenumber
	char tmpphonenumber[20]={0};

	//set a temp node to hold the data for the customer
	CUSTOMERS* custPtr;

	//loops until there is nothing in the file
	while( fscanf(file_list,"%s %s", tmpname, tmpphonenumber) == 2)
	{
		//setup the customer pointer
		custPtr = (CUSTOMERS*)malloc (sizeof (CUSTOMERS));

		//if run out of memory, close
		if (!custPtr)
		   printf("Memory Overflow in add\n"), exit(101);

		//copy the tmpname string to the customer node
		strncpy(custPtr->names,tmpname,40);

		//copy the phonenumber string to the customer node
		strncpy(custPtr->phonenumbers, tmpphonenumber,20);

		//insert the new node into the Binary Search Tree
		BST_Insert (list, custPtr);
	}
}
