#pragma once 
#include <windows.h> 
#include <iostream> 
#include "conio.h" 
using namespace std;

int menu()
{
    system("cls");
    cout << "1 - Записать в COM_1 " << endl
        << "2 - Считать из COM_2" << endl
        << "3 - Изменить скорость для COM_1" << endl
        << "4 - Изменить скорость для COM_2" << endl
        << "5 - Данные COM-портов" << endl
        << "0 - Выход" << endl;
    return _getch();
}

//Настройка COM-порта 
void SetParams(HANDLE Port)
{
    DCB Params = { 0 }; //Экземпляр стуктуры, использует для настройки параметров передачи данных через COM_ПОРТ 
    if (Port == INVALID_HANDLE_VALUE)//открытие не удалось 
    {
        if (GetLastError() == ERROR_FILE_NOT_FOUND)//ошибка при вызове CreatrFile 
            cout << "Порт не существует!" << endl;
        else cout << "Неизвестная ошибка!" << endl;

    }
    Params.DCBlength = sizeof(Params); //размер структуры DCB 
    if (!GetCommState(&Port, &Params)); //GetCommState - получение текущих параметров коммуникаций 
    cout << "Ошибка получения параметров" << endl;
    Params.BaudRate = 9600; //Скорость передачи 
    Params.ByteSize = 8;    //Кол-во битов данных 
    Params.StopBits = ONESTOPBIT; //Стоп-бит 
    Params.Parity = NOPARITY;     //Паритет(без) 
    if (!SetCommState(Port, &Params))
        cout << "Ошибка настройки!" << endl;
}

//Получение параметров COM-порта 
void GetParams(HANDLE Port1, HANDLE Port2)
{
    DCB Params1 = { 0 }; //Структура для настройки параметров 
    DCB Params2 = { 0 };
    if (!GetCommState(Port1, &Params1) || !GetCommState(Port2, &Params2))
    {
        cout << "Ошибка получения параметров!" << endl;
    }
    cout << "Скорость COM_1: " << Params1.BaudRate << endl << "Скорость COM_2: " << Params2.BaudRate << endl;

}

//Запись в COM - порт 
void WriteCOM(HANDLE Port, int* count)
{
    char data[256] = ""; //массив для хранения вводимых данных 
    cout << "Введите строку для передачи: ";
    cin >> data;
    DWORD size = strlen(data); //Длина используется для определения количества байт, кторые будут записаны 
    DWORD bytes; //содержит количество байт 
    BOOL Ret = WriteFile(Port, &data, size, &bytes, NULL);//Port - представленный дескриптор 
    system("cls");
    cout << "Байт записано в COM_1: " << bytes << "\nДанные: " << data << endl;
    *count += bytes; //отслеживание общего кол-ва байт 
}

//Чтение из COM - порта 
void ReadCOM(HANDLE port, int* count)
{
    if (*count != 0)
    {
        DWORD size = 0; //Безнаковое 32-битное целое число(представление целых чисел) 
        char buffer;
        cout << "Байт считано из COM_2: " << *count << "\nДанные: ";
        for (int i = 0; i < *count; i++)
        {
            //Читает 1 байт из port, записывает его в buffer,  
            // size - кол-во успешно прочитанных байт 
            //1 - кол-во байт, NULL - УКАЗАЕТЛЬ НА СТРУКТУРУ OVERLAPPED(асинхронаая операция чтения/записи) 
            ReadFile(port, &buffer, 1, &size, NULL);
            cout << buffer;
        }
    }
    else
        cout << "Нет данных для считывания" << endl;
    *count = 0;
}

//Изменение скорости СОМ - порта 
void ChangeSpeed(HANDLE Port)
{
    system("cls");
    int n;
    cout << "Введите скорость: ";
    cin >> n;
    DCB Params = { 0 }; //инициализация с начальным значением 
    if (!GetCommState(Port, &Params)) //Необходимо для настройки COM - портов(получение текущих параметров коммуникаций) 
    {
        cout << "Ошибка получения данных" << endl;
    }
    Params.BaudRate = n;
    if (!SetCommState(Port, &Params)) //Необходимо для настройки COM - портов(получение текущих параметров коммуникаций) 
    {
        cout << "Ошибка настройки" << endl;
    }
    system("cls");
    cout << "Установлена скорость: " << n << endl;
}