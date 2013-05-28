class Point
{
public:
	//constructor
	Point();
	Point(double, double);

	//set X point
	void setX(double);

	//get X point
	int getX();

	//set Y point
	void setY(double);

	//get Y point
	int getY();

	//function that will set the point (2D)
	double Point(double, double);

	//function that will grab the point value
//	pair<double,double>  getPoint();

	//dislay the point location
	void displayPoint();

	//function to move the Point, add to point
	void Move(double, double, double);



private:
	double X;	//X cordinate
	double Y;	//Y cordinate
};
