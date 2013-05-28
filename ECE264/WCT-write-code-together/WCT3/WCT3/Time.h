class Time 
{

public:
	Time();
	void setTime(int, int, int);
	void getTime(int &, int &, int &);
	void printUniversal();
	void pritnStandard();

private:
	int hour;
	int minute;
	int second;

};