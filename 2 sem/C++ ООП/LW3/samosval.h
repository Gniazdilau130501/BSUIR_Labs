#include "gryzovie.h"

class samosval : public gryzovie
{
protected:
	string type;
	string klass;
public:
	samosval()
	{
		name = "��������";
		type = "�����������";
		klass = "�����������";
	}
	void setType()
	{
		cout << type << endl;
		cout << "������� ����� ��� - ";
		cin >> type;
	}
	void setKlass()
	{
		cout << klass << endl;
		cout << "������� ����� ����� - ";
		cin >> hight;
	}
	string getType()
	{
		return type;
	}
	string getKlass()
	{
		return klass;
	}
	friend istream& operator >> (istream& in, samosval& obj)
	{
		cout << "���" << endl;
		obj.setName();
		cout << "��� �������" << endl;
		obj.setMY();
		cout << "���� ��������" << endl;
		obj.setMS();
		cout << "���� ��������" << endl;
		obj.setMW();
		cout << "������" << endl;
		obj.setHight();
		cout << "���" << endl;
		obj.setType();
		cout << "�����" << endl;
		obj.setKlass();
		return in;
	}
	void shapka()
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
	friend ostream& operator << (ostream& out, samosval& obj)
	{
		obj.shapka();
		
		return  out <<
			endl<<setw(10)<< obj.getName()
			<< setw(12) << obj.getMY()
			<< setw(15) << obj.getMS()
			<< setw(17) << obj.getMW()
			<< setw(10) << obj.getHight()
			<< setw(15) << obj.getType()
			<< setw(15) << obj.getKlass() << endl;
	}
	void setting(samosval obj)
	{
		cout << "1)��������\n2)��� �������\n3)���� ��������\n4)����������������\n5)������\n6)���\n7)�����" << endl;
		switch (_getch())
		{
		case '1':obj.setName(); break;
		case '2':obj.setMY(); break;
		case '3':obj.setMS(); break;
		case '4':obj.setMW(); break;
		case '5':obj.setHight(); break;
		case '6':obj.setType(); break;
		case '7':obj.setKlass(); break;
		default:cout << "ERROR" << endl; break;
		}
	}
};