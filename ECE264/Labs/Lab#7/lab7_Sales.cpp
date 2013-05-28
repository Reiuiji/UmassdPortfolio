/*
ECE 264 Lab 7
File:Sales.cpp
Created by Daniel Noyes
*/
#include <iostream>
#include <iomanip>
using namespace std;

int main()
{
    const int PEOPLE = 4;
    const int PRODUCTS = 5;

    double value;
    double totalSales;
    double productSales[ PRODUCTS ] = { 0.0 };
    double sales[PEOPLE][PRODUCTS] = { 0.0 };
    int salesPerson;
    int product;

    cout << "Enter the salesperson (1-4) , product number (1-5), and "
         << "total sales.\nEnter -1 for the salesperson to end input.\n";

    cin >> salesPerson;

    //constaly enter sale input until -1
    while(salesPerson != -1)
    {
        cin >> product >> value;
        //put product value into the current salesperson
        //salesPerson-1 because we want to use array[0] etc
        sales[salesPerson-1][product-1] = value;

        cin >> salesPerson;
    }

    cout << "\nThe total sales for each salesperson are displayed at the "
         << "end of teach row,\n" << "and the total sales for each product "
         << "are displayed at the bottom of each column.\n" << setw(12)
         << 1 << setw(12) << 2 << setw(12) << 3 << setw(12) << 4
         << setw(12) << 5 << setw(14) << "Total\n" << fixed << showpoint;

    //output the sales for each person
    for(int i=0;i<PEOPLE;i++)
    {
        //reset totalsales for the person
        totalSales = 0.0;
        cout << i+1;

        for(int j=0;j<PRODUCTS;j++)
        {
            //add the previous totalsale with the sales we are outputing
            totalSales = totalSales + sales[i][j];
            cout << setw(12) << setprecision(2) << sales[i][j];
            productSales[j] = productSales[j] + sales[i][j];
        }
        //output total sales for the person
        cout << setw(12) << setprecision(2) << totalSales << '\n';
    }
    //prints the total sale for each product
    cout << "\nTotal" << setw(8) << setprecision(2) << productSales[0];

    for(int j = 1; j < PRODUCTS; j++)
    {
        cout << setw(12) << setprecision(2) << productSales[j];
    }
    cout << endl;

    //ends the program
    return 0;
}
