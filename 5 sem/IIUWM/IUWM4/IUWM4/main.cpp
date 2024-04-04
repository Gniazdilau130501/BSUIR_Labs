#include "WEB.h"

void menu()
{
	cout << endl << "1 - Скрыть окно"
		<< endl << "2 - Запись видео"
		<< endl << "3 - Показать окно"
		<< endl << "0 - Выход"
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
			cout << "Работа завершена!" << endl;
			return 0;
		}
		}
	}
}