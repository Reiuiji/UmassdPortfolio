#include <stdio.h>
#include <time.h>
#define cyan  "\033[4;36m"  //out put the color cyan to the screen with underline
#define red   "\033[0;31m"  //out out red
#define none   "\033[0m"    //reset the terminal color

int main(void)
{
    time_t rawtime;
    struct tm *timeinfo;

    time(&rawtime);
    timeinfo = localtime(&rawtime);

    printf("%s\n",none);

    printf("%sHello world my name is %sDaniel Noyes%s\n",none,cyan,none);
    printf("%sToday's Date is %s%s\n",none,red,asctime(timeinfo));

    printf("%s",none); //reset the terminal to the normal color
    return 0;
}
