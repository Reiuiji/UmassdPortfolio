#include <stdio.h>
#include <time.h>
#define cyan  "\033[4;36m"
#define red   "\033[0;31m"
#define none   "\033[0m"
#define none_underline   "\033[4;0m"

int main(void)
{
time_t rawtime;
struct tm *timeinfo;

time(&rawtime);
timeinfo = localtime(&rawtime);

printf("%s\n",none);

printf("%sHello world my name is %sDaniel Noyes%s\n",none_underline,cyan,none);
printf("%sToday's Date is %s%s\n",none_underline,red,asctime(timeinfo));

printf("%s",none); //reset the terminal to the normal color
return 0;
}
