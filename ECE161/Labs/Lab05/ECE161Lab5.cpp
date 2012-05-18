/* ECE161lab5 project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.

*/

//stops the secure warnings
#define _CRT_SECURE_NO_WARNINGS

//grabs the standard input output libraries
#include <stdio.h>

//sets the Euclid's algorithm funcition
int gcd(int m, int n);

//main
int main()
{
	//define variables
	int x,y,z;

	//print the output information
	printf("Enter two non-negative integers: ");
	
	//input for the two intergers
	scanf("%d %d", &x, &y);
	while(x>0 && y > 0)
	{
	//execute the gcd command
	z=gcd(x, y);

	//prints the output of the gcd command to the screen
	printf("\n%d\n",z);

	//print the output information
	printf("Enter two non-negative integers: ");
	
	//input for the two intergers
	scanf("%d %d", &x, &y);
	}
	return 0;
}

int gcd(int m, int n)
{

//check if n eauals zero, if it is true it will return the value of m in the function
	if (n == 0)
		return m;

//check if n does not equal zero, if the argument is true then it will do a recursion loop of the function untill it find the gcd
	if (n != 0)
		return gcd(n,m%n);

}