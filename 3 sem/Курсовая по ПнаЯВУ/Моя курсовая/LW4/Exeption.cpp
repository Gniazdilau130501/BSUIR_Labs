#include "Exeptoin.h"
//Exeption::Exeption(const Exeption& temp)
//{
//	m = temp.m;           
//	err = temp.err;
//}

Exeption::Exeption(int num,const string str)
{
	m = num;           
	err = str;
}

Exeption::~Exeption()
{

}

void Exeption::show()
{
	cout << err << endl;
}

string chek_str()
{
	string t_str;
	bool flag;
	do
	{
		try
		{
			cin >> t_str;
			flag = 1;
			for (int i = 0; t_str[i]; i++)
			{
				if (!(t_str[i] >= 'A' && t_str[i] <= 'Z') &&
					!(t_str[i] >= 'a' && t_str[i] <= 'z') &&
					!(t_str[i] >= '�' && t_str[i] <= '�') &&
					t_str[i] != '-'
					)
				{
					throw Exeption(1, "����������� ����� ���������� ��� �������� �������� ��� �����");
				}

			}

			if(!(t_str[0] >= '�' && t_str[0] <= '�'))
			for (int i = 0; t_str[i]; i++)
			{
				if (
					(t_str[i] >= '�' && t_str[i] <= '�')
					)
				{
					throw Exeption(3, "����������� ��������� �������");
				}
			}

			if ((t_str[0] >= '�' && t_str[0] <= '�'))
				for (int i = 0; t_str[i]; i++)
				{
					if (
						!(t_str[i] >= '�' && t_str[i] <= '�')
						)
					{
						throw Exeption(3, "����������� ������� �������");
					}
				}
		}
		catch (Exeption& obj)
		{
			flag = 0;
			obj.show();
		}
	} while (!flag);
	return t_str;
}

int chek_num()
{
	bool flag;
	int t_num = 0;
	do
	{
		rewind(stdin);
	//fflush(stdin);
		try
		{
			flag = 1;
			if(!(cin >> t_num)||t_num <= 0 || t_num> 999999999)
			{
				throw Exeption(2, "������� ����� ������ 0 � ������ 999999999");
			}
		}
		catch (Exeption& obj)
		{

			rewind(stdin);
			cin.clear();
			flag = 0;
			obj.show();
		}
	} while (!flag);
	return t_num;
}