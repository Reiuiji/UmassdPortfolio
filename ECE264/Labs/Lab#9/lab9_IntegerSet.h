/*
ECE 264 Lab 9
File:lab9_IntegerSet.cpp
Created by Daniel Noyes
*/
#ifndef INTEGER_SET_H
#define INTEGER_SET_H

//integer set class
class IntegerSet
{
public:
    IntegerSet()
    {//if there is no input then the entire set is set to a 0
        emptySet();
    };

    IntegerSet( int [], int);
    //return a union set from the given two integersets
    IntegerSet unionOfSets( const IntegerSet& );
    //find all the intersetions
    IntegerSet intersectionOfSets( const IntegerSet&);

    //empty the entire set
    void emptySet();
    //input the number into the set
    void inputSet();
    void insertElement(int);
    void deleteElement(int);
    void printSet() const;
    bool isEqualTo(const IntegerSet&);

private:
    int set[ 101 ];

    int validEntry( int x ) const
    {
        return (x>=0 && x<=100);
    };
};


#endif
