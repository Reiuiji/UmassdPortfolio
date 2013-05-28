#include <iostream>
using namespace std;
#include <iomanip>
#include "Time.h"

Time::Time()
{
	hour =0;
	minute = 0;
	second =0;
}
void Time::setTime(int h, int m, int s){

	hour = h;
	minute = m;
	second =s;

}
void Time::getTime( int &h, int &m, int&s){

	h = hour;
	m = minute;
	s = second;
}
void Time::printUniversal()
{
	cout << setfill('0');
	cout << setw(2) << hour <<":";
	cout << setw(2) << minute <<":";
	cout << setw(2) << second ;
	cout << setfill(' ');

}

void Time::pritnStandard()
{
	cout << setfill('0');
	if (hour%12 ==0)
		cout << "12" <<":";
	else
		cout << setw(2) << hour%12 <<":";
	cout << setw(2) << minute <<":";
	cout << setw(2) << second;
	if (hour <12)
		cout << "AM";
	else
		cout <<"PM";
	cout <<setfill(' ');
}