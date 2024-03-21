#pragma once
#include "legkovie.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>
#include <fstream>

class salon : public legkovie
{
protected:
	string garant;
	string test;
public:
	salon();
	string getGarant();
	string getTest();
	friend istream& operator >> (istream& in, salon& obj);
	friend ostream& operator << (ostream& out, salon& obj);
	friend ofstream& operator << (ofstream& out, salon& obj);
	friend ifstream& operator >> (ifstream& in, salon& obj);
	void setting();
	void shapka();
	bool operator==(salon& obj);
};