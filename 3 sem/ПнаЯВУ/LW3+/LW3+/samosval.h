#pragma once
#include "gryzovie.h"
#include <Windows.h>
#include <conio.h>
#include <iomanip>

class samosval : public gryzovie
{
protected:
	string type;
	string klass;
public:
	samosval()
	{
		name = "no_name";
		type = "неизветсный";
		klass = "неизветсный";
	}
	void setType()
	{
		cin>>type;
	}
	void setKlass()
	{
		cin>>klass;
	}
	string getType()
	{
		return type;
	}
	string getKlass()
	{
		return klass;
	}
	friend istream& operator >> (istream& in, samosval& obj);
	friend ostream& operator << (ostream& out, samosval& obj);
	void setting();
	void shapka();
};
