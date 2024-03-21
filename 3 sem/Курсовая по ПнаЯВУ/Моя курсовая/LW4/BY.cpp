#include "BY.h"
#include"Exeptoin.h"
BY::BY()
{
	name = "";
	gorod = "";
	probeg = 0;
}

string BY:: getGorod()
{
	return gorod;
}

int BY:: getProbeg()
{
	return probeg;
}

void BY::shapka()
{
	cout << setiosflags(ios::left)
		<< setw(14) << "��������"
		<< setw(14) << "������"
		<< setw(13) << "�����"
		<< setw(15) << "���� ��������"
		<< setw(15) << "����� �������"
		<< setw(15) << "������"
		<< setw(12) << "����"
		<< endl;
}

ifstream& operator >> (ifstream& in, BY& obj)
{
	in >> obj.name >> obj.price >> obj.maxspeed >> obj.model >> obj.kyzov >> obj.gorod >> obj.probeg;
	return in;
}

ofstream& operator << (ofstream& out, BY& obj)
{
	out << obj.name << ' ' << obj.price << ' ' << obj.maxspeed << ' ' << obj.model << ' ' << obj.kyzov << ' ' << obj.gorod << ' ' << obj.probeg << endl;
	return out;
}

istream& operator >> (istream& in, BY& obj)
{

	cout << "������� ����� ��� - ";
	obj.name= chek_str();
	cout << "������� ����� ���� - ";
	obj.price= chek_num();
	cout << "������� ����� ���� �������� - ";
	obj.maxspeed= chek_num();
	cout << "������� ����� �������� ������ - ";
	obj.model= chek_str();
	cout << "������� ����� ��� ������ - ";
	obj.kyzov= chek_str();
	cout << "������� ����� ������� - ";
	obj.gorod= chek_str();
	cout << "������� ������ - ";
	obj.probeg= chek_num();
	return in;
}

ostream& operator << (ostream& out, BY& obj)
{
	return  out <<
		endl << setw(14) << obj.getName()
		<< setw(14) << obj.getModel()
		<< setw(13) << obj.getKyzov()
		<< setw(15) << obj.getMS()
		<< setw(15) << obj.getGorod()
		<< setw(15) << obj.getProbeg()
		<< setw(12) << obj.getPrice();
}

bool BY:: operator==(BY& obj)
{
	if (
		(obj.name == this->name || obj.name == "-") &&
		(obj.model == this->model || obj.model == "-") &&
		(obj.kyzov == this->kyzov || obj.kyzov == "-") &&
		(obj.maxspeed == this->maxspeed || obj.maxspeed == 1) &&
		(obj.price == this->price || obj.price == 1) &&
		(obj.gorod == this->gorod || obj.gorod == "-") &&
		(obj.probeg == this->probeg || obj.probeg == 1)
		)
		return true;
	else
		return false;
}

void BY::setting()
{
	cout << "1)��������\n2)����\n3)���� ��������\n4)������\n5)�����\n6)����� �������\n7)������" << endl;
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
		cout << getModel() << endl;
		cout << "������� ����� �������� ������ - ";
		cin>>model; break;
	case '5':
		cout << getKyzov() << endl;
		cout << "������� ����� ��� ������ - ";
		kyzov= chek_str(); break;
	case '6':
		cout << getGorod() << endl;
		cout << "������� ����� ������� - ";
		gorod= chek_str(); break;
	case '7':
		cout << getProbeg() << endl;
		cout << "������� ������ - ";
		probeg= chek_num(); break;
	default:cout << "ERROR" << endl; break;
	}
}