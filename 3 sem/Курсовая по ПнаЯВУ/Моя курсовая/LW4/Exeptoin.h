#pragma once
#include "shablon.h"
class Exeption
{
private:
	string err;
	int m;
public:
	//Exeption(const Exeption& temp);
	Exeption(int num, const string str);
	~Exeption();
	void show();
};
string chek_str();
int chek_num();