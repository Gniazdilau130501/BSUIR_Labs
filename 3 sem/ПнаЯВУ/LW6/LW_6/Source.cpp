#include <iostream>
#include <string>
#include "fstream"
#include <conio.h>
#include <windows.h>

using namespace std;

void writeF()  //������ � ����
{
	ofstream f1("TEXT.txt", ios::app);
	if (!f1.is_open())
	{
		cout << "���� �� ������\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "�������� ���-�� - ";
		cin >> str;
		f1 << str<<endl;
	}
	f1.close();
}

void writeF_bin()  //������ � ����
{
	ofstream f1("TEXT.bin", ios::binary | ios::out);
	if (!f1.is_open())
	{
		cout << "���� �� ������\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "�������� ���-�� - ";
		cin >> str;
		f1.write((char*)&str, sizeof str);
	}
	f1.close();
}

void writeF2()  //������ � ����
{
	ofstream f1("TEXT.txt");
	if (!f1.is_open())
	{
		cout << "���� �� ������\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "�������� ���-�� - ";
		cin >> str;
		f1 << str << endl;
	}
	f1.close();
}

void clean()  //������ � ����
{
	ofstream f1("TEXT.txt");
	if (!f1.is_open())
	{
		cout << "���� �� ������\n";
	}
	f1.close();
}

void readF() //������ �� �����
{
	ifstream f2("TEXT.txt");
	string str2;
	cout << "� �����:"<<endl;
	while (f2 >> str2)
	{
		cout<<str2<<endl;
	}
	f2.close();
}

void readF_bin() //������ �� �����
{
	ifstream f2("TEXT.bin", ios::binary | ios::in);
	string str2;
	cout << "� �����:" << endl;
	f2.read((char*)&str2, sizeof str2);
	f2.close();
	cout << str2 << endl;
}

int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	int flag = 0;
	while (1)
	{
		flag = 0;
		system("cls");
		cout << "1)��������� ����\n2)�������� ����\n3)�����" << endl;
		//rewind(stdin);
		switch (_getch())
		{
		case '1':
			while (!flag)
			{
				system("cls");
				cout << "1)������������ ����\n2)�������� ����\n3)����������� ����\n4)�������� ����\n5)� ������� ����" << endl;
				switch (_getch())
				{
				case '1':
					writeF2();
					break;
				case '2':
					writeF();
					break;
				case '3':
					readF();
					system("pause");
					break;
				case '4':
					cout << "���� ������" << endl;
					clean();
					system("pause");
					break;
				case '5':
					flag = 1;
					break;
				}
			}
			break;
		case '2':
			while (!flag)
			{
				system("cls");
				cout << "1)������������ ����\n2)����������� ����\n3)�������� ����\n4)� ������� ����" << endl;
				switch (_getch())
				{
				case '1':
					writeF_bin();
					break;
				case '2':
					readF_bin();
					system("pause");
					break;
				case '3':
					cout << "���� ������" << endl;
					clean();
					system("pause");
					break;
				case '4':
					flag = 1;
					break;
				}
			}
			break;
		case '3':
			exit(0);
			break;
		}
	}
}