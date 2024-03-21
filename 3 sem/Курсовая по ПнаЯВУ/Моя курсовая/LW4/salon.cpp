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
		<< setw(14) << "��������"
		<< setw(14) << "������"
		<< setw(13) << "�����"
		<< setw(15) << "���� ��������"
		<< setw(15) << "��������"
		<< setw(15) << "����-�����"
		<< setw(12) << "����"
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
	cout << "������� ����� ��� - ";
	obj.name =  chek_str();
	cout << "������� ����� ���� - ";
	obj.price = chek_num();
	cout << "������� ����� ���� �������� - ";
	obj.maxspeed= chek_num();
	cout << "������� ����� �������� ������ - ";
	cin>>obj.model;
	cout << "������� ����� ��� ������ - ";
	obj.kyzov = chek_str();
	cout << "���� �� ��������? - ";
	obj.garant= chek_str();
	cout << "���� �� ����-�����? - ";
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
	cout << "1)��������\n2)����\n3)���� ��������\n4)������\n5)�����\n6)��������\n7)����-�����" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "������� ����� ��� - ";
		name = chek_str(); break;
	case '2':
		cout << getPrice() << endl;
		cout << "������� ����� ���� - ";
		price= chek_num(); break;
	case '3':
		cout << getMS() << endl;
		cout << "������� ����� ���� �������� - ";
		maxspeed= chek_num(); break;
	case '4':
		cout << getModel() << endl;
		cout << "������� ����� �������� ������ - ";
		cin >> model; break;
	case '5':
		cout << getKyzov() << endl;
		cout << "������� ����� ��� ������ - ";
		kyzov= chek_str(); break;
	case '6':
		cout << getGarant() << endl;
		cout << "���� �� ��������? - ";
		garant= chek_str(); break;
	case '7':
		cout << getTest() << endl;
		cout << "���� �� ����-�����? - ";
		test = chek_str(); break;
	default:cout << "ERROR" << endl; break;
	}
}