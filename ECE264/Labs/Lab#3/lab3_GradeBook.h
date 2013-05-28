//Lab 3 lab3_GradeBook.h
#include <string>
using namespace std;
//Gradebook class
class GradeBook
{
//all the public access functions
public:
	GradeBook(string, string);
	string getCourseName();
	string getInstructorName();
	void setCourseName(string);
	void setInstructorName(string);
	void changeInstructorName(string);
	void displayMessage();

//private internal functions
private:
	string courseName;
	string InstructorName;
};
