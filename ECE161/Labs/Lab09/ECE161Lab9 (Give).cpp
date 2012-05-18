/*
* [ECE161Lab9
* ECE161Lab9: ECE161Lab9 program
*
* Copyright (C) 2012 Daniel Noyes <Reiuiji@gmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct students
{
    char names[40];
    char phonenumbers[20];
} students;

typedef struct node
{
    void*           dataPtr;
    struct node*    left;
    struct node*    right;
} NODE;

typedef struct bst_tree
{
    int     count;
    int (*compare) (void* argu1, void* argu2);
    NODE* root;
} BST_TREE;

    //prototype Declarations

    BST_TREE* BST_Create (int (*compare) (void* argu1, void* argu2));
    BST_TREE* BST_Destroy (BST_TREE* tree);
	bool  BST_Insert   (BST_TREE* tree, void* dataPtr);
	bool  BST_Delete   (BST_TREE* tree, void* dltKey);
	void* BST_Retrieve (BST_TREE* tree, void* keyPtr);
	void  BST_Traverse (BST_TREE* tree, void (*process)(void* dataPtr));
	bool BST_Empty (BST_TREE* tree);
	bool BST_Full  (BST_TREE* tree);
	int  BST_Count (BST_TREE* tree);
	static NODE* _insert (BST_TREE* tree, NODE* root, NODE* newPtr);
	static NODE* _delete (BST_TREE* tree, NODE* root, void* dataPtr, bool* success);
	static void* _retrieve (BST_TREE* tree, void* dataPtr, NODE* root);
	static void _traverse (NODE* root, void (*process) (void* dataPtr));
	static void _destroy (NODE* root);

    //	Prototype Declarations
    char getOptions    (void);
    void addstu       (BST_TREE* list);
    void deletestu    (BST_TREE* list);
    void findstu      (BST_TREE* list);
    void printList    (BST_TREE* list);
    void testUtilties (BST_TREE* tree);
    int  comparestu   (void* stu1, void* stu2);
    void processstu   (void* dataPtr);
	void addlist (BST_TREE* list, FILE *file_list);

//main
int main()
{
    BST_TREE* list;
    char    selection = ' ';
	FILE *DATA;
	list = BST_Create (comparestu);


	if ((DATA=fopen("lab9_file.txt","rt")) == NULL)
	{
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)\n");
		printf("I am going to skip the inputing from a file");
		exit(0);
	}

    addlist(list, DATA);

	//menu
    while ((selection = getOptions()) != 'Q')
    {
        switch(selection)
        {
            case 'A':   addstu(list);
                        break;
            case 'D':   deletestu(list);
                        break;
            case 'F':   findstu(list);
                        break;
            case 'P':   printList(list);
                        break;
            case 'U':   testUtilties(list);
                        break;
        }
    }
    //closes the application and clears the BST tree
    list = BST_Destroy (list);
    return 0;
}

/* ============================================================ */
/* ============================================================ */

