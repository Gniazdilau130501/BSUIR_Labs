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
		<< setw(10) << "��������"
		<< setw(15) << "���� ��������"
		<< setw(17) << "���-�� ����"
		<< setw(10) << "���.�������"
		<< setw(15) << "������.�����."
		<< setw(12) << "����"
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
	cout << "������� ����� ��� - ";
	obj.name= chek_str();
	cout << "������� ����� ���� �������� - ";
	obj.maxspeed= chek_num();
	cout << "������� ����� ���-�� ���� - ";
	obj.KolMest= chek_num();
	cout << "������� ��� ������� - ";
	obj.toplivo= chek_str();
	cout << "������� ����� ������.�����. - ";
	obj.PotrebEnerg= chek_num();
	cout << "������� ����� ���� - ";
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
	cout << "1)��������\n2)����\n3)���� ��������\n4)���-�� ����\n5)��� �������\n6)������" << endl;
	switch (_getch()){
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
		toplivo= chek_str(); break;
	case '6':
		cout << getPE() << endl;
		cout << "������� ����� ������.�����. - ";
		PotrebEnerg= chek_num(); break;
	default:cout << "ERROR" << endl; break;
	}
}