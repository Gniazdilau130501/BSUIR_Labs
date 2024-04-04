#include <windows.h>
#include <iostream>
#include "conio.h"
#include <string>
#include <stack>
#include <cmath>
using namespace std;

class COM
{
private:
    char name[5];
    HANDLE handle;
public:
    COM(string str);
    void SetParams();               //настройка COM-порта
    void GetParams();               //получение параметров COM-порта
    void WriteCOM(int* flag, COM* COM);       //запись в COM-порт
    void ReadCOM(int* flag);        //чтение из COM-порта
    void ChangeSpeed();             //изменение скорости COM-порта
};