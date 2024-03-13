#include "gryzovie.h"

class samosval : public gryzovie
{
protected:
	string type;
	string klass;
public:
	samosval()
	{
		name = "Самосвал";
		type = "неизветсный";
		klass = "неизветсный";
	}
	void setType()
	{
		cout << type << endl;
		cout << "введите новое тип - ";
		cin >> type;
	}
	void setKlass()
	{
		cout << klass << endl;
		cout << "введите новый класс - ";
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
		cout << "имя" << endl;
		obj.setName();
		cout << "год выпуска" << endl;
		obj.setMY();
		cout << "макс скорость" << endl;
		obj.setMS();
		cout << "макс нагрузка" << endl;
		obj.setMW();
		cout << "высота" << endl;
		obj.setHight();
		cout << "тип" << endl;
		obj.setType();
		cout << "класс" << endl;
		obj.setKlass();
		return in;
	}
	void shapka()
	{
		cout << setiosflags(ios::left)
			<< setw(10) << "Название"
			<< setw(12) << "Год выпуска"
			<< setw(15) << "Макс скорость"
			<< setw(17) << "Грузоподъёмность"
			<< setw(10) << "Высота"
			<< setw(15) << "Тип"
			<< setw(15) << "Класс"
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
		cout << "1)Название\n2)Год выпуска\n3)Макс скорость\n4)Грузаподъемность\n5)Высота\n6)Тип\n7)Класс" << endl;
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