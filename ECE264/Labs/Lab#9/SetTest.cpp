/*
ECE 264 Lab 9
File:SetTest.cpp
Created by Daniel Noyes
*/
#include <iostream>
using namespace std;

#include "lab9_IntegerSet.h"

int main()
{
    IntegerSet a,b,c,d;

    cout << "Enter set A:\n";
    a.inputSet();
    cout << "\nEnter set B:\n";
    b.inputSet();
    //unionOfSet for a and b argument -> result to c
    c = a.unionOfSets(b);
    //intersecitonOfSets for a passing b -> result to d
    d = a.intersectionOfSets(b);
    cout << "\nUnion of A and B is:\n";
    c.printSet();
    cout << "Intersection of A and B is:\n";
    d.printSet();

    if(a.isEqualTo(b))
        cout << "Set A is equal to set B\n";
        else
        cout << "Set A is not eqal to set B\n";

        cout << "\nInserting 77 into set A...\n";
        a.insertElement(77);
        cout << "Set A is now:\n";
        a.printSet();
        cout << "\nDeleting 77 from set A...\n";
        a.deleteElement(77);
        cout << "Set A is Now:\n";
        a.printSet();

        const int arraySize = 10;
        int intArray[ arraySize] = { 25, 67, 2, 9, 99, 105, 45, -5, 100, 1};
        IntegerSet e( intArray, arraySize);

        cout << "\nSet e is:\n";
        e.printSet();

        cout << endl;
        return 0;
}
