#include "samosval.h"
	void samosval:: shapka()
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
 istream& operator >> (istream& in, samosval& obj)
{
	
	cout << "введите новое имя - ";
	obj.setName();
	cout << "введите новый год выпуска - ";
	obj.setMY();
	cout << "введите новую макс скорость - ";
	obj.setMS();
	cout << "введите новую макс нагрузку - ";
	obj.setMW();
	cout << "введите новую высоту - ";
	obj.setHight();
	cout << "введите новое тип - ";
	obj.setType();
	cout << "введите новый класс - ";
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
	cout << "1)Название\n2)Год выпуска\n3)Макс скорость\n4)Грузаподъемность\n5)Высота\n6)Тип\n7)Класс" << endl;
	switch (_getch())
	{
	case '1':
		cout << getName() << endl;
		cout << "введите новое имя - ";
		 setName(); break;
	case '2':
		cout << getMY() << endl;
		cout << "введите новый год выпуска - ";
		cin >> MadeYear; break;
	case '3':
		cout << getMS() << endl;
		cout << "введите новую макс скорость - ";
		cin >> maxspeed; break;
	case '4':
		cout << getMW() << endl;
		cout << "введите новую макс нагрузку - ";
		cin >> MaxWeith; break;
	case '5':
		cout << getHight() << endl;
		cout << "введите новую высоту - ";
		cin >> hight; break;
	case '6':
		cout <<getType() << endl;
		cout << "введите новое тип - ";
		cin >> type; break;
	case '7':
		cout << getKlass() << endl;
		cout << "введите новый класс - ";
		cin >> klass; break;
	default:cout << "ERROR" << endl; break;
	}

}