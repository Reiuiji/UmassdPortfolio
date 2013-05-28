#include "GradeBook.cpp"
#include <iostream>

using namespace std;

// function main begins program execution
int main()
{
   string nameOfCourse; // string of characters to store the course name
   GradeBook myGradeBook; // create a GradeBook object named myGradeBook
   
   // display initial value of courseName
   cout << "Initial course name is: " << myGradeBook.getCourseName() << endl;

   // prompt for, input and set course name
   cout << "\nPlease enter the course name:" << endl;
   getline( cin, nameOfCourse ); // read a course name with blanks
   myGradeBook.setCourseName( nameOfCourse ); // set the course name

   cout << endl; // outputs a blank line
   myGradeBook.displayMessage(); // display message with new course name
   return 0; // indicate successful termination
} // end main

