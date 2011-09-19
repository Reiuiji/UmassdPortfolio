/* project 1 - quadratic
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#include <stdio.h>
#include <math.h>
int main()
{
float a, b, c, z, x, y ;


printf("Hello, This is a quadratic equation solver\n") ;
printf("ax^2+bx+c\n") ;
printf("Enter the Values for a, b, c  ") ;
scanf("%f %f %f", & a, & b, &c) ;
printf("%.2f^2 + %.2fx + %.2f = 0\n", a, b, c) ;

if ( a == 0)
{
    printf("x=-c/b\n") ;
    x = (-c) / b ;
    printf("root %.2f\n", x) ;
   
}
    else
    {
        z = (pow(b,2)-4*a*c);
        if (z>0)
        {
        x = ((-b) + sqrt( pow(b, 2) -4*a*c))/(2*a);
        y = ((-b) - sqrt( pow(b, 2) -4*a*c))/(2*a);
        printf("root %.2f %.2f\n", y, x);
        }
        if (z==0)
        {
        x = (-b)/(2*a);
        printf("roots %.2f\n", x);
        }

        if (z<0)
        printf("no real roots, sorry\n");
    }
}