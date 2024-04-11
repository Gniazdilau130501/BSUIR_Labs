#pragma once
#include <iostream>
//#include <ostream>
#include <string>
//#include <Windows.h>
//#include <conio.h>
//#include <iomanip>

using namespace std;

class transrport
{
protected:
	string name;
	int MadeYear;
	int maxspeed;
public:
	transrport()
	{
		name = "";
		MadeYear = 0;
		maxspeed = 0;
	}
	void setName()
	{
		cin >> name;
	}
	void setMY()
	{
		cin>>MadeYear;
	}
	void setMS()
	{
		cin>>maxspeed;
	}
	string getName()
	{
		return name;
	}
	int getMY()
	{
		return MadeYear;
	}
	int getMS()
	{
		return maxspeed;
	}
	/*virtual void shapka(){}*/
};
