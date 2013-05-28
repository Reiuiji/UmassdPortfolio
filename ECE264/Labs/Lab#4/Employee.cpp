//Lab:4     Employee.cpp
//Create by Daniel Noyes
//
#include <iostream>
#include <string>
using namespace std;
#include "Employee.h"


//setup the employee
Employee::Employee(string Fname,string Lname,double sal)
{
    setEmployeeFirstName(Fname);
    setEmployeeLastName(Lname);
    setSalary(sal);
}

//sets the employee first name
void Employee::setEmployeeFirstName(string Fname)
{
    EmployeeFirstName = Fname;
}

//returns the employee first name
string Employee::getEmployeeFirstName()
{
    return EmployeeFirstName;
}

//set the employee last name
void Employee::setEmployeeLastName(string Lname)
{
    EmployeeLastName = Lname;
}

//returns the employee last name
string Employee::getEmployeeLastName()
{
    return EmployeeLastName;
}

//set the employee salary
void Employee::setSalary(double sal)
{
    if(sal < 0)
        EmployeeSalary = 0;
    else
        EmployeeSalary = sal;
}

//return the salary
double Employee::getSalary()
{
    return EmployeeSalary;
}

//output the empoyees information
void Employee::Display(int num)
{
    cout << "Employee " << num << ": "<< getEmployeeFirstName() << " " << getEmployeeLastName() << "; Yearly Salary: " << getSalary() << endl;
}
