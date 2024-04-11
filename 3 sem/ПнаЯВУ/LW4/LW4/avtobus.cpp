#include "avtobus.h"
void avtobus::poisk(string str)
{
	if (str == getName())
		cout << endl << *this;
}
void avtobus::poisk2(int num)
{
	if (num == getMY() || num == getMS() || num == getKM() || num == getDlina() || num == getRashod())
		cout << endl << *this;
}
void avtobus::shapka()
{
	cout << setiosflags(ios::left)
		<< setw(10) << "Название"
		<< setw(12) << "Год выпуска"
		<< setw(15) << "Макс скорость"
		<< setw(17) << "Кол-во мест"
		<< setw(10) << "Длинна"
		<< setw(15) << "Расход"
		<< endl;
}

istream& operator >> (istream& in, avtobus& obj)
{

	cout << "введите новое имя - ";
	obj.setName();
	cout << "введите новый год выпуска - ";
	obj.setMY();
	cout << "введите новую макс скорость - ";
	obj.setMS();
	cout << "введите новое кол-во мест - ";
	obj.setKM();
	cout << "введите новую длинну - ";
	obj.setDlina();
	cout << "введите новый расход - ";
	obj.setRashod();
	return in;
}

ostream& operator << (ostream& out, avtobus& obj)
{
	return  out <<
		endl << setw(10) << obj.getName()
		<< setw(12) << obj.getMY()
		<< setw(15) << obj.getMS()
		<< setw(17) << obj.getKM()
		<< setw(10) << obj.getDlina()
		<< setw(15) << obj.getRashod()
		<< endl;
}
void avtobus::setting()
{
	cout << "1)Название\n2)Год выпуска\n3)Макс скорость\n4)Кол-во мест\n5)Длинна\n6)Расход" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "введите новое имя - ";
		cin >> name; break;
	case '2':
		cout << getMY() << endl;
		cout << "введите новый год выпуска - ";
		cin >> MadeYear; break;
	case '3':
		cout << getMS() << endl;
		cout << "введите новую макс скорость - ";
		cin >> maxspeed; break;
	case '4':
		cout << getKM() << endl;
		cout << "введите новое кол-во мест - ";
		cin >> KolMest; break;
	case '5':
		cout << getDlina() << endl;
		cout << "введите новую длинну - ";
		cin >> dlina; break;
	case '6':
		cout << getRashod() << endl;
		cout << "введите новый расход - ";
		cin >> rashod; break;
	default:cout << "ERROR" << endl; break;
	}
}