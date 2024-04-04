#pragma once
#include <windows.h>
#include <iostream>
#include "conio.h"
#include <vector>
#include <stdlib.h>
#include <stack>
#include <cmath>
#include <thread>
using namespace std;

struct USER
{
	string name;
	string dataFrom;
	string nameFrom;
	string nameTo;
	string dataTo;
	USER* next;
	int marker = 0;
};

class list
{
private:
	USER* head, * tail;
	int marker;
public:
	USER* GetHead();
	list();
	int* GetMarker();
	void SetMarker(int m);
	void add();
	void GetList();
	void SendData(HANDLE handle1, HANDLE handle2);
	void GetInfo();
};
