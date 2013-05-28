//Lab:4     Employee.h
//Create by Daniel Noyes

//employee function
 //set up the employee with there name and salary
 //public access functions
class Employee
{
    public:
    Employee(string,string,double);
    //set employee first name
    void setEmployeeFirstName(string);
    //return the employee's first name
    string getEmployeeFirstName();
    //set employee last name
    void setEmployeeLastName(string);
    //return the employee's last name
    string getEmployeeLastName();
    //set the salary
    void setSalary(double);
    //returns the employee's salary
    double getSalary();
    //display the employee's information
    void Display(int);

//private functions
private:
    //employee first name
    string EmployeeFirstName;
    //employee last name
    string EmployeeLastName;
    //employee salary
    double EmployeeSalary;

};
