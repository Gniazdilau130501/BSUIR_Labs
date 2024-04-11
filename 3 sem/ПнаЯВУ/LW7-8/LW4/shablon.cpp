#include "shablon.h"
template<class A>
shablon<A>::shablon()
{
	p_first = nullptr;
	p_last = nullptr;
	size = 0;
}

template<class A>
shablon<A>::~shablon()
{}

template<class A>
ochered<A>* shablon<A>:: getFirst()
{
	return p_first;
}

template<class A>
void shablon<A>:: getObj(A t)
{
	cout << endl << t;
}

template<class A>
void shablon<A>:: add(A p)
{
	ochered<A>* car = new ochered<A>;
	car->object = p;
	++size;
	if (p_first == nullptr || p_last == nullptr)
	{

		car->p_right = nullptr;
		car->p_left = nullptr;
		p_first = car;
		p_last = car;
	}
	else
	{
		car->p_right = p_first;
		car->p_left = nullptr;
		p_first->p_left = car;
		p_first = car;
	}
}

template<class A>
bool shablon<A>::poisk(A peremennaia)
{
	ochered<A>* obj = p_first;
	peremennaia.shapka();
	while (obj != NULL)          //пока не конец очереди
	{
		if (obj->object == peremennaia)
		{
			cout << obj->object << endl;
		}
			obj = obj->p_right;
	}
	system("pause");
	return false;
}

template<class A>
void shablon<A>::out()
{
	ochered<A>* t;
	t = this->p_first;
	t->object.shapka();
	while (t != nullptr)
	{
		getObj(t->object);
		t = t->p_right;
	}
	cout << endl;
}

template<class A>
void shablon<A>:: del()
{
	ochered<A>* t;
	t = this->p_first;
	while (t != nullptr)
	{
	
		system("cls");
		t->object.shapka();
		getObj(t->object);
		cout << endl<<"Ќажмите d - чтобы листать вправо или a - чтобы влево\n0-чтобы выйти\nc-чтобы удалить" << endl;
		switch (_getch())
		{
		case'd':
			if (t ->p_right == nullptr)
				cout << "\nЁлемент отсутсвует" << endl;
			else
				t = t->p_right;
			break;
		case'a':
			if (t ->p_left == nullptr)
				cout << "\nЁлемент отсутсвует" << endl;
			else
				t = t->p_left;
			break;
		case'0':
			t = nullptr;
			break;
		
		case 'c':
			if (t == p_first)
				p_first = t->p_right;
			if (t == p_last)
				p_last = t->p_left;
			if (t->p_left != nullptr)
				t->p_left->p_right = t->p_right;
			if (t->p_right != nullptr)
				t->p_right->p_left = t->p_left;
			delete t;
			t = p_first;
			break;
		default:cout << "ERROR(возможно у вас русска€ раскладка)";
		}
	}
}

template<class A>
void shablon<A>::del_all()
{
	ochered<A>* t;
	t = this->p_first;
	while (t != nullptr)
	{
			if (t == p_first)
				p_first = t->p_right;
			if (t->p_right != nullptr)
				t->p_right->p_left = t->p_left;
			delete t;
			t = p_first;
	}
}

template<class A>
void shablon<A>::nastr()
{
	ochered<A>* t;
	t = this->p_first;
	while (t != nullptr)
	{

		system("cls");
		t->object.shapka();
		getObj(t->object);
		cout << endl<<"Ќажмите d - чтобы листать вправо или a - чтобы влево\n0-чтобы выйти\ns-чтобы открыть меню настройки" << endl;
		switch (_getch())
		{
		case'd':
			if (t->p_right == nullptr)
				cout << "\nЁлемент отсутсвует" << endl;
			else
				t = t->p_right;
			break;
		case'a':
			if (t->p_left == nullptr)
				cout << "\nЁлемент отсутсвует" << endl;
			else
				t = t->p_left;
			break;
		case'0':
			t = nullptr;
			break;
		case 's':
			t->object.setting();
			break;
		default:cout << "ERROR(возможно у вас русска€ раскладка)";
		}
	}
}

template <class A>
void shablon<A>::writeF()  //запись в файл
{
	ofstream f1("salon.bin", ios::binary | ios::out);
	if (!f1.is_open())
	{
		cout << "файл не открыт\n";
	}
	else
	{
		system("cls");
		ochered<A>* temp;
		temp = getFirst();
		while (temp)
		{
			f1.write((char*)&temp->object, sizeof temp->object);
			temp = temp->p_right;
		}
	}
	f1.close();
}

template <class A>
void shablon<A>::readF() //чтение из файла
{   
	ifstream f2("salon.bin", ios::binary | ios::in);
	A obj = A();
	while (f2.read((char*)&obj, sizeof obj))
	{
		this->add(obj);
	}
	f2.close();
}
