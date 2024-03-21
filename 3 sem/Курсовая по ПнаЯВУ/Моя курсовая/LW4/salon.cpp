#include "salon.h"
#include "Exeptoin.h"
salon::salon()
{
	name = "";
	garant = "";
	test = "";
}

string salon:: getGarant()
{
	return garant;
}

string salon::getTest()
{
	return test;
}

void salon::shapka()
{
	cout << setiosflags(ios::left)
		<< setw(14) << "Название"
		<< setw(14) << "Модель"
		<< setw(13) << "Кузов"
		<< setw(15) << "Макс скорость"
		<< setw(15) << "Гарантия"
		<< setw(15) << "Тест-драйв"
		<< setw(12) << "Цена"
		<< endl;
}

ifstream& operator >> (ifstream& in, salon& obj)
{
	in >> obj.name >> obj.price >> obj.maxspeed >> obj.model >> obj.kyzov >> obj.garant >> obj.test;
	return in;
}

ofstream& operator << (ofstream& out, salon& obj)
{
	out << obj.name << ' ' << obj.price << ' ' << obj.maxspeed << ' ' << obj.model << ' ' << obj.kyzov << ' ' << obj.garant << ' ' << obj.test << endl;
	return out;
}

istream& operator >> (istream& in, salon& obj)
{
	cout << "введите новое имя - ";
	obj.name =  chek_str();
	cout << "введите новую цену - ";
	obj.price = chek_num();
	cout << "введите новую макс скорость - ";
	obj.maxspeed= chek_num();
	cout << "введите новое название модели - ";
	cin>>obj.model;
	cout << "введите новый тип кузова - ";
	obj.kyzov = chek_str();
	cout << "есть ли гарантия? - ";
	obj.garant= chek_str();
	cout << "есть ли тест-драйв? - ";
	obj.test= chek_str();
	return in;
}

ostream& operator << (ostream& out, salon& obj)
{
	return  out <<
		endl << setw(14) << obj.getName()
		<< setw(14) << obj.getModel()
		<< setw(13) << obj.getKyzov()
		<< setw(15) << obj.getMS()
		<< setw(15) << obj.getGarant()
		<< setw(15) << obj.getTest()
		<< setw(12) << obj.getPrice();
}

bool salon:: operator==(salon& obj)
{
	if (
		(obj.name == this->name || obj.name == "-") &&
		(obj.model == this->model || obj.model == "-") &&
		(obj.kyzov == this->kyzov || obj.kyzov == "-") &&
		(obj.maxspeed == this->maxspeed || obj.maxspeed == 1) &&
		(obj.price == this->price || obj.price == 1) &&
		(obj.garant == this->garant || obj.garant == "-") &&
		(obj.test == this->test || obj.test == "-")
		)
		return true;
	else
		return false;
}

void salon::setting()
{
	cout << "1)Название\n2)Цена\n3)Макс скорость\n4)Модель\n5)Кузов\n6)Гарантия\n7)Тест-драйв" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "введите новое имя - ";
		name = chek_str(); break;
	case '2':
		cout << getPrice() << endl;
		cout << "введите новую цену - ";
		price= chek_num(); break;
	case '3':
		cout << getMS() << endl;
		cout << "введите новую макс скорость - ";
		maxspeed= chek_num(); break;
	case '4':
		cout << getModel() << endl;
		cout << "введите новое название модели - ";
		cin >> model; break;
	case '5':
		cout << getKyzov() << endl;
		cout << "введите новый тип кузова - ";
		kyzov= chek_str(); break;
	case '6':
		cout << getGarant() << endl;
		cout << "есть ли гарантия? - ";
		garant= chek_str(); break;
	case '7':
		cout << getTest() << endl;
		cout << "есть ли тест-драйв? - ";
		test = chek_str(); break;
	default:cout << "ERROR" << endl; break;
	}
}