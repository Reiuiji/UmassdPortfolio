//lab 3: Account.h
//Definition of Account class.

class Account
{
//the public functions for Account
public:
	Account(int);
	void credit(int);
	//subtract amount from the account
	void debit(int);
	//grabs the balance for the account
	int getBalance();	
//private functions for Account
private:
	int balance;	//balance for the accounts
};
