/* project 2 - convert project
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#include <stdio.h>

int main()
{

float initial, final, inc, k, r, f, s;
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
        printf("           Km/Hr        Rods/Min  Frlngs/Frtnght      Smoots/sec\n");
        for (k=initial; k<=final; k=k+inc)
        {
            r=k*3.314;
            f=k*1670.24576;
            s=k*0.163225865;
            printf("%16.2f%16.2f%16.2f%16.2f\n",k,r,f,s);      
        }
    
    
    
        printf("Enter initial:");
        scanf("%f", &initial);
        printf("Enter final:");
        scanf("%f",&final);
        printf("Enter Increment:");
        scanf("%f",&inc);

}
}