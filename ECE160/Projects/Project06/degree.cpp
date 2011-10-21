float dms2deg(int d, int m, int s)
{
	return d+(m*(1.0/60.0))+(s*(1.0/60.0)*(1.0/60.0));
}
void deg2dms(float dd, int *adr_d, int *adr_m, int *adr_s)
{
	while (dd>=((1.0/60.0)*(1.0/60.0)))
	{
		*adr_d=0,*adr_m=0,*adr_s=0;
		//calculate d
		{
		while (dd >= 1)
			{
				(*adr_d)++;
				dd -= 1;
			}
		}
		//calculate d
		{
		while (dd >= (1.0/60.0))
			{
				(*adr_m)++;
				dd -= (1.0/60.0);
			}
		}
		//calculate d
		{
		while (dd >= ((1.0/60.0)*(1.0/60.0)))
			{
				(*adr_s)++;
				dd -= ((1.0/60.0)*(1.0/60.0));
			}
		}
	}
}

