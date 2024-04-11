#pragma once
#include <iostream>
#include <ostream>
#include <string>
#include <Windows.h>
#include <conio.h>
#include <iomanip>
#include "samosval.h"
#include "avtobus.h"
#include "tralik.h"
using namespace std;
template <typename A>
class transport
{
private:
	A object;
public:
	transport *p_left=NULL;
	transport *p_right = NULL;
	void setObj()
	{
		cin >> object;
	}
	void getObj()
	{
		object.shapka();
		cout<< object;
	}
	void seting()
	{
		object.setting();
	}
	transport<A>* add(transport<A>* p)
	{
		transport<A>* car;
		if (p == NULL)
		{
			car = NULL;
			car = new transport<A>;
			car->setObj();
			p = car;
		}
		else
		{
			car = NULL;
			car = new transport<A>;
			car->setObj();
			car->p_left = p;
			p->p_right = car;
			p = car;
		}
		return p;
	}

	transport<A>* out(transport<A>* p)
	{
		transport<A>* t;
		t = p;
		while (t != NULL)
		{
			system("cls");
			t->getObj();
			cout << "press d - to next or a - to back\n0-to exit\nc-to delete\ns-to open settings" << endl;
			switch (_getch())
			{
			case'd':
				if (t->p_left == NULL)
					cout << "\nЁлемент отсутсвует" << endl;
				else
					t = t->p_left;
				break;
			case'a':
				if (t->p_right == NULL)
					cout << "\nЁлемент отсутсвует" << endl;
				else
					t = t->p_right;
				break;
			case'0':
				t = NULL;
				break;
			case 'c':
				if (t == p)
					p = p->p_left;
				if (t->p_left != NULL)
					t->p_left->p_right = t->p_right;
				if (t->p_right != NULL)
					t->p_right->p_left = t->p_left;
				delete t;
				t = p;
				break;
			case 's':
				t->seting();
				break;
			default:cout << "ERROR(возможно у вас русска€ раскладка)";
			}
		}
		return p;
	}
	void search(transport<A>* p,string str)
	{
		transport<A>* t;
		t = p;
		while (t != NULL)
		{
			t->object.poisk(str);
			t = t->p_left;
		}
	}
	void search2(transport<A>* p, int num)
	{
		transport<A>* t;
		t = p;
		while (t != NULL)
		{
			t->object.poisk2(num);
			t = t->p_left;
		}
	}
	void shapka()
	{
		object.shapka();
	}
};


