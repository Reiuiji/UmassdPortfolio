/* project 2 - convert project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

int main()
{

float initial, final, inc, k, r, f, s;
/*
variables meaning:
initial=initial value
final=final value
inc=increment value
k=kilometers/hour
r=rods/min
f=furlongs/fortnight
s=smooths/second
*/
printf("Welcome to the convert program\n");
printf("This will produce a chart showing equivalent for the following:\n");
printf("=============\nKilometers/hours\nrods/min\nfurlongs/fortnight\nsmoots/seconds\n\n=============\n");
printf("Enter initial:");
scanf("%f", &initial);
printf("Enter final:");
scanf("%f",&final);
printf("Enter Increment:");
scanf("%f",&inc);



    while (inc != 0.0)
    {
		printf("_________________________________________________________________\n");
        printf("           Km/Hr        Rods/Min  Frlngs/Frtnght      Smoots/sec\n");
		printf("_________________________________________________________________\n");
        for (k=initial; k<=final; k=k+inc)
        {
            r=k*3.314;
            f=k*1670.24576;
            s=k*0.163225865;
            printf("|%15.2f|%15.2f|%15.2f|%15.2f|\n",k,r,f,s);    
			//the %16.2f means the float is allocated 16 spaces in the print function with two decimal spaces.
        }
		printf("|_______________|_______________|_______________|_______________|\n");
    
    
        printf("Enter initial:");
        scanf("%f", &initial);
        printf("Enter final:");
        scanf("%f",&final);
        printf("Enter Increment:");
        scanf("%f",&inc);

}
		printf("Goodbye");
}