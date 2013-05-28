//lab 3: AccountTest.cpp
#include <iostream>
#include <iomanip>
using namespace std;
#include "lab3_Account.h"

int main()
{
	//set the account balance to test the program
	Account account1(50);
	Account account2(0);

	//output the account balance to the user
	cout << "account1 balance: $" << account1.getBalance() << endl;
	cout << "account2 balance: $" << account2.getBalance() << endl;

	//ask the user to input a withdrawal anount
	int withdrawalAmount;
	cout << "\nEnter withdrawal amount for account1: ";
	cin >> withdrawalAmount;
	//tells the user how much they took out
	cout << "\nsubtracting " << withdrawalAmount << " From account1 balance\n\n";

	//withdrawl from account 1
	account1.debit(withdrawalAmount);

	//tells the new balance
	cout << "account1 balance: $" << account1.getBalance() << endl;
	cout << "account2 balance: $" << account2.getBalance() << endl;

	//ask the user to output amount from account 2
	cout << "\nEnter withdrawal amount for account2: ";
	cin >> withdrawalAmount;

	//tells how much is taken from account 2
	cout << "\nsubtracting " << withdrawalAmount << " From account2 balance\n\n";

	//withdral from account2
	account2.debit(withdrawalAmount);

	//output the new balance
	cout << "account1 balance: $" << account1.getBalance() << endl;
	cout << "account2 balance: $" << account2.getBalance() << endl;
}
