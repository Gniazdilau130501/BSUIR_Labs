#include "USER.h"

void f(list* list)
{
    USER* temp = list->GetHead();
    while (1)
    {
        temp->marker = *list->GetMarker();
        Sleep(5000);
        temp->marker = 0;
        temp = temp->next;
    }
}

int menu()
{
    system("cls");
    cout << "1 - Добавить пользователя" << endl
        << "2 - Список пользователей" << endl
        << "3 - Передать данные" << endl
        << "4 - Получить данные" << endl
        << "0 - Выход" << endl;
    return _getch();
}

int main()
{
    system("chcp 1251 > null");

    HANDLE handle1 = ::CreateFile(L"COM1", GENERIC_WRITE, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    HANDLE handle2 = ::CreateFile(L"COM2", GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

    list list;
    int i = 0;

    while (1)
    {
        switch (menu())
        {
        case '1': { list.add(); i++; } break;
        case '2': list.GetList(); break;
        case '3': list.SendData(handle1, handle2); break;
        case '4': list.GetInfo(); break;
        case '0': { system("cls"); cout << "Работа завершена."; return 0; }
        }
        if (i == 1)
        {
            thread thr(f, &list);
            thr.detach();
        }
    }
    return 0;
}
