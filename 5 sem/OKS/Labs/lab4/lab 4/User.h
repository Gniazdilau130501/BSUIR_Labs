#pragma once
#include <windows.h>
#include <iostream>
#include "conio.h"
#include <vector>
#include <stdlib.h>
#include <stack>
#include <cmath>
using namespace std;

class USER
{
private:
	string name;
	string nameFrom;
	string dataTo;
	string dataFrom;
public:
	USER();
	string GetName();
	string GetDataTo();
	string GetDataFrom();
	string GetNameFrom();
	void Write(string name2, HANDLE handle, int* coll, string data);
	void SetDataTo(string data);
	void SetDataFrom(string data);
	void SetNameFrom(string data);
};
