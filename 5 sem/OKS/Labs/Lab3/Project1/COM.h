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
    void SetParams();               //��������� COM-�����
    void GetParams();               //��������� ���������� COM-�����
    void WriteCOM(int* flag, COM* COM);       //������ � COM-����
    void ReadCOM(int* flag);        //������ �� COM-�����
    void ChangeSpeed();             //��������� �������� COM-�����
};