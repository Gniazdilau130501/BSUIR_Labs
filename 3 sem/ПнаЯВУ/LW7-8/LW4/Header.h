#pragma once
#include <iostream>
#include <string>

using namespace std;

class transrport
{
protected:
	char name[10];
	int price;
	int maxspeed;
public:
	transrport()
	{
		//name = {" "};
		price = 0;
		maxspeed = 0;
	}
	void setName()
	{
		cin>> name;
	}
	char *getName()
	{
		return name;
	}
	int getPrice()
	{
		return price;
	}
	int getMS()
	{
		return maxspeed;
	}
};