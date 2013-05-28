#include <iostream>
//include iomanip to manipulate the cout string for the output data
#include <iomanip>
using namespace std;

int main()
{
	int number1, number2, number3, smallest, largest;
	float sum, product;
	//output the prompt for the user
	cout << "\nInput three different integers: ";
	//inputs the data
	cin >> number1 >> number2 >> number3;

	//predefine largest as a numerical value of num1
	largest = number1;
	//calculates the Largest number out of the three
	//checks if the smallest is less than num2, true then num2 is larger
	if(largest < number2)
		largest = number2;
	//continue check for largest with num3
	if(largest < number3)
		largest = number3;

	//calculates the smallest number out of the three
	smallest = number1;
	//checks if the smallest is greater than num2, if so then num2 is smaller
	if(smallest > number2)
		smallest = number2;
	//checks for the smallest with num3
	if(smallest > number3)
		smallest = number3;

	//calculates the sum of the three numbers
	sum=number1+number2+number3;

	//calculates the product of the three numbers
	product=number1*number2*number3;

	//start output table format
	cout << "\n";
	cout << "+========================+\n" << left;

	//output the data in a common format with will go with the box
	//goes border then name with a 12 width alighned to the left
	//then the numerical result with another width for format
	//then the border again

	cout << "|" << setw(12) << "Sum:      " << setw(8) << sum 		<< "    |\n";
	cout << "|" << setw(12) << "Average:  " << setw(8) << sum/3		<< "    |\n";
	cout << "|" << setw(12) << "Product:  " << setw(8) << product 	<< "    |\n";
	cout << "|" << setw(12) << "Smallest: " << setw(8) << smallest 	<< "    |\n";
	cout << "|" << setw(12) << "Largest:  " << setw(8) << largest 	<< "    |\n";

	cout << "+========================+\n\n";
	//end output table format

	//returns 0 to indicate that the program was successful
	return 0;
}
