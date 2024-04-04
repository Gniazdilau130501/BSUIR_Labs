#pragma once 
#include <windows.h> 
#include <iostream> 
#include "conio.h" 
using namespace std;

int menu()
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

//��������� COM-����� 
void SetParams(HANDLE Port)
{
    DCB Params = { 0 }; //��������� ��������, ���������� ��� ��������� ���������� �������� ������ ����� COM_���� 
    if (Port == INVALID_HANDLE_VALUE)//�������� �� ������� 
    {
        if (GetLastError() == ERROR_FILE_NOT_FOUND)//������ ��� ������ CreatrFile 
            cout << "���� �� ����������!" << endl;
        else cout << "����������� ������!" << endl;

    }
    Params.DCBlength = sizeof(Params); //������ ��������� DCB 
    if (!GetCommState(&Port, &Params)); //GetCommState - ��������� ������� ���������� ������������ 
    cout << "������ ��������� ����������" << endl;
    Params.BaudRate = 9600; //�������� �������� 
    Params.ByteSize = 8;    //���-�� ����� ������ 
    Params.StopBits = ONESTOPBIT; //����-��� 
    Params.Parity = NOPARITY;     //�������(���) 
    if (!SetCommState(Port, &Params))
        cout << "������ ���������!" << endl;
}

//��������� ���������� COM-����� 
void GetParams(HANDLE Port1, HANDLE Port2)
{
    DCB Params1 = { 0 }; //��������� ��� ��������� ���������� 
    DCB Params2 = { 0 };
    if (!GetCommState(Port1, &Params1) || !GetCommState(Port2, &Params2))
    {
        cout << "������ ��������� ����������!" << endl;
    }
    cout << "�������� COM_1: " << Params1.BaudRate << endl << "�������� COM_2: " << Params2.BaudRate << endl;

}

//������ � COM - ���� 
void WriteCOM(HANDLE Port, int* count)
{
    char data[256] = ""; //������ ��� �������� �������� ������ 
    cout << "������� ������ ��� ��������: ";
    cin >> data;
    DWORD size = strlen(data); //����� ������������ ��� ����������� ���������� ����, ������ ����� �������� 
    DWORD bytes; //�������� ���������� ���� 
    BOOL Ret = WriteFile(Port, &data, size, &bytes, NULL);//Port - �������������� ���������� 
    system("cls");
    cout << "���� �������� � COM_1: " << bytes << "\n������: " << data << endl;
    *count += bytes; //������������ ������ ���-�� ���� 
}

//������ �� COM - ����� 
void ReadCOM(HANDLE port, int* count)
{
    if (*count != 0)
    {
        DWORD size = 0; //���������� 32-������ ����� �����(������������� ����� �����) 
        char buffer;
        cout << "���� ������� �� COM_2: " << *count << "\n������: ";
        for (int i = 0; i < *count; i++)
        {
            //������ 1 ���� �� port, ���������� ��� � buffer,  
            // size - ���-�� ������� ����������� ���� 
            //1 - ���-�� ����, NULL - ��������� �� ��������� OVERLAPPED(����������� �������� ������/������) 
            ReadFile(port, &buffer, 1, &size, NULL);
            cout << buffer;
        }
    }
    else
        cout << "��� ������ ��� ����������" << endl;
    *count = 0;
}

//��������� �������� ��� - ����� 
void ChangeSpeed(HANDLE Port)
{
    system("cls");
    int n;
    cout << "������� ��������: ";
    cin >> n;
    DCB Params = { 0 }; //������������� � ��������� ��������� 
    if (!GetCommState(Port, &Params)) //���������� ��� ��������� COM - ������(��������� ������� ���������� ������������) 
    {
        cout << "������ ��������� ������" << endl;
    }
    Params.BaudRate = n;
    if (!SetCommState(Port, &Params)) //���������� ��� ��������� COM - ������(��������� ������� ���������� ������������) 
    {
        cout << "������ ���������" << endl;
    }
    system("cls");
    cout << "����������� ��������: " << n << endl;
}