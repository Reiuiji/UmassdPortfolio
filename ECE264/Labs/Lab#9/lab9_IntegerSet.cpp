/*
ECE 264 Lab 9
File:lab9_IntegerSet.cpp
Created by Daniel Noyes
*/
#include <iostream>
#include <iomanip>
using namespace std;

#include "lab9_IntegerSet.h"
//setup a variable array
IntegerSet::IntegerSet( int array[], int size)
{
    emptySet();

    for(int i=0; i < size; i++)
        insertElement(array[i]);
}
//input to a set
void IntegerSet::inputSet()
{
    int number;

    do
    {
        cout << "Enter an element (-1 to end): ";
        cin >> number;
        if(validEntry(number))
            set[number] = 1;
        else if (number != -1)
            cerr << "Invalid Element\n";

    }
    while (number != -1);

    cout << "Emtry complete\n";
}
//checks to see if the set is empty
void IntegerSet::emptySet()
{
    for(int v=0; v<101; v++)
        set[v] = 0;
}

//print the set
void IntegerSet::printSet() const
{
    int x = 1;
    bool empty = true;

    cout << '{';

    for(int u = 0; u<101; u++)
    {
        if(set[u]) //print out the content if there in the set (1)
        {
            cout << setw(4) << u << (x%10 == 0 ? "\n" : "");
            empty = false;
            ++x;
        }
    }
    if(empty)
        cout << setw(4) << "---";

    cout << setw(4) << "}" << "\n";
}

//output the union of the sets
IntegerSet IntegerSet::unionOfSets( const IntegerSet &r)
{
    IntegerSet temp;

    //checks to see if there is a valus is a 1 in the two array. if so then print the value
    for(int n=0; n<101; n++)
        if(set[n] == 1|| r.set[n] == 1)
            temp.set[n] = 1;

    return temp;
}

//intersectionOfSets: grab the values in both sets that have the same values.
IntegerSet IntegerSet::intersectionOfSets( const IntegerSet &r)
{
    IntegerSet temp;
    for(int n=0; n<101; n++)
        if((set[n] == 1) && (r.set[n] == 1))
            temp.set[n] = 1;

    return temp;
}

//insert into the set
void IntegerSet::insertElement( int k)
{
    if(validEntry(k)) //checks if the input is valid
        set[k] = 1;
    else
        cerr << "Invalid insert attempted!\n";
}

//deleteElement in the set
void IntegerSet::deleteElement(int m)
{
    if(validEntry(m))
        set[m] = 0;
    else
        cerr << "Invalid delete attempted!\n";
}

//check to see if the integer is equal
bool IntegerSet::isEqualTo(const IntegerSet &r)
{
    for(int v=0; v<101; v++)
        if(set[v] != r.set[v])
            return false;

    return true;
}
