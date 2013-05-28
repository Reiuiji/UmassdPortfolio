#include <iostream>
#include <iomanip>

using namespace std;

int main()
{
	int min, max, Fahrenheit=0;
	float Celcius=0;

	cout << "Enter a Range for Fahrenheit\nmin: ";
	cin >> min;
	cout << "max: ";
	cin >> max;

	cout << "+===============================+\n";
	cout << "|  Fahrenheit   |    Celcius    |\n";
	cout << "|---------------|---------------|\n";

	cout.precision( 5 );

	for( Fahrenheit=min; Fahrenheit <= max; Fahrenheit++ )
	{
		Celcius=5.0/9.0*(Fahrenheit - 32);
		cout << left << "|      " << setw(9) << Fahrenheit << "|   " << setw(12) << Celcius << "|\n";
	}

	cout << "|               |               |\n";
	cout << "+===============|===============+\n";

	return 0;
}

