/*
ECE 264 Lab 7
File:Dice.cpp
Created by Daniel Noyes
*/
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
using namespace std;

int main()
{
    const long ROLLS = 36000;
    const int SIZE = 12;

    //possible expected rolls for each from 1 - 12
    int expected[SIZE] = {0,1,2,3,4,5,6,5,4,3,2,1};
    int sum[SIZE] = {0};

    int x;
    int y;

	//seed the random
    srand(time(0));

	//random role rutine
    for( int i = 0 ; i<ROLLS ; i++)
    {
		//rand % 6 will generate a number from 0-5 for the array
        x = rand()%(SIZE/2) +1;
        y = rand()%(SIZE/2) +1;
		//increment the sum array for the current num
        sum[x+y-1]++;
    }
    {

	//output layout
    cout << setw(10) << "Sum" << setw(10) << "Total" << setw(10)
         << "Expected" << setw(10) << "Actual\n" << fixed << showpoint;

	//print the content rolled with expected and actual
    for( int j=1; j<SIZE; j++)
    cout << setw(9) << j+1 << setw(10) << sum[j]
         << setprecision(3) << setw(9)
         << 100.0*expected[j]/36 << "%" << setprecision(3)
         << setw(9) << 100.0*sum[j]/ROLLS << "%\n";
    }
}


