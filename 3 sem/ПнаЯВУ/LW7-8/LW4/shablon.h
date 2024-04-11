#pragma once
#include <iostream>
#include <string>
#include <conio.h>
#include <iomanip>
#include <Windows.h>
#include"salon.h"
#include "File.h"
using namespace std;

template <class A>
struct ochered
{
	A object;
	ochered* p_right;
	ochered* p_left;
};

template <class A>
class shablon
{
private: 
	int size;
	ochered<A>* p_first = nullptr;
	ochered<A>* p_last = nullptr;
public:
	shablon();
	~shablon();
	void getObj(A t);
	ochered<A>* getFirst();
	void add(A p);
	void del();
	void nastr();
	void out();
	bool poisk(A peremennaia);
    void writeF();
    void readF();
    void  del_all();
};