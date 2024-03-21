#include <iostream>
#include <cmath>
using namespace std;

float FuncSin(float x) {//������� ��������� ������.
    return sin(x);
}
void func(float* mass)
{
    _asm
    {
        mov esi, [mass]
        mov ecx, 10
        lp:
        fld dword ptr[esi]
            fsin
            fstp[esi]

            add si, 4
            loop lp
    }
}

int main() {
    setlocale(LC_ALL,"rus");
    float arr[10];//�������������� ������.
    float sinarr[10];//������ ����� ���������� ����������.
    for (int i = 0; i < 10; i++) {//��������� ������.
        cout << "������� " << i + 1 << "-�� ������� �������: " << endl;
        cin >> arr[i];
    }

    cout << "��������� ������: " << endl;
    for (int i = 0; i < 10; i++) {//������� ������
        cout << arr[i] << ' ';
    }

    for (int i = 0; i < 10; i++) {//��������� � ��������� � ����� ������.
        sinarr[i] = FuncSin(arr[i]);
    }

    cout << "������ � ��������: " << endl;
    for (int i = 0; i < 10; i++) {//������� ������ � ��������
        cout << sinarr[i] << ' ';
    }
    return 0;
}