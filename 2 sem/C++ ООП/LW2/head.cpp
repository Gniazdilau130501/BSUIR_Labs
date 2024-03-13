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
		cout << "Выберите перегрузку"<<endl;
	cout << "1)Присваивание(=)\n2)Сравнение(==)\n3)Сложение(+)\n4)Сложение с присваиванием(+=)\n5)Возвращение индекса([])\n6)Возвращение подстроки\n0)Выход" << endl;
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
        cout << "Введите строку, которая будет присвоена второму объекту" << endl;
		char ss[50];
		cin >> ss;
		String first(ss);
		String second ("");
		second = first;
		cout << "Объект 1 - ";
		first.get();
		cout << "Объект 2 - ";
		second.get();
	}


void sravnenie()
{
	cout << "Введите первую строку сравнения" << endl;
	char ss[50];
	cin >> ss;
	cout << "Введите вторую строку сравнения" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	cout << "Объект 1 - ";
	first.get();
	cout << "Объект 2 - ";
	second.get();
	if (second == first)
	{
		cout << "Введенные строки равны" << endl;
	}
	else
	{
		cout << "Введенные строки не равны" << endl;
	}
}

void slozhenie()
{
	cout << "Введите первую строку" << endl;
	char ss[50];
	cin >> ss;
	cout << "Введите вторую строку" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	String third;
	third=first + second;
	cout << "Объект 1 - ";
	first.get();
	cout << "Объект 2 - ";
	second.get();
	cout << "Объект 1+2 - ";
	third.get();
	
}

void slozhenie2()
{
	cout << "Введите первую строку" << endl;
	char ss[50];
	cin >> ss;
	cout << "Введите вторую строку" << endl;
	char cc[50];
	cin >> cc;
	String first(ss);
	String second(cc);
	cout << "Объект 1 - ";
	first.get();
	cout << "Объект 2 - ";
	second.get();
	first = first += second;
	cout << "Объект 1+=2 - ";
	first.get();
}

void index()
{
	cout << "Введите строку, которая будет присвоена объекту" << endl;
	char ss[50];
	cin >> ss;
	String first(ss);
	cout << "Введите индекс, который следует вернуть" << endl;
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
	cout << "Введите строку, которая будет присвоена объекту" << endl;
	char ss[50];
	cin >> ss;
	String first(ss);
	cout << "Введите индекс, c которого следует вернуть" << endl;
	int index;
	cin >> index;
	cout << "Введите кол-во символов выводимых после заданного индекса"<< endl;
    int cc;
	cin >> cc;
	cout<<first(index-1,cc);
	cout << endl;
}