#include "tralik.h"
void tralik::poisk(string str)
{
	if (str == getName())
	cout<<endl<<*this;
}
void tralik::poisk2(int num)
{
	if (num == getMY() || num == getMS() || num == getKM() || num == getDlina() || num == getPE())
		cout << endl << *this;
}
void tralik:: shapka()
{
	cout << setiosflags(ios::left)
		<< setw(10) << "��������"
		<< setw(12) << "��� �������"
		<< setw(15) << "���� ��������"
		<< setw(17) << "���-�� ����"
		<< setw(10) << "������"
		<< setw(15) << "������.�����."
		<< endl;
}
istream& operator >> (istream& in, tralik& obj)
{

	cout << "������� ����� ��� - ";
	obj.setName();
	cout << "������� ����� ��� ������� - ";
	obj.setMY();
	cout << "������� ����� ���� �������� - ";
	obj.setMS();
	cout << "������� ����� ���-�� ���� - ";
	obj.setKM();
	cout << "������� ����� ������ - ";
	obj.setDlina();
	cout << "������� ����� ������.�����. - ";
	obj.setPE();
	return in;
}

ostream& operator << (ostream& out, tralik& obj)
{
	return  out <<
		endl << setw(10) << obj.getName()
		<< setw(12) << obj.getMY()
		<< setw(15) << obj.getMS()
		<< setw(17) << obj.getKM()
		<< setw(10) << obj.getDlina()
		<< setw(15) << obj.getPE()
		<< endl;
}
void tralik:: setting()
{
	cout << "1)��������\n2)��� �������\n3)���� ��������\n4)���-�� ����\n5)������\n6)������" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "������� ����� ��� - ";
		cin >> name; break;
	case '2':
		cout << getMY() << endl;
		cout << "������� ����� ��� ������� - ";
		cin >> MadeYear; break;
	case '3':
		cout << getMS() << endl;
		cout << "������� ����� ���� �������� - ";
		cin >> maxspeed; break;
	case '4':
		cout << getKM() << endl;
		cout << "������� ����� ���-�� ���� - ";
		cin >> KolMest; break;
	case '5':
		cout << getDlina() << endl;
		cout << "������� ����� ������ - ";
		cin >> dlina; break;
	case '6':
		cout << getPE() << endl;
		cout << "������� ����� ������.�����. - ";
		cin >> PotrebEnerg; break;
	default:cout << "ERROR" << endl; break;
	}
}