#include <iostream>
#include <string>
#include "fstream"
#include <conio.h>
#include <windows.h>

using namespace std;

void writeF()  //запись в файл
{
	ofstream f1("TEXT.txt", ios::app);
	if (!f1.is_open())
	{
		cout << "файл не открыт\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "Напишите что-то - ";
		cin >> str;
		f1 << str<<endl;
	}
	f1.close();
}

void writeF_bin()  //запись в файл
{
	ofstream f1("TEXT.bin", ios::binary | ios::out);
	if (!f1.is_open())
	{
		cout << "файл не открыт\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "Напишите что-то - ";
		cin >> str;
		f1.write((char*)&str, sizeof str);
	}
	f1.close();
}

void writeF2()  //запись в файл
{
	ofstream f1("TEXT.txt");
	if (!f1.is_open())
	{
		cout << "файл не открыт\n";
	}
	else
	{
		system("cls");
		string str;
		cout << "Напишите что-то - ";
		cin >> str;
		f1 << str << endl;
	}
	f1.close();
}

void clean()  //запись в файл
{
	ofstream f1("TEXT.txt");
	if (!f1.is_open())
	{
		cout << "файл не открыт\n";
	}
	f1.close();
}

void readF() //чтение из файла
{
	ifstream f2("TEXT.txt");
	string str2;
	cout << "В файле:"<<endl;
	while (f2 >> str2)
	{
		cout<<str2<<endl;
	}
	f2.close();
}

void readF_bin() //чтение из файла
{
	ifstream f2("TEXT.bin", ios::binary | ios::in);
	string str2;
	cout << "В файле:" << endl;
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
		cout << "1)Текстовый файл\n2)Бинарный файл\n3)Выход" << endl;
		//rewind(stdin);
		switch (_getch())
		{
		case '1':
			while (!flag)
			{
				system("cls");
				cout << "1)Перезаписать файл\n2)Дописать файл\n3)Просмотреть файл\n4)Очистить файл\n5)В главное меню" << endl;
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
					cout << "Файл очищен" << endl;
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
				cout << "1)Перезаписать файл\n2)Просмотреть файл\n3)Очистить файл\n4)В главное меню" << endl;
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
					cout << "Файл очищен" << endl;
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