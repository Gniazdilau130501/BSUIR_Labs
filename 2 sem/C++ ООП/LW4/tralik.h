#pragma once
#include "passag.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>
class tralik :public passag
{
protected:
	int PotrebEnerg;
public:
	int getPE()
	{
		return PotrebEnerg;
	}
	void setPE()
	{
		cin >> PotrebEnerg;
	}
	tralik()
	{
		name = "no_name";
		PotrebEnerg = 0;
	}
	void shapka();
	friend istream& operator >> (istream& in, tralik& obj);
	friend ostream& operator << (ostream& out, tralik& obj);
	void setting();
	void poisk(string str);
	void poisk2(int num);
};