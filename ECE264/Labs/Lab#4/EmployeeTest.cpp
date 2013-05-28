//Lab:4     EmployeeTest.cpp
//Create by Daniel Noyes
//
#include <iostream>
using namespace std;
#include "Employee.h"

//main
int main()
{
    //sets two empoyee's with there information and salary values
    Employee employee1("Bob","Jones",34500);
    Employee employee2("Susan","Baker",37800);

    //output the employee information withe the given empolyee number
    employee1.Display(1);
    employee2.Display(2);

    //increase salary by 10% by times setting the value to 1.1 and setting it back to the employee
    employee1.setSalary(1.1*employee1.getSalary());
    employee2.setSalary(1.1*employee2.getSalary());

    //tells user you have increase the salary
    cout << "\nIncrease the employees salary by 10%\n\n";

    //output the new values for the employee
    employee1.Display(1);
    employee2.Display(2);

    return 0;
}
