#include "Class.h"
void ravno();
void sravnenie();
void slozhenie();
void slozhenie2();
void index();
void potstroka();

int main()
{
	setlocale(LC_ALL, "Russian");
	int k;
	while (1){
		cout << "�������� ����������"<<endl;
	cout << "1)������������(=)\n2)���������(==)\n3)��������(+)\n4)�������� � �������������(+=)\n5)����������� �������([])\n6)����������� ���������\n0)�����" << endl;
	cin >> k;
		switch (k)
		{
		case 1:ravno(); system("pause"); system("cls"); break;
		case 2:sravnenie(); system("pause"); system("cls"); break;
		case 3:slozhenie(); system("pause"); system("cls"); break;
		case 4:slozhenie2(); system("pause"); system("cls"); break;
		case 5:index(); system("pause"); system("cls"); break;
		case 6:potstroka(); system("pause"); system("cls"); break;
		case 0:exit(0);
		}
	}
	return 0;
}

void ravno()
	{
        cout << "������� ������, ������� ����� ��������� ������� �������" << endl;
		char ss[50];
		cin >> ss;
		String first(ss);
		String second ("");
		second = first;
		cout << "������ 1 - ";
		first.get();
		cout << "������ 2 - ";
		second.get();
	}


void sravnenie()
{
	cout << "������� ������ ������ ���������" << endl;
	char ss[50];
	cin >> ss;
	cout << "������� ������ ������ ���������" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	cout << "������ 1 - ";
	first.get();
	cout << "������ 2 - ";
	second.get();
	if (second == first)
	{
		cout << "��������� ������ �����" << endl;
	}
	else
	{
		cout << "��������� ������ �� �����" << endl;
	}
}

void slozhenie()
{
	cout << "������� ������ ������" << endl;
	char ss[50];
	cin >> ss;
	cout << "������� ������ ������" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	String third;
	third=first + second;
	cout << "������ 1 - ";
	first.get();
	cout << "������ 2 - ";
	second.get();
	cout << "������ 1+2 - ";
	third.get();
	
}

void slozhenie2()
{
	cout << "������� ������ ������" << endl;
	char ss[50];
	cin >> ss;
	cout << "������� ������ ������" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	cout << "������ 1 - ";
	first.get();
	cout << "������ 2 - ";
	second.get();
	first = first += second;
	cout << "������ 1+=2 - ";
	first.get();
}

void index()
{
	cout << "������� ������, ������� ����� ��������� �������" << endl;
	char ss[50];
	cin >> ss;
	String first(ss);
	cout << "������� ������, ������� ������� �������" << endl;
	int index;
	cin >> index;
	char cc,cv;
	cin >> cc;
	cv = first[index - 1];
	cout << cc;
	//first[index - 1] = cc;
}

void potstroka()
{
	cout << "������� ������, ������� ����� ��������� �������" << endl;
	char ss[50];
	cin >> ss;
	String first(ss);
	cout << "������� ������, c �������� ������� �������" << endl;
	int index;
	cin >> index;
	cout << "������� ���-�� �������� ��������� ����� ��������� �������"<< endl;
    int cc;
	cin >> cc;
	cout<<first(index-1,cc);
	cout << endl;
}