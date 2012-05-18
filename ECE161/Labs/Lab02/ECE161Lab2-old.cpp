/* ECE161lab2 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

This Lab recieves data from a txt document for name, quantity, and price and outputs
the data on another file (out) with amount and total amount on the bottom
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//set the limit of the number of items your doing in the array
#define NUMLIST 100
//extend will have the array price times quantity which will equal the amount
void extend(float x[], float y[], float z[],int NUM);

int main()
{
	int i=0,NUM=0;
	float price[NUMLIST], quantity[NUMLIST], amount[NUMLIST],totalamount=0;
	char name[NUMLIST][12];

	FILE *DATA, *OUT;

	//set the input file
	if ((DATA=fopen("data2.txt","rt")) == NULL)
	{
		printf("Sorry Could not find the File\nIt might have ran away from you!\nmake sure it is in the same directory as me(Program)");
		exit(0);
	}

	//gathers the data from the data file
	while( fscanf(DATA,"%s %f %f\n", name[NUM], &quantity[NUM], &price[NUM]) ==3 )
	{
		NUM++;
	}
	//run the extend function which will calculate the amount each item
	extend(price,quantity,amount,NUM);
	//calculate the total amount over all the items
	for(i=0;i<NUM;i++)
	{
		totalamount=amount[i]+totalamount;
	}
	//pushes the data to a txt file (out2.txt)
	if ( (OUT=fopen("out2.txt", "wt")) == NULL)
	{
		printf("Sorry Could not find the File\nPlease Try puting the file in the same Directory as this Program");
		exit(2);
	}

	//print the top of the list pool
	fprintf(OUT,"__________________________________________________\n");
	fprintf(OUT,"|  num  |     Name     | Price  |Quantity| Amount |\n");
	//print the data of prive wuantity and amount
	for (i=0;i<NUM;i++)
	{
		fprintf(OUT,"|-------|--------------|--------|--------|--------|\n");
		fprintf(OUT,"|  %3d: | %12s | %6.2f | %6.2f | %6.2f |\n",(i+1),name[i],price[i],quantity[i],amount[i]);
	}
	//end the list pool
	fprintf(OUT,"|=======+==============+========+========+========|\n");
	fprintf(OUT,"|                                                 |\n");
	fprintf(OUT,"|        Total Amount : %8.2f                  |\n",totalamount);
	fprintf(OUT,"|_________________________________________________|\n");

	//end of program :D

}

void extend(float x[], float y[], float z[], int NUM)
{
	int i;
	for(i=0;i<NUM;i++)
	{
		z[i]=x[i]*y[i];
	}
}