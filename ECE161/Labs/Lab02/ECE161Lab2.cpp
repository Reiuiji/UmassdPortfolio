/* ECE161lab2 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

This Lab recieves data from a txt document for name, quantity, and price and outputs
the data on another file (out) with amount and total amount on the bottom
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//set the limit of the number of items your doing in the array
#define NUMLIST 100
//extend will have the array price times quantity which will equal the amount

int main()
{
	//time to go crazy with comments XD
	//define int for a temp num (i) and number of items
	int i=0,NUM=0;
	//define the float variable for price, quantity, amount, and total amount for the data
	float price, quantity, amount,totalamount=0;
	//define the name array to hold the item name
	char name[12];
	//set the variable for input and output file
	FILE *DATA, *OUT;

	//set the input file (data2.txt)
	if ((DATA=fopen("data2.txt","rt")) == NULL)
	{
		//display input not found
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)");
		//exit the program "EXIT_FAILURE"
		exit(0);
	}
	//sets the output file (out2.txt)
	if ( (OUT=fopen("out2.txt", "wt")) == NULL)
	{
		//display output file not found
		printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
		//exit the program "EXIT_FAILURE"
		exit(2);
	}

	//print the top of the list pool
	fprintf(OUT,"__________________________________________________\n");
	fprintf(OUT,"|  num  |     Name     | Price  |Quantity| Amount |\n");


	//gathers the data from the data file
	while( fscanf(DATA,"%s %f %f", name, &quantity, &price) ==3 )
	{
		//calculates the amount based on the price and quantity
		amount=price*quantity;
		//calculate the total amount cost for the items
		totalamount+=amount;
		//print the data of price quantity and amount
		fprintf(OUT,"|-------|--------------|--------|--------|--------|\n");
		fprintf(OUT,"|  %3d: | %12s | %6.2f | %6.2f | %6.2f |\n",(NUM+1),name,price,quantity,amount);
		//set the number of items that will be displayed
		NUM++;
	}


	//end the list pool
	fprintf(OUT,"|=======+==============+========+========+========|\n");
	fprintf(OUT,"|                                                 |\n");
	fprintf(OUT,"|        Total Amount :  $ %-8.2f               |\n",totalamount);
	fprintf(OUT,"|_________________________________________________|\n");

	//print the total amount and the tells where the out put file it located
	printf("|================================================|\n");
	printf("|  All finished calculating the amount per item  |\n");
	printf("|      you can open up the data on out2.txt      |\n");
	printf("|             Total Amount : $ %-8.2f          |\n",totalamount);
	printf("|================================================|\n");

	return (0);
	//return with interger type data, return without error
	//end of program :D

}