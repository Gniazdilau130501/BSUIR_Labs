#pragma once
#include "avtobusi.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>
class electrobus :public avtobusi
{
protected:
	int PotrebEnerg;
public:
	electrobus();
	int getPE();
	void shapka();
	friend istream& operator >> (istream& in, electrobus& obj);
	friend ostream& operator << (ostream& out, electrobus& obj);
	friend ofstream& operator << (ofstream& out, electrobus& obj);
	friend ifstream& operator >> (ifstream& in, electrobus& obj);
	void setting();
	bool operator==(electrobus& obj);
};