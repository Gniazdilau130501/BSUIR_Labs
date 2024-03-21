#include "microavtobus.h"
#include "Exeptoin.h"
microavtobus::microavtobus()
{
	name = "no_name";
	rashod = 0;
}

int microavtobus::getRashod()
{
	return rashod;
}

void microavtobus::shapka()
{
	cout << setiosflags(ios::left)
		<< setw(10) << "��������"
		<< setw(15) << "���� ��������"
		<< setw(17) << "���-�� ����"
		<< setw(10) << "�������"
		<< setw(15) << "������"
		<< setw(12) << "����"
		<< endl;
}

ifstream& operator >> (ifstream& in, microavtobus& obj)
{
	in >> obj.name >> obj.price >> obj.maxspeed >> obj.KolMest >> obj.toplivo >> obj.rashod >> obj.price;
	return in;
}

ofstream& operator << (ofstream& out, microavtobus& obj)
{
	out << obj.name << ' ' << obj.price << ' ' << obj.maxspeed << ' ' << obj.KolMest << ' ' << obj.toplivo << ' ' << obj.rashod << ' ' << obj.price << endl;
	return out;
}

istream& operator >> (istream& in, microavtobus& obj)
{

	cout << "������� ����� ��� - ";
	obj.name= chek_str();
	cout << "������� ����� ���� �������� - ";
	obj.maxspeed= chek_num();
	cout << "������� ����� ���-�� ���� - ";
	obj.KolMest= chek_num();
	cout << "������� ��� ������� - ";
	obj.toplivo= chek_str();
	cout << "������� ����� ������ - ";
	obj.rashod= chek_num();
	cout << "������� ����� ���� - ";
	obj.price = chek_num();
	return in;
}

ostream& operator << (ostream& out, microavtobus& obj)
{
	return  out <<
		endl << setw(10) << obj.getName()
		<< setw(15) << obj.getMS()
		<< setw(17) << obj.getKM()
		<< setw(10) << obj.getToplivo()
		<< setw(15) << obj.getRashod()
		<< setw(12) << obj.getPrice();
}

bool microavtobus::operator==(microavtobus& obj)
{
	if (
		(obj.name == this->name || obj.name == "-") &&
		(obj.KolMest == this->KolMest || obj.KolMest == 1) &&
		(obj.rashod == this->rashod || obj.rashod == 1) &&
		(obj.maxspeed == this->maxspeed || obj.maxspeed == 1) &&
		(obj.price == this->price || obj.price == 1) &&
		(obj.toplivo == this->toplivo || obj.toplivo == "-")
		)
		return true;
	else
		return false;
}

void microavtobus::setting()
{
	cout << "1)��������\n2)����\n3)���� ��������\n4)���-�� ����\n5)��� �������\n6)������" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "������� ����� ��� - ";
		name= chek_str(); break;
	case '2':
		cout << getPrice() << endl;
		cout << "������� ����� ���� - ";
		price= chek_num(); break;
	case '3':
		cout << getMS() << endl;
		cout << "������� ����� ���� �������� - ";
		maxspeed= chek_num(); break;
	case '4':
		cout << getKM() << endl;
		cout << "������� ����� ���-�� ���� - ";
		KolMest= chek_num(); break;
	case '5':
		cout << getToplivo() << endl;
		cout << "������� ��� ������� - ";
		toplivo= chek_num(); break;
	case '6':
		cout << getRashod() << endl;
		cout << "������� ����� ������ - ";
		rashod= chek_num(); break;
	default:cout << "ERROR" << endl; break;
	}
}