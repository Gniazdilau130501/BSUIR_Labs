#include <iostream>
#include <cmath>
using namespace std;

float FuncSin(float x) {//Функция считающая синусы.
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
    float arr[10];//Первоначальный массив.
    float sinarr[10];//Массив после выполнения вычислений.
    for (int i = 0; i < 10; i++) {//заполняем массив.
        cout << "Введите " << i + 1 << "-ый элемент массива: " << endl;
        cin >> arr[i];
    }

    cout << "Введенный массив: " << endl;
    for (int i = 0; i < 10; i++) {//Выводим массив
        cout << arr[i] << ' ';
    }

    for (int i = 0; i < 10; i++) {//Вычисляем и добавляем в новый массив.
        sinarr[i] = FuncSin(arr[i]);
    }

    cout << "Массив с синусами: " << endl;
    for (int i = 0; i < 10; i++) {//Выводим массив с синусами
        cout << sinarr[i] << ' ';
    }
    return 0;
}