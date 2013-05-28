//Lab:4     CalcTest.cpp
//Create by Daniel Noyes
//

#include <iostream>
#include <iomanip>
#include "SimpleCalculator.h"
using namespace std;

//declarations
void Display(string operation, double val);

//main
int main()
{
    //set test values, to test the program
    double a = 10.0;
    double b = 20.0;

    //define the object sc as the simplecalculator class
    SimpleCalculator sc;
    //output to the user with the results
    cout <<"+==============================+\n" << left;
    Display("Value:   a",a);
    Display("Value:   b",b);
    cout <<"+==============================+\n";

    //addition
    double addition = sc.addition(a, b);
    Display("Add:   a+b",addition);

    //subtraction
    double subtraction = sc.subtract(a, b);
    Display("Sub:   a-b",subtraction);

    //multiplication
    double multiplication = sc.multiply(a, b);
    Display("Mul:   a*b",multiplication);

    //division
    double division = sc.division(a, b);
    Display("Div:   a/b",division);

    //finish the output
    cout <<"+==============================+\n" << endl;
    //return 0 to tell the program exited correctly
    return 0;
}
void Display(string operation, double val)
{
        cout << "|" << setw(14) << operation << "|   " << setw(12) << val << "|\n";
}
