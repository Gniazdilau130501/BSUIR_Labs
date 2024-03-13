#pragma once
#include <iostream>
#include <ostream>
#include <string>
#include <Windows.h>
#include <conio.h>
#include <iomanip>

using namespace std;

class transrport
{
protected:
	string name;
	int MadeYear;
	int maxspeed;
public:
	transrport()
	{
		name = "неизвеснтый";
		MadeYear = 0;
		maxspeed = 0;
	}
	void setName()
	{
		cout << name<<endl;
		cout << "введите новое имя - ";
		cin >> name;
	}
	void setMY()
	{
		cout << MadeYear << endl;
		cout << "введите новый год выпуска - ";
		cin >> MadeYear;
	}
	void setMS()
	{
		cout << maxspeed << endl;
		cout << "введите новую макс скорость - ";
		cin >> maxspeed;
	}
	string getName()
	{
		return name;
	}
	int getMY()
	{
		return MadeYear;
	}
	int getMS()
	{
		return maxspeed;
	}
	virtual void shapka()
	{
		cout << setiosflags(ios::left)
			<< setw(10)<<"Название"
			<< setw(12) << "Год выпуска"
			<< setw(15) << "Макс скорость"
			/*<< setw(17) << "Грузоподъёмность"
			<< setw(10) << "Высота"
			<< setw(15) << "Тип"
			<< setw(15) << "Класс"<<endl*/;
	}
	//friend istream& operator >> (istream& in, transrport& obj)
	//{
	//	obj.setName();
	//	obj.setMY();
	//	 obj.setMS();
	//	return in;
	//}
	//friend ostream& operator << (ostream& out, transrport& obj)
	//{
	//	cout << "Имя" << endl;
	//	cout << obj.getName();
	//	cout << "Год выпуска" << endl;
	//	cout << obj.getMY();
	//	cout << "Макс скорость" << endl;
	//	cout << obj.getMS();
	//		return out;
	//}
	//void setting()
	//{

	//}
};