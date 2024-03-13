// LabWork_3(2).cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

int main()
{
	int n = 200, i,t;
	double a = 0.1, b = 1.0, h = (b - a) / 10, x, p, S, Y;


	cout << " x       Y(x)     S(x)      (Y-S)\n";
	for (x = a; x <= b; x += h)    //установка значения Х, условие выполнения пока Х меньше b, установка шага h
	{
		S = p = 1;                  

		for (i = 1; i < n; i++)    //счётчик, позволяющий в каждом новом члене использовать n на один больше предыдущего
		{

			


			p *= x*x/ i;
			S += p*(2 * i + 1);                        //сумма которую мы выводим, где Р- каждый новый член сложения
		}

		Y = (1+2*pow(x,2))*exp(pow(x,2));//табличное значение У с использованием каждого нового Х (который изменяется с шагом h)

		cout << setprecision(2) << fixed << x << "  " << setprecision(6) << Y << "  " << S << "  " <<fabs( Y-S) <<endl;
	}

	return 0;
}

