#include <iostream>
#include <string>
//include iomanip to manipulate the cout string for the output data
#include <iomanip>

using namespace std;

int main()
{
	string Name, Account, Major, FavRestaurant, FavDartmouth;


	//Prompts the user for general information
	cout << "\nInput the given information:\n";
	cout << "\nFull Name: ";
	getline(cin, Name);
	cout << "\nYour account name: ";
	getline(cin, Account);
	cout << "\nYour Major(s): ";
	getline(cin, Major);
	cout << "\nA favorit restaurant: ";
	getline(cin, FavRestaurant);
	cout << "\nA favorite place in Dartmouth: ";
	getline(cin, FavDartmouth);
	cout << "\nSome interesting additional information: ";
	

	//start output table format
	cout << "\n\n\n" << left;
	cout << "+==========================================================================+\n";

	//output the given data for the various information the user inputed
	//all output is allighned in a table

	cout << "|" << setw(30) << "Full Name:" 				 << setw(40) << Name 			<< "    |\n";
	cout << "|" << setw(30) << "Account Name"				 << setw(40) << Account			<< "    |\n";
	cout << "|" << setw(30) << "Favorite Restaurant" 		 << setw(40) << Major 			<< "    |\n";
	cout << "|" << setw(30) << "Favorite Place in Dartmouth" << setw(40) << FavRestaurant 	<< "    |\n";
	cout << "|" << setw(30) << "Interesting information" 	 << setw(40) << FavDartmouth 	<< "    |\n";

	cout << "+==========================================================================+\n\n";
	//end output table format

	//returns 0 to indicate that the program was successful
	return 0;
}
