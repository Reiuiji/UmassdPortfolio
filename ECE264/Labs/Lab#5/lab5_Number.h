/*
ECE 264 Lab 5
File:lab5_Number.h
Created by Daniel Noyes
*/
//complex class which will manage a complex number (a+bj)
//has the features of adding and subtracting
class Complex
{
public:
    Complex();
    Complex(double Real, double Imag);
    void setReal(double Real);
    double getReal();
    void setImag(double Imag);
    double getImag();
    void AddComplex(Complex);
    void SubComplex(Complex) ;
    void Display(double,double);
private:
    double real;
    double imag;
};
