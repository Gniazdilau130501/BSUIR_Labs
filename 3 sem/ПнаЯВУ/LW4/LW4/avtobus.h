#pragma once
#include "passag.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>

class avtobus :public passag
{
protected:
	int rashod;
public:
	int getRashod()
	{
		return rashod;
	}
	void setRashod()
	{
		cin >> rashod;
	}
	avtobus()
	{
		name = "no_name";
		rashod = 0;
	}

	void shapka();
	friend istream& operator >> (istream& in, avtobus& obj);
	friend ostream& operator << (ostream& out, avtobus& obj);
	void setting();
	void poisk(string str);
	void poisk2(int num);
};