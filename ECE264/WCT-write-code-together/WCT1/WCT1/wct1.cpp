#include <iostream>
#include <iomanip>
using namespace std;

int main()
{
	double cel;

	cout <<  setw(30) << "Fahrenheit" << setw(30) << "Celsius \n";
	for (int fah = 0; fah <=212; fah++) {

		cel = 5.0/9.0*(fah -32);
		cout << setw(30) << noshowpos << fah << setw(30) <<setprecision(3) << fixed 
			<< showpos << cel << '\n';

	}
	return 0;



}