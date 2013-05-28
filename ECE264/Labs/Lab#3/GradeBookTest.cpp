// Lab3: GradeBookTest.cpp
#include <iostream>
using namespace std;
#include "lab3_GradeBook.h"

int main()
{
	//create a new grade book for a class and a professor
	GradeBook gradeBook("CS101 Introduction to C++ Programing", "Sam Smith");
	//display the class detail
    gradeBook.displayMessage();

	//change instructors name
    gradeBook.changeInstructorName("Judy Jones");
	//display with the new instructor
    gradeBook.displayMessage();

}
