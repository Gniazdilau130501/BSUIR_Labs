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
		name = "�����������";
		MadeYear = 0;
		maxspeed = 0;
	}
	void setName()
	{
		cout << name<<endl;
		cout << "������� ����� ��� - ";
		cin >> name;
	}
	void setMY()
	{
		cout << MadeYear << endl;
		cout << "������� ����� ��� ������� - ";
		cin >> MadeYear;
	}
	void setMS()
	{
		cout << maxspeed << endl;
		cout << "������� ����� ���� �������� - ";
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
			<< setw(10)<<"��������"
			<< setw(12) << "��� �������"
			<< setw(15) << "���� ��������"
			/*<< setw(17) << "����������������"
			<< setw(10) << "������"
			<< setw(15) << "���"
			<< setw(15) << "�����"<<endl*/;
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
	//	cout << "���" << endl;
	//	cout << obj.getName();
	//	cout << "��� �������" << endl;
	//	cout << obj.getMY();
	//	cout << "���� ��������" << endl;
	//	cout << obj.getMS();
	//		return out;
	//}
	//void setting()
	//{

	//}
};