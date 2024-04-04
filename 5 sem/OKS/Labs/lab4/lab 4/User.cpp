#include "USER.h"

string code(string data)
{
    string ret;

    for (int i = 0; i < data.length(); i++)
    {
        stack<int> ST;
        int count = 0;
        string str;
        int a, t, d;

        t = 0;
        d = 1;
        a = data[i];

        while (a) { t += (a % 2) * d; a = a / 2; d = d * 10; }

        do
        {
            ST.push(t % 10);
            t /= 10;
            count++;
        } while (t);

        count = 8 - count;

        for (int i = 0; i < count; i++)
            str += '0';


        while (!ST.empty())
        {
            t = ST.top();
            ST.pop();
            char s = { char(t + '0') };
            str += s;
        }
        ret += str;
    }
    return ret;
}

USER::USER()
{
    system("cls"); cout << "Введите имя пользователя: "; cin >> this->name;
}

string USER::GetName() { return name; }

string USER::GetDataTo() { return dataTo; }

string USER::GetDataFrom() { return dataFrom; }

string USER::GetNameFrom() { return nameFrom; }

void USER::Write(string name2, HANDLE handle, int* coll, string data)
{
    char data1[256] = "";
    char data2[256] = "";
    string NameTo, NameFrom;
    string str;
    string b;
    for (int i = 0; i < data.length(); i++) data1[i] = data[i];
    system("cls");
    char s = strlen(data1);
    NameTo = name2;
    if (NameTo.length() < 10)
        for (int i = NameTo.length(); i < 10; i++)
            NameTo += '|';
    NameFrom = name;
    if (NameFrom.length() < 10)
        for (int i = NameFrom.length(); i < 10; i++)
            NameFrom += '|';
    str += NameTo;
    str += NameFrom;
    b = code(data1);
    str += b;
    str += s;
    str += '~';
    this->SetDataTo(str);
    for (int i = 0; i < str.length(); i++) data2[i] = str[i];
    DWORD size = strlen(data2);
    DWORD bytes;
    BOOL Ret = WriteFile(handle, &data2, size, &bytes, NULL);
    system("cls");
    cout << "Байт записано в COM_1: " << strlen(data1) << endl << "Данные: " << data1 << " [" << b << "]" << endl;
    *coll = 1;
}

void USER::SetDataTo(string data) { this->dataTo = data; }

void USER::SetDataFrom(string data) { this->dataFrom = data; }

void USER::SetNameFrom(string data) { this->nameFrom = data; }
