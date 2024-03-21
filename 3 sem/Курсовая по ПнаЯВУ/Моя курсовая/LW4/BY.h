#pragma once
#include "legkovie.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>
class BY : public legkovie
{
protected:
	string gorod;
	int probeg;
public:
	BY();
	string getGorod();
	int getProbeg();
	friend istream& operator >> (istream& in, BY& obj);
	friend ostream& operator << (ostream& out, BY& obj);
	friend ofstream& operator << (ofstream& out, BY& obj);
	friend ifstream& operator >> (ifstream& in, BY& obj);
	void setting();
	void shapka();
	bool operator==(BY& obj);
};