/*	================= BST_Create ================
	Allocates dynamic memory for an BST tree head
	node and returns its address to caller
	   Pre    compare is address of compare function
	          used when two nodes need to be compared
	   Post   head allocated or error returned
	   Return head node pointer; null if overflow
*/
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
}// BST_Create
/*	================= BST_Insert ===================
	This function inserts new data into the tree.
	   Pre    tree is pointer to BST tree structure
	   Post   data inserted or memory overflow
	   Return Success (true) or Overflow (false)
*/
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
}// BST_Insert
/*	==================== _insert ====================
	This function uses recursion to insert the new data
	into a leaf node in the BST tree.
	   Pre    Application has called BST_Insert, which
	          passes root and data pointer
	   Post   Data have been inserted
	   Return pointer to [potentially] new root
*/
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
/* ================== BST_Delete ==================
	This function deletes a node from the tree and
	rebalances it if necessary.
	   Pre    tree initialized--null tree is OK
	          dltKey is pointer to data structure
	                 containing key to be deleted
	   Post   node deleted and its space recycled
	          -or- An error code is returned
	   Return Success (true) or Not found (false)
*/
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
/*	==================== _delete ====================
	Deletes node from the tree and rebalances
	tree if necessary.
	   Pre    tree initialized--null tree is OK.
	          dataPtr contains key of node to be deleted
	   Post   node is deleted and its space recycled
	          -or- if key not found, tree is unchanged
	   Return success is true if deleted; false if not found
	          pointer to root
*/
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
/*	==================== BST_Retrieve ===================
	Retrieve node searches tree for the node containing
	the requested key and returns pointer to its data.
	   Pre     Tree has been created (may be null)
	           data is pointer to data structure
	                containing key to be located
	   Post    Tree searched and data pointer returned
	   Return  Address of matching node returned
	           If not found, NULL returned
*/
void* BST_Retrieve  (BST_TREE* tree, void* keyPtr)
{
	if (tree->root)
	    return _retrieve (tree, keyPtr, tree->root);
	else
	    return NULL;
}	// BST_Retrieve
/*	===================== _retrieve =====================
	Searches tree for node containing requested key
	and returns its data to the calling function.
	   Pre     _retrieve passes tree, dataPtr, root
	           dataPtr is pointer to data structure
	              containing key to be located
	   Post    tree searched; data pointer returned
	   Return  Address of data in matching node
	           If not found, NULL returned
*/
void* _retrieve (BST_TREE* tree, void* dataPtr, NODE* root)
{
	if (root)
	    {
			if (tree->compare(dataPtr, root->dataPtr) < 0)
				return _retrieve(tree, dataPtr, root->left);
			else if (tree->compare(dataPtr, root->dataPtr) > 0)
				return _retrieve(tree, dataPtr, root->right);
			else
				return root->dataPtr;
	    }
	else
	    return NULL;
}	// _retrieve
/*	=================== BST_Traverse ===================
	Process tree using inorder traversal.
	   Pre   Tree has been created (may be null)
	         process ÒvisitsÓ nodes during traversal
	   Post  Nodes processed in LNR (inorder) sequence
*/
void BST_Traverse (BST_TREE* tree, void (*process) (void* dataPtr))
{
	_traverse (tree->root, process);
	return;
}  // end BST_Traverse
/*	=================== _traverse ===================
	Inorder tree traversal. To process a node, we use
	the function passed when traversal was called.
	   Pre   Tree has been created (may be null)
	   Post  All nodes processed
*/
void _traverse (NODE* root, void (*process) (void* dataPtr))
{
	if  (root)
		{
			_traverse (root->left, process);
			process   (root->dataPtr);
			_traverse (root->right, process);
		}
	return;
}  // _traverse
/*	=================== BST_Empty ==================
	Returns true if tree is empty; false if any data.
	   Pre      Tree has been created. (May be null)
	   Returns  True if tree empty, false if any data
*/
bool BST_Empty (BST_TREE* tree)
{
	return (tree->count == 0);
}	// BST_Empty
/*	===================== BST_Full ====================
	If there is no room for another node, returns true.
	   Pre      tree has been created
	   Returns  true if no room for another insert
	            false if room
*/
bool BST_Full (BST_TREE* tree)
{
	NODE* newPtr;

	newPtr = (NODE*)malloc(sizeof (*(tree->root)));
	if (newPtr)
	   {
			free (newPtr);
			return false;
	   }
	else
		//since
	     return true;
}	// BST_Full
/*	=================== BST_Count ==================
	Returns number of nodes in tree.
	   Pre     tree has been created
	   Returns tree count
*/
int BST_Count (BST_TREE* tree)
{
	return (tree->count);
}	// BST_Count
/*	=============== BST_Destroy ==============
	Deletes all data in tree and recycles memory.
	The nodes are deleted by calling a recursive
	function to traverse the tree in inorder sequence.
	   Pre      tree is a pointer to a valid tree
	   Post     All data and head structure deleted
	   Return   null head pointer
*/
BST_TREE* BST_Destroy (BST_TREE* tree)
{
	if (tree)
		_destroy (tree->root);

	free (tree);
	return NULL;
}	// BST_Destroy
/*	=============== _destroy ==============
	Deletes all data in tree and recycles memory.
	It also recycles memory for the key and data nodes.
	The nodes are deleted by calling a recursive
	function to traverse the tree in inorder sequence.
	   Pre      root is pointer to valid tree/subtree
	   Post     All data and head structure deleted
	   Return   null head pointer
*/
void _destroy (NODE* root)
{
	if (root)
	   {
	    _destroy (root->left);
	    free (root->dataPtr);
	    _destroy (root->right);
	    free (root);
	   }
	return;
}	// _destroy

/* ============================================================ */
/* ============================================================ */

