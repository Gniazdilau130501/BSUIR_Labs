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
		cout << "1)Просмотреть\n2)Поиск\n3)В главное меню\n4)Добавить\n5)Изменить\n6)Удалить\n7)Очистить файл\n8)Отменить посл. действие" << endl;
		else
		cout << "1)Просмотреть\n2)Поиск\n3)В главное меню" << endl;
		switch (_getch())
		{
		case '1':
			system("cls");
			obj.out();
			system("pause");
			break;
		case '2':
			system("cls");
			cout << "Для пропуска строковых полей введите '-'\nчисловых - '1'" << endl;
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
					cout << "добавить еще?(y/n)" << endl;
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
				cout << "Файл очищен" << endl;
				system("pause");
			}
			break;
		case '8':
			if (adm == 1)
			{
				obj.del_all();
				obj.readF();
				cout << "Действие отмененно" << endl;
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
		cout << "1)Автомобили из салона\n2)Автомобили б/у\n3)Микроавтобусы\n4)Электробусы\n5)Авторизоваться с правами администратора\n0)выход" << endl;
		else
		cout << "1)Автомобили из салона\n2)Автомобили б/у\n3)Микроавтобусы\n4)Электробусы\n6)Изменить пароль\n7)Вернуться в режим пользователя\n0)выход" << endl;
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
				cout << "Введите пароль - ";
				cin >> admin;
				if (admin == password)
				{
					cout << "Доступ разрешен, добро пожаловать" << endl;
					adm = 1;
				}
				else
				{
					cout << "Отказано!" << endl;
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
			cout << "Введите новый пароль - ";
			cin >> admin;
			admin_1 << admin;
			cout << "Пароль изменен "<<endl;
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