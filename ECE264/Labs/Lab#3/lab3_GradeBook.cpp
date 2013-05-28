//Lab 3 lab3_GradeBook.cpp
#include <iostream>
using namespace std;
#include "lab3_GradeBook.h"

//set the gradebook with a course and a instructor tag
GradeBook::GradeBook(string course, string Instructor)
{
	setCourseName(course);
	setInstructorName(Instructor);
}

//set the course name
void GradeBook::setCourseName(string name)
{
	courseName = name;
}

//return the course name
string GradeBook::getCourseName()
{
	return courseName;
}

//set the instructor name
void GradeBook::setInstructorName(string name)
{
	InstructorName = name;
}

//this will change the instructor to a new one
void GradeBook::changeInstructorName(string name)
{
	InstructorName = name;
	cout << "Changing Instructor name to " << name << endl;
	cout << "\n";
}

//return the instructor name
string GradeBook::getInstructorName()
{
	return InstructorName;
}

//output the course and intrurctor name neatly
void GradeBook::displayMessage()
{
	cout << "Welcome to the grade book for\n" << getCourseName() << "!" << endl;
	cout << "This Course is presented by: " << getInstructorName() << endl;
	cout << "\n";
}
