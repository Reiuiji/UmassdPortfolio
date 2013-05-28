#include "Point.h"
#include <iostream>
using namespace std;

	Point::Point(double x, double y) {
		xval = x;
		yval =y;
	}
	double Point::getxval(){
		return xval;

	}
	double Point::getyval(){

		return yval;
	}

	//caculate the distance
	double Point::dis(Point other){
		double xd = xval - other.xval;
		double yd = yval - other.yval;
		return sqrt(xd*xd+yd*yd);

	}
	//add or substract two points
	Point Point::add(Point b){
		return Point(xval+b.xval, yval+b.yval);
	}
	Point Point::sub(Point b){

		return Point(xval-b.xval, yval-b.yval);
	}
	//movign the exting point
	void Point::move(double a, double b){

		xval=xval+a;
		yval=yval+b;
	}
	void Point::print() {
		 cout << "(" << xval << "," << yval << ")" << endl;

	}