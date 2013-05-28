//Lab 3: Account.cpp
//Member-function for class Account
#include <iostream>
#include "lab3_Account.h"
using namespace std;

//initiates the ballance for the account
Account::Account(int initialBalance)
{
	balance = 0;

	if(initialBalance > 0)
		balance = initialBalance;
	//there cant be a negative balance unless u owe money
	if(initialBalance < 0)
		cout << "Error: Initial balance cannot be negative.\n" << endl;
}

//will add to the account (credit)
void Account::credit(int amount)
{
	balance = balance + amount;
}

//will sub from the account (debit)
void Account::debit(int amount)
{
	if(balance >= amount)
	{
		balance = balance - amount;
	}
	//you cant grab more than you got
	else
		cout << "Debit amount exceeded account balance.\n" << endl;
}

//output the current balance of the program
int Account::getBalance()
{
	return balance;
}
