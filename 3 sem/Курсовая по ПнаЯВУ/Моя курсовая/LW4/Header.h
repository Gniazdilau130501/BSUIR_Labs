#pragma once
#include <iostream>
#include <string>

using namespace std;

class transrport
{
protected:
	string name;
	int price;
	int maxspeed;
public:
	transrport()
	{
		name = "";
		price = 0;
		maxspeed = 0;
	}
	string getName()
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