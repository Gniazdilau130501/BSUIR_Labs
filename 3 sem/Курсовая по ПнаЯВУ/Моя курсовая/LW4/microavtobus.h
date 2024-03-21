#pragma once
#include "avtobusi.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>

class microavtobus :public avtobusi
{
protected:
	int rashod;
public:
	microavtobus();
	int getRashod();
	void shapka();
	friend istream& operator >> (istream& in, microavtobus& obj);
	friend ostream& operator << (ostream& out, microavtobus& obj);
	friend ofstream& operator << (ofstream& out, microavtobus& obj);
	friend ifstream& operator >> (ifstream& in, microavtobus& obj);
	void setting();
	bool operator==(microavtobus& obj);
};