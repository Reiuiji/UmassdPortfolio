//numtest.cpp
/*
ECE 264 Lab 5
File:numtest.cpp
Created by Daniel Noyes
*/
#include "lab5_Number.h"
int main()
{
    //set the complex numbers
    Complex a(1,7),b(9,2),c(10,1),d(11,5),e;
    //test add function
    a.AddComplex(b);
    //test sub function
    c.SubComplex(d);

    e.AddComplex(b);
    return 0;
}
