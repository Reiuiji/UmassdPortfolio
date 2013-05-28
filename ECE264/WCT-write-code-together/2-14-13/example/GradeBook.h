// Adapted from Fig. 3.5: fig03_05.cpp
// NOTE: See web for #includes
// GradeBook class interface

class GradeBook
{
public:
   // function that sets the course name
   void setCourseName( std::string name );
   
   // function that gets the course name
   std::string getCourseName();

   // function that displays a welcome message
   void displayMessage();

private:
   std::string courseName; // course name for this GradeBook
}; // end class GradeBook  

