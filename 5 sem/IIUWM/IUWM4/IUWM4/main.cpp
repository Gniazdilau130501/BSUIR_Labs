#include "WEB.h"

void menu()
{
	cout << endl << "1 - ������ ����"
		<< endl << "2 - ������ �����"
		<< endl << "3 - �������� ����"
		<< endl << "0 - �����"
		<< endl;
}

int main() {
	ShowWindow(GetConsoleWindow(), SW_NORMAL);

	system("chcp 1251");

	WEB CAM;

	while (1)
	{
		system("cls");
		CAM.GetData();
		menu();
		switch (_getch())
		{
		case '1':
		{
			ShowWindow(GetConsoleWindow(), SW_HIDE);
			break;
		}
		case '2':
		{
			CAM.TakeVideo();
			break;
		}
		case '3':
		{
			ShowWindow(GetConsoleWindow(), SW_NORMAL);
			break;
		}
		case '0':
		{
			system("cls");
			ShowWindow(GetConsoleWindow(), SW_NORMAL);
			cout << "������ ���������!" << endl;
			return 0;
		}
		}
	}
}