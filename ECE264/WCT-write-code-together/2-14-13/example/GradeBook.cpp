// Adapted from Fig. 3.5: fig03_05.cpp
// NOTE: See web for #includes
// GradeBook class implementation
#include <iostream>
#include "GradeBook.h"
using namespace std;

// function that sets the course name
void GradeBook::setCourseName( string name ) {      
      courseName = name; // store the course name in the object
} // end function setCourseName
   
// function that gets the course name
string GradeBook::getCourseName() {
      return courseName; // return the object's courseName
} // end function getCourseName

// function that displays a welcome message
void GradeBook::displayMessage() {
	   cout << "Welcome to the grade book for\n" << courseName << "!"
		<< endl;
} // end function displayMessage
