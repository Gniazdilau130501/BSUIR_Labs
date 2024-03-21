#include "shablon.h"
#include "shablon.cpp"
#include"Header.h"
#include"legkovie.h"
#include"avtobusi.h"
#include"salon.h"
#include"microavtobus.h"
#include"electrobus.h"
#include"BY.h"

using namespace std;

template<class A>
void menu(shablon <A>& obj, text_files<A>&t_file,int adm)
{
	obj.readF();
	int u = 1;
	while (u == 1)
	{
		system("cls");
		char i = 'y';
		A temp_obj;
		if(adm==1)
		cout << "1)�����������\n2)�����\n3)� ������� ����\n4)��������\n5)��������\n6)�������\n7)�������� ����\n8)�������� ����. ��������" << endl;
		else
		cout << "1)�����������\n2)�����\n3)� ������� ����" << endl;
		switch (_getch())
		{
		case '1':
			system("cls");
			obj.out();
			system("pause");
			break;
		case '2':
			system("cls");
			cout << "��� �������� ��������� ����� ������� '-'\n�������� - '1'" << endl;
			cin >> temp_obj;
			obj.poisk(temp_obj);
			break;
		case '3':
			system("cls");
			obj.writeF();
			obj.del_all();
			u = 0;
			break;
		case '4':
			if (adm == 1)
			{
				system("cls");
				while (i == 'y')
				{
					cin >> temp_obj;
					obj.add(temp_obj);
					cout << "�������� ���?(y/n)" << endl;
					i = _getch();
				}
			}
			break;
		case '5':
			if (adm == 1)
			{
				system("cls");
				obj.nastr();
			}
			break;
		case '6':
			if (adm == 1)
			{
				system("cls");
				obj.del();
			}
			break;
		case '7':
			if (adm == 1)
			{
				obj.del_all();
				obj.writeF();
				cout << "���� ������" << endl;
				system("pause");
			}
			break;
		case '8':
			if (adm == 1)
			{
				obj.del_all();
				obj.readF();
				cout << "�������� ���������" << endl;
				system("pause");
			}
			break;
		}
	}
}

int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	shablon<salon> p_s;
	shablon<microavtobus>p_a;
	shablon<electrobus> p_t;
	shablon<BY> p_y;
	text_files<salon>f_s;
	text_files<microavtobus>f_a;
	text_files<electrobus>f_t;
	text_files<BY> f_y;
	ifstream admin_;
	ofstream admin_1;
	string password;
	string admin="";
	int adm = 0;
	while (1)
	{
		if(adm==0)
		cout << "1)���������� �� ������\n2)���������� �/�\n3)�������������\n4)�����������\n5)�������������� � ������� ��������������\n0)�����" << endl;
		else
		cout << "1)���������� �� ������\n2)���������� �/�\n3)�������������\n4)�����������\n6)�������� ������\n7)��������� � ����� ������������\n0)�����" << endl;
		rewind(stdin);
		switch (_getch())
		{
		case'1':
			menu(p_s,f_s,adm);
			break;
		case'2':
			menu(p_y,f_y,adm);
			break;
		case'3':
			menu(p_a,f_a,adm);
			break;
		case'4':
			menu(p_t,f_t,adm);
			break;
		case'5':
			if (adm == 0)
			{
				admin_.open("password.txt", ifstream::app);
				admin_ >> password;
				cout << "������� ������ - ";
				cin >> admin;
				if (admin == password)
				{
					cout << "������ ��������, ����� ����������" << endl;
					adm = 1;
				}
				else
				{
					cout << "��������!" << endl;
				}
				system("pause");
				admin_.close();
			}
			break;
		case'0':
			exit(0);
			break;
		case '6':
			admin_1.open("password.txt");
			cout << "������� ����� ������ - ";
			cin >> admin;
			admin_1 << admin;
			cout << "������ ������� "<<endl;
			system("pause");
			admin_1.close();
			break;
		case '7':
			adm = 0;
			break;
		}
		system("cls");
	}
	return 0;
}