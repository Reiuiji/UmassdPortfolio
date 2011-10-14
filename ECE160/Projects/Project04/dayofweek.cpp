/* project 
I, Daniel Noyes, certify that this is my own work and I have not collaborated with anyone else.
I encourage the use of this program as OPEN SOURCE.
*/
#include <stdio.h>

int main()
{
	int m,d,y,l,nd,md=0,td;
		/*
		m=month
		d=day
		y=year
		nd=number of days
		md=total days based on prevoius months
		td=total days
		*/
	printf("Welcome to the day of week calculator\n");
	printf("Please enter the date (m d y):  ");
	scanf("%d %d %d",&m,&d,&y);
	

	while(m!=0 && d!=0 && y!=0)
	{
		printf("%2d/%2d/%2d => ",m,d,y);

		//calculate the number of days in the previous years
		nd=((y-1)*365+(y-1)/4-(y-1)/100+(y-1)/400);

		//inputs 1 more day for leap year
		if(!(y%4) && (y%100) && m>=3 || !(y % 400) && m>=3)
			l=1;
		else
			l=0;

		//calculate days from the month
		md=0;
		if (m>1)
			md=md+31;
		if (m>2)
			md=md+28+l;
		if (m>3)
			md=md+31;
		if (m>4)
			md=md+30;
		if (m>5)
			md=md+31;
		if (m>6)
			md=md+30;
		if (m>7)
			md=md+31;
		if (m>8)
			md=md+31;
		if (m>9)
			md=md+30;
		if (m>10)
			md=md+31;
		if (m>11)
			md=md+30;

		//add all the days together
	 	td=nd+md+d;

		//print day based on the total days
		switch(td%7)
		{
			case 0: {printf("Sunday");break;}
			case 1: {printf("Monday");break;}
			case 2: {printf("Tuesday");break;}
			case 3: {printf("Wednesday");break;}
			case 4: {printf("Thursday");break;}
			case 5: {printf("Friday");break;}
			case 6: {printf("Saturday");break;}
		}

		printf("\n\nWelcome to the day of week calculator\n");
		printf("Please enter the date (m d y):  ");
		scanf("%d %d %d",&m,&d,&y);
	}

}

