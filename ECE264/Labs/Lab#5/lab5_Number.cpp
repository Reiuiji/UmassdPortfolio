/*
ECE 264 Lab 5
File:lab5_Number.cpp
Created by Daniel Noyes
*/

#include "lab5_Number.h"
#include <iostream>
#include <iomanip>

//main functions needed for the class (for output)
using std::cout;
using std::setw;
Complex::Complex()
{
    setReal(0);
    setImag(0);
}
//will set the object to the current value
Complex::Complex(double Real, double Imag)
{
    setReal(Real);
    setImag(Imag);
}

//will set the real complex value for the object
void Complex::setReal(double Real)
{
    real = Real;
}

//will return the real value
double Complex::getReal()
{
    return real;
}

//will set the imaginary complex value for the object
void Complex::setImag(double Imag)
{
    imag = Imag;
}

//will return the imaginary value
double Complex::getImag()
{
    return imag;
}

//This will add a complex object with this object
//it will output the values added and what was the result
void Complex::AddComplex(Complex obj)
{
    //display the first complex
    Complex::Display(getReal(), getImag());
    cout << " + ";
    //display the second complex
    Complex::Display(obj.getReal(), obj.getImag());
    cout << " = ";
    //output the sum
    Complex::Display(getReal()+obj.getReal(), getImag()+obj.getImag());
    cout << "\n";
}

//This will subtract a complex object with this object
//it will output the values added and what was the result
void Complex::SubComplex(Complex obj)
{
    //display the first complex
    Complex::Display(getReal(), getImag());
    cout << " - ";
    //display the second complex
    Complex::Display(obj.getReal(), obj.getImag());
    cout << " = ";
    //output the results
    Complex::Display(getReal()-obj.getReal(), getImag()-obj.getImag());
    cout << "\n";
}

//display the real and imaginary in a format of (a,b)
void Complex::Display(double Real,double Imag)
{
    cout << " (" << setw(2) << Real << "," << setw(2) << Imag <<") ";
}
