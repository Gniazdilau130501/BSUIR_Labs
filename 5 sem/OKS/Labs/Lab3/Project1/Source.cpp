#include "COM.h"

int menu()   //����
{
    system("cls");
    cout << "1 - �������� � COM_1 " << endl
        << "2 - ������� �� COM_2" << endl
        << "3 - �������� �������� ��� COM_1" << endl
        << "4 - �������� �������� ��� COM_2" << endl
        << "5 - ������ COM-������" << endl
        << "0 - �����" << endl;
    return _getch();
}

int main()
{
    system("chcp 1251 > null");

    COM COM_1("WRITE");
    COM COM_2("READ");

    COM_1.SetParams();
    COM_2.SetParams();

    int flag = 0;

    while (1)
    {
        switch (menu())
        {
        case '1': system("cls"); COM_1.WriteCOM(&flag, &COM_2); _getch(); break;
        case '2': system("cls"); COM_2.ReadCOM(&flag); _getch(); break;
        case '3': system("cls"); COM_1.ChangeSpeed(); _getch(); break;
        case '4': system("cls"); COM_2.ChangeSpeed(); _getch(); break;
        case '5': system("cls"); COM_1.GetParams(); COM_2.GetParams(); _getch(); break;
        case '0': system("cls"); cout << "������ ���������."; return 0;
        }
    }
    return 0;
}