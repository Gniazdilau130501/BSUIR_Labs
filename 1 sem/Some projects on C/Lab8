// 8lab.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
#include <math.h>
#include <iomanip>
using namespace std;


typedef double(*uf)(double, double, int &);                 //указатель на функцию
void tabl(double, double, double, double, uf);              //объявление функции выводящей табл.
double y(double, double, int &);                            //объявление функции вычисляющей у
double s(double, double, int &);                            //вычисление функции вычисляющей s
int main()
{
	setlocale(LC_ALL, "RUSSIAN");
	double a, b, eps;
	cout << "Введите а, b и точность" << endl;
	cin >> a >> b >> eps;                                  
	cout << setw(8) << "x" << setw(15) << "y(x)" << setw(10) << "k" << endl;
	tabl(a, b, 0.1, eps, y);                                 //вызов функции с у
	cout << endl;
	cout << setw(8) << "x" << setw(15) << "s(x)" << setw(10) << "k" << endl;
	tabl(a, b, 0.1, eps, s);                                 //вызов функции с s
	return 0;
}


////////////
void tabl(double a, double b, double h, double eps, uf fun)
{
	int k = 0;
	double sum;
	for (double x = a; x < b + h / 2; x += h)
	{
		sum = fun(x, eps, k);                               //присваивание сумме значения, которое возвращает вызванная функция s или у
		cout << setw(8) << x << setw(15) << sum << setw(10) << k << endl;
	}
}


//////////////
double y(double x, double eps, int &k)                      
{
	return -x + asin(x);
}


/////////////
double s(double x, double eps, int &k)
{
	double a, c = y(x, eps, k), sum, p;
	p = 1 / 2.;
	a = pow(x, 3);
	sum = pow(x, 3) / 6;
	k = 2;
	while (fabs(sum - c) >= eps/**0.1*/ )
	{
		a *= x*x;
		p *= (2 * k - 1) / ((double)2 * k);
		sum += (a*p) / (2 * k + 1);
		k++;
	}
	return sum;
}

