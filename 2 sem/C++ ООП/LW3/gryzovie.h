class gryzovie : public transrport
{
protected:
	int MaxWeith;
	int hight;
public:
	gryzovie()
	{
		MaxWeith = 0;
		hight = 0;
	}
	void setMW()
	{
		cout << MaxWeith << endl;
		cout << "введите новую макс нагрузку - ";
		cin >> MaxWeith;
	}
	void setHight()
	{
		cout << hight << endl;
		cout << "введите новую высоту - ";
		cin >> hight;
	}
	int getMW()
	{
		return MaxWeith;
	}
	int getHight()
	{
		return hight;
	}
	void shapka()
	{
		cout << setiosflags(ios::left)
			<< setw(10) << "Название"
			<< setw(12) << "Год выпуска"
			<< setw(15) << "Макс скорость"
			<< setw(17) << "Грузоподъёмность"
			<< setw(10) << "Высота";
	}
	//friend istream& operator >> (istream& in, gryzovie& obj)
	//{
	//	cout << "имя" << endl;
	//	obj.setName();
	//	cout << "год выпуска" << endl;
	//	obj.setMY();
	//	cout << "макс скорость" << endl;
	//	obj.setMS();
	//	cout << "макс нагрузка" << endl;
	//	obj.setMW();
	//	cout << "высота" << endl;
	//	obj.setHight();
	//	return in;
	//}
	//friend ostream& operator << (ostream& out, const  gryzovie& obj)
	//{
	//	return out << "имя" << endl
	//		<<obj.name << endl
	//		<< "Год выпуска" << endl
	//		<< obj.MadeYear << endl
	//		<< "макс скорость" << endl
	//		<< obj.maxspeed << endl 
	//		<< "макс нагрузка" << endl
	//		<< obj.MaxWeith << endl
	//		<< "высота" << endl
	//		<< obj.hight << endl;
	//}
};