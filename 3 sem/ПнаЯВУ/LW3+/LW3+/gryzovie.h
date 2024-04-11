#pragma once
#include "Header.h"
class gryzovie : public transrport
{
protected:
	int MaxWeith;
	int hight;
public:
	gryzovie()
	{
		MaxWeith = 0;
		hight = 0;
	}
	void setMW()
	{
	   cin>> MaxWeith;
	}
	void setHight()
	{
		cin>>hight;
	}
	int getMW()
	{
		return MaxWeith;
	}
	int getHight()
	{
		return hight;
	}
};
