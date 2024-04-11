#pragma once
#include "Header.h"
#include "samosval.h"
#include "avtobus.h"
#include "tralik.h"

int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	samosval a[3];
	avtobus b[3];
	tralik c[3];
	int is = 0;
	int ia = 0;
	int it = 0;
	while (1) {
		cout << "1)������ ������\n2)����������� ��������\n3)�������� ���-��\n0)�����" << endl;
		switch (_getch()) {
		case'1':
			cout << "1)��������\n2)�������\n3)���������" << endl;
			switch (_getch())
			{
			case'1':if (is < 2)
			{ 
				cin >> a[is]; 
				is++;
			}
				   else
			{
				cout << "����������" << endl;
			}
				   system("pause");
				system("cls"); 
				break;
			case'2':if (ia < 2)
			{
				cin >> b[ia];
				ia++;
			}
				   else
			{
				cout << "����������" << endl;
			} system("pause");
				system("cls");
				break;
			case'3':if (it < 2)
			{
				cin >> c[it];
				it++;
			}
				   else
			{
				cout << "����������" << endl;
			} system("pause");
				system("cls");
				break;
			}
		break;

		case'2':
			cout << "1)��������\n2)�������\n3)���������" << endl;
			switch (_getch())
			{
			case '1':
				a[0].shapka();
				for (int i = 0; i < is; i++) {
					cout << a[i];
			}
				system("pause");
				system("cls");
				break;
			case '2':
				b[0].shapka();
				for (int i = 0; i < ia; i++) {
					cout << a[i];
				}
				system("pause");
				system("cls");
				break;
			case '3':
				c[0].shapka();
				for (int i = 0; i < it; i++) {
					cout << a[i];
				}
				system("pause");
				system("cls");
				break;
			default:cout << "ERROR" << endl;
			}
		break;
		case'3':
			cout << "1)��������\n2)�������\n3)���������" << endl;
			switch (_getch())
			{
			case'1':
				for (int i = 0; i < is; i++) 
				{
					cout << i + 1 << ")" << a[i].getName() << endl;
				}
				switch (_getch())
				{
				case '1':a[0].setting(); system("pause");
					system("cls"); break;
				case'2':a[1].setting(); system("pause");
					system("cls"); break;
				case'3': a[2].setting(); system("pause");
					system("cls"); break;
				default:cout << "ERROR" << endl;
				}break;
				
			case'2':for (int i = 0; i < ia; i++)
			{
				cout << i + 1 << ")" << b[i].getName() << endl;
			}
				   switch (_getch())
				   {
				   case '1':b[0].setting(); system("pause");
					   system("cls"); break;
				   case'2':b[1].setting(); system("pause");
					   system("cls"); break;
				   case'3': b[2].setting(); system("pause");
					   system("cls"); break;
				   default:cout << "ERROR" << endl;
				   } break;
			case'3':for (int i = 0; i < it; i++)
			{
				cout << i + 1 << ")" << c[i].getName() << endl;
			}
				   switch (_getch())
				   {
				   case '1':c[0].setting(); system("pause");
					   system("cls"); break;
				   case'2':c[1].setting(); system("pause");
					   system("cls"); break;
				   case'3': c[2].setting(); system("pause");
					   system("cls"); break;
				   default:cout << "ERROR" << endl;
				   }break;
			default:cout << "ERROR" << endl;
			}
		break;
		case'0':exit(0); break;
		default:cout << "ERROR" << endl; break;
		}
	}
	return 0;
}