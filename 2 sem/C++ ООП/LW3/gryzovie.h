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
		cout << "������� ����� ���� �������� - ";
		cin >> MaxWeith;
	}
	void setHight()
	{
		cout << hight << endl;
		cout << "������� ����� ������ - ";
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
			<< setw(10) << "��������"
			<< setw(12) << "��� �������"
			<< setw(15) << "���� ��������"
			<< setw(17) << "����������������"
			<< setw(10) << "������";
	}
	//friend istream& operator >> (istream& in, gryzovie& obj)
	//{
	//	cout << "���" << endl;
	//	obj.setName();
	//	cout << "��� �������" << endl;
	//	obj.setMY();
	//	cout << "���� ��������" << endl;
	//	obj.setMS();
	//	cout << "���� ��������" << endl;
	//	obj.setMW();
	//	cout << "������" << endl;
	//	obj.setHight();
	//	return in;
	//}
	//friend ostream& operator << (ostream& out, const  gryzovie& obj)
	//{
	//	return out << "���" << endl
	//		<<obj.name << endl
	//		<< "��� �������" << endl
	//		<< obj.MadeYear << endl
	//		<< "���� ��������" << endl
	//		<< obj.maxspeed << endl 
	//		<< "���� ��������" << endl
	//		<< obj.MaxWeith << endl
	//		<< "������" << endl
	//		<< obj.hight << endl;
	//}
};