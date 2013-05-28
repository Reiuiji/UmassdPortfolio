
class Point {
private:
	double xval, yval;
public:
	Point(double x, double y);
	double getxval();
	double getyval();

	//caculate the distance
	double dis(Point other);
	//add or substract two points
	Point add(Point b);
	Point sub(Point b);
	//movign the exting point
	void move(double a, double b);
	void print();
};
