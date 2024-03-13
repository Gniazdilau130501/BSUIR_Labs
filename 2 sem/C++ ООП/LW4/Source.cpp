#include "shablon.h"
#include"samosval.h"


int main()
{
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	transport<samosval>* p = NULL;
	transport<avtobus>*p_a = NULL;
	transport<tralik>* p_t = NULL;
	string str;
	int num=0;
	while (1) 
	{
		cout << "1)добавить\n2)просмотреть\n3)поиск\n0)выход" << endl;
		switch (_getch())
		{
		case '1':
			system("cls");
			cout << "1)Самосвал\n2)Автобус\n3)Тралейбус" << endl;
			switch (_getch())
			{
			case'1':
				p=p->add(p);
			break;

			case '2':
				p_a = p_a->add(p_a);
			break;
			case '3':
				p_t = p_t->add(p_t);
			break;
			}
		break;

		case '2':
			system("cls");
			cout << "1)Самосвал\n2)Автобус\n3)Тралейбус" << endl;
			switch (_getch())
			{
			case'1':
				p = p->out(p);
			break;

			case'2':
				p_a = p_a->out(p_a);
			break;
			case'3':
				p_t = p_t->out(p_t);
			break;	
			}
		break;
		case '3':
			system("cls");
			cout << "Поиск по:\n 1)Строковым значениям\n2)Численным значениям" << endl;
			switch (_getch())
			{
			case '1':
				cout << "Введите что-нибудь - ";
				cin >> str;
				p->shapka();
				p->search(p, str);
				p_a->shapka();
				p_a->search(p_a, str);
				p_t->shapka();
				p_t->search(p_t, str);
				break;
			case '2':
				cout << "Введите что-нибудь - ";
				cin >> num;
				p->shapka();
				p->search2(p, num);
				p_a->shapka();
				p_a->search2(p_a, num);
				p_t->shapka();
				p_t->search2(p_t, num);
				break;
			default:cout << "ERROR" << endl;
				//тут будет поиск
			}
		break;
		case'0':
			exit(0);
			break;
		}
		system("pause");
 		system("cls");
	}
	return 0;
}