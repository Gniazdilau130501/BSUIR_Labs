#include "samosval.h"
	void samosval:: shapka()
	{
		cout << setiosflags(ios::left)
			<< setw(10) << "��������"
			<< setw(12) << "��� �������"
			<< setw(15) << "���� ��������"
			<< setw(17) << "����������������"
			<< setw(10) << "������"
			<< setw(15) << "���"
			<< setw(15) << "�����"
			<< endl;
	}
 istream& operator >> (istream& in, samosval& obj)
{
	
	cout << "������� ����� ��� - ";
	obj.setName();
	cout << "������� ����� ��� ������� - ";
	obj.setMY();
	cout << "������� ����� ���� �������� - ";
	obj.setMS();
	cout << "������� ����� ���� �������� - ";
	obj.setMW();
	cout << "������� ����� ������ - ";
	obj.setHight();
	cout << "������� ����� ��� - ";
	obj.setType();
	cout << "������� ����� ����� - ";
	obj.setKlass();
	return in;
}
ostream& operator << (ostream& out, samosval& obj)
{
	return  out <<
		endl << setw(10) << obj.getName()
		<< setw(12) << obj.getMY()
		<< setw(15) << obj.getMS()
		<< setw(17) << obj.getMW()
		<< setw(10) << obj.getHight()
		<< setw(15) << obj.getType()
		<< setw(15) << obj.getKlass() << endl;
}
void samosval :: setting()
{
	cout << "1)��������\n2)��� �������\n3)���� ��������\n4)����������������\n5)������\n6)���\n7)�����" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "������� ����� ��� - ";
		 setName(); break;
	case '2':
		cout << getMY() << endl;
		cout << "������� ����� ��� ������� - ";
		cin >> MadeYear; break;
	case '3':
		cout << getMS() << endl;
		cout << "������� ����� ���� �������� - ";
		cin >> maxspeed; break;
	case '4':
		cout << getMW() << endl;
		cout << "������� ����� ���� �������� - ";
		cin >> MaxWeith; break;
	case '5':
		cout << getHight() << endl;
		cout << "������� ����� ������ - ";
		cin >> hight; break;
	case '6':
		cout <<getType() << endl;
		cout << "������� ����� ��� - ";
		cin >> type; break;
	case '7':
		cout << getKlass() << endl;
		cout << "������� ����� ����� - ";
		cin >> klass; break;
	default:cout << "ERROR" << endl; break;
	}

}