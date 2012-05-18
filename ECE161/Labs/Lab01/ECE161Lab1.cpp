/* ECE161lab1 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/

#include <stdio.h>
//set the limit of the number of items your doing in the array
#define NUMLIST 10
//extend will have the array price times quantity which will equal the amount
void extend(float x[], float y[], float z[],int NUM);

int main()
{
	int i,NUM=NUMLIST;
	float price[NUMLIST]={10.62, 14.89, 13.21, 16.55, 18.62, 9.47, 6.58, 18.32, 12.15, 3.98};
	float quantity[NUMLIST]={4, 8.5, 6, 7.35, 9, 15.3, 3, 5.4, 2.9, 4.8};
	float amount[NUMLIST];

	extend(price,quantity,amount,NUM);
	//print the top of the list pool
	printf("____________________________\n");
	printf("| Price  |Quantity| Amount |\n");
	//print the data of prive wuantity and amount
	for (i=0;i<NUMLIST;i++)
	{
		printf("|--------|--------|--------|\n");
		printf("| %6.2f | %6.2f | %6.2f |\n",price[i],quantity[i],amount[i]);
	}
	//end the list pool
	printf("|==========================|\n");

}

void extend(float x[], float y[], float z[], int NUM)
{
	int i;
	for(i=0;i<NUM;i++)
	{
		z[i]=x[i]*y[i];
	}
}