//Point Function
#include <iostream>
#include <iomanip>
#include <utility>
#include "Point.h"

//function that will set the point (2D)
void Point::Point(double Xval, double Yval) {
    setX(Xval);
    setY(Yval);
}

void Point::setX(double Xval) {
    X=Xval;
}

int Point::getX() {
    return X;
}

void Point::setY(double Yval) {
    Y=Yval;
}

int Point::getY() {
    return Y;
}

//function that will grab the point value
//pair<double,double> Point::getPoint() {
//	return std::pair<double,double>(getX(),getY());
//}


//dislay the point location
void Point::displayPoint() {

	std::cout << "Current location is at : " << X << "," << Y << std::endl;
}

//function to accelerate the Point, add to point
void Point::Move(double Xinc, double Yinc, double time) {

	X = X + Xinc*time;
	Y = Y + Yinc*time;
}