/*	===================== getOption =====================
	Reads and validates processing option from keyboard.
	    Pre  nothing
	    Post valid option returned
*/
char getOptions  (void)
{
	char option;
	bool error;

	printf("\n ======  MENU  ======\n");
	printf(" A   Add Student\n");
	printf(" D   Delete Student\n");
	printf(" F   Find Student\n");
	printf(" P   Print Class List\n");
	printf(" U   Show Utilities\n");
	printf(" Q   Quit\n");


	do
	   {

		printf("\nEnter Option: ");
		scanf(" %c", &option);
		option = toupper(option);

		if   (option == 'A' || option == 'D' ||
              option == 'F' || option == 'P' ||
              option == 'U' || option == 'Q')
			error = false;

		else
			{
			printf("Invalid option. Please re-enter: ");
			error = true;
			}
		} while (error == true);
	return option;
}	// getOption

/*	====================== addStu ======================
	Adds a student to tree.
	    Pre  nothing
	    Post student added (abort on memory overflow)
*/
void addstu (BST_TREE* list)
{
	students* stuPtr;

	stuPtr = (students*)malloc (sizeof (students));

	if (!stuPtr)
	    printf("Memory Overflow in add\n"), exit(101);

	printf("Enter stuomer name   ");
	scanf ("%s",  stuPtr->names);

    printf("Enter stuomer Phone Number: ");
	scanf ("%s", stuPtr->phonenumbers);

	BST_Insert (list, stuPtr);
}	// addStu

/*	===================== deleteStu ====================
	Deletes a student from the tree.
	    Pre  nothing
	    Post student deleted or error message printed
*/
void deletestu (BST_TREE* list)
{
	char  name[40];
	char* namePtr = name;

	printf("Enter stuomer Name to DELETE: ");
	scanf ("%s", namePtr);

	if (!BST_Delete (list, namePtr))
	   printf("ERROR: No Student: %10s\n", namePtr);
}	// deleteStu

/*	====================== findStu ======================
	Finds a student and prints name and telephonenumber.
	    Pre  student name
	    Post student data printed or error message
*/
void findstu (BST_TREE* list)
{

	char      findname[40];

	students* stuPtr;

	printf("Enter stuomer name: ");
	scanf ("%s", findname);

	stuPtr = (students*)BST_Retrieve (list, &findname);

	if (stuPtr)
	   {
	    printf("\nstuomer name: %s\n",    stuPtr->names);
	    printf("stuomer phone number:  %s\n", stuPtr->phonenumbers);
	   }

	else
	   printf("stuomer %s not in file\n", findname);
}	// findStu

/*	==================== printList ======================
	Prints a list of students.
	    Pre  list has been created (may be null)
	    Post students printed
*/
void printList  (BST_TREE* list)
{

	printf("  stuomer Names         Telephone number  \n");

	BST_Traverse (list, processstu);
	printf("\n\n");
	return;
}	// printList

/*	=================== testUtilties ==================
	This function tests the ADT utilities by calling
	each in turn and printing their results.
	   Pre  tree has been created
	   Post Results printed
*/
void testUtilties (BST_TREE* tree)
{
	printf("Tree contains %3d nodes: \n", BST_Count(tree));
	if (BST_Empty(tree))
	    printf("The tree IS empty\n");
	else
	    printf("The tree IS NOT empty\n");

	if (BST_Full(tree))
	    printf("The tree IS full\a\n");
	else
	    printf("The tree IS NOT full\n");
	return;
}	// testUtilities

/*	====================== compareStu ======================
	Compare two student id's and return low, equal, high.
	    Pre  stu1 and stu2 are valid pointers to students
	    Post return low (-1), equal (0), or high (+1)
*/
int  comparestu (void* stu1, void* stu2)
{
	students s1;
	students s2;

	s1 =  *(students*)stu1;
	s2 =  *(students*)stu2;

	if ( strncmp(s1.names,s2.names,20) < 0)
	      return -1;

	if ( strncmp(s1.names,s2.names,20) == 0)
	      return 0;

	return +1;
}	// compareStu

/*	=================== processStu =====================
	Print one student's data.
	    Pre  stu is a pointer to a student
	    Post data printed and line advanced
*/
void processstu (void* stuPtr)
{
	students astu;

	astu = *(students*)stuPtr;

	printf("| %-20s | %-16s |\n", astu.names, astu.phonenumbers);

	return;
}   //processstu
/*	=================== addlist =====================
	Add student's data from a list.
*/
void addlist (BST_TREE* list, FILE *file_list)
{

	char name[40]={0};

	char number[20]={0};

	students* stuPtr;

	while( fscanf(file_list,"%s %s", name, number) == 2)
	{
		stuPtr = (students*)malloc (sizeof (students));

		if (!stuPtr)
		   printf("Memory Overflow in add\n"), exit(101);

		strncpy(stuPtr->names,name,40);
		strncpy(stuPtr->phonenumbers, number,20);
		BST_Insert (list, stuPtr);
	}
}
