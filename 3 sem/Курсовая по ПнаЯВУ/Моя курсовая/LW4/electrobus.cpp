#include "electrobus.h"
#include "Exeptoin.h"
electrobus::electrobus()
{
	name = "no_name";
	PotrebEnerg = 0;
}

int electrobus::getPE()
{
	return PotrebEnerg;
}

void electrobus:: shapka()
{
	cout << setiosflags(ios::left)
		<< setw(10) << "Название"
		<< setw(15) << "Макс скорость"
		<< setw(17) << "Кол-во мест"
		<< setw(10) << "Доп.топливо"
		<< setw(15) << "Потреб.Энерг."
		<< setw(12) << "Цена"
		<< endl;
}

ifstream& operator >> (ifstream& in, electrobus& obj)
{
	in >> obj.name >> obj.price >> obj.maxspeed >> obj.KolMest >> obj.toplivo >> obj.PotrebEnerg >> obj.price;
	return in;
}

ofstream& operator << (ofstream& out, electrobus& obj)
{
	out << obj.name << ' ' << obj.price << ' ' << obj.maxspeed << ' ' << obj.KolMest << ' ' << obj.toplivo << ' ' << obj.PotrebEnerg << ' ' << obj.price << endl;
	return out;
}

istream& operator >> (istream& in, electrobus& obj)
{
	cout << "введите новое имя - ";
	obj.name= chek_str();
	cout << "введите новую макс скорость - ";
	obj.maxspeed= chek_num();
	cout << "введите новое кол-во мест - ";
	obj.KolMest= chek_num();
	cout << "введите вид топлива - ";
	obj.toplivo= chek_str();
	cout << "введите новое потреб.энерг. - ";
	obj.PotrebEnerg= chek_num();
	cout << "введите новую цену - ";
	obj.price= chek_num();
	return in;
}

ostream& operator << (ostream& out, electrobus& obj)
{
	return  out <<
		endl << setw(10) << obj.getName()
		<< setw(15) << obj.getMS()
		<< setw(17) << obj.getKM()
		<< setw(10) << obj.getToplivo()
		<< setw(15) << obj.getPE()
		<< setw(12) << obj.getPrice();
}

bool electrobus::operator==(electrobus& obj)
{
	if (
		(obj.name == this->name || obj.name == "-") &&
		(obj.KolMest == this->KolMest || obj.KolMest == 1) &&
		(obj.PotrebEnerg == this->PotrebEnerg || obj.PotrebEnerg == 1) &&
		(obj.maxspeed == this->maxspeed || obj.maxspeed == 1) &&
		(obj.price == this->price || obj.price == 1) &&
		(obj.toplivo == this->toplivo || obj.toplivo == "-")
		)
		return true;
	else
		return false;
}

void electrobus:: setting()
{
	cout << "1)Название\n2)Цена\n3)Макс скорость\n4)Кол-во мест\n5)Вид топлива\n6)Расход" << endl;
	switch (_getch()){
	case '1':
		cout << getName() << endl;
		cout << "введите новое имя - ";
		name= chek_str(); break;
	case '2':
		cout << getPrice() << endl;
		cout << "введите новую цену - ";
		price= chek_num(); break;
	case '3':
		cout << getMS() << endl;
		cout << "введите новую макс скорость - ";
		maxspeed= chek_num(); break;
	case '4':
		cout << getKM() << endl;
		cout << "введите новое кол-во мест - ";
		KolMest= chek_num(); break;
	case '5':
		cout << getToplivo() << endl;
		cout << "введите вид топлива - ";
		toplivo= chek_str(); break;
	case '6':
		cout << getPE() << endl;
		cout << "введите новое потреб.энерг. - ";
		PotrebEnerg= chek_num(); break;
	default:cout << "ERROR" << endl; break;
	}
}