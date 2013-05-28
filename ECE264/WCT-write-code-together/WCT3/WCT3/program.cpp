#include <iostream>
using namespace std;
#include "Time.h"

int main ()
{
 	Time t;

 	t.setTime(11,30,00);
 	cout << "The time is: ";
 	t.printUniversal();
 	cout << " or ";
 	t.pritnStandard();
 	cout << endl;
int h, m, s;
 	cout << "Enter time (h m s): ";
 	cin >> h >> m >> s;
 	cout << "Setting time ...\n";

 	t.setTime(h,m,s);
 	cout << "The time is: ";
 	t.printUniversal();
 	cout << " or ";
 	t.pritnStandard();
 	cout << endl;

 	return 0;
}
