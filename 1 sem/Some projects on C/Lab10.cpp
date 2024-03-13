// LabWork_21.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <string.h>
#include <windows.h>
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;
int nonrec(int[]);
int rec(int[],int);

int main()
 {
	setlocale(LC_ALL, "rus");
	int k;
	int st[]={0,1,2,3,4,5,6,7,8,9}; 
	cout << "исходный массив: ";
	for (int y = 0; y < 10;y++)
	cout << st[y];//массив, который будет выводиться с последнего символа
	cout << endl;
	cout << "выберете метод решения:1)без рекурсии; 2)с рекурсией " << endl;
	cin >> k;
	system("cls");


	////////////////
	switch (k){                                   //выбор пользователем метода решения
	case 1:nonrec(st); break;
	case 2:rec(st, 9); break;
	default:cout << "Ошибка: Метод не выбран" << endl; main();
	}
	
	return 0;
}


    ////////////////
int nonrec(int b[]) {                            //решение обычным циклом
	for (int i = 9; i >= 0; i--)
	cout << b[i];
	cout << endl;
	return 0;
}



    ///////////////
int rec(int a[],int i){                          //решение методом рекурсии
	
		if (i != -1){              //условие, при котором функция вызывает себя повторно с новыми данными
			cout<< a[i];
			return rec(a, i - 1);
		}else{                     //завершение самовызова функции из-за не соответствия условия
			cout << endl;
			return 0;
		}
}
