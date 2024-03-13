// 10 naverno.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <string.h>
#include <windows.h>
#include <iostream>
#include <iomanip>
#include <cmath>
#include <conio.h>
#include<stdarg.h>
using namespace std;

double varFormat(int type[], ...)
{
	va_list ap; // ap - argument pointer
	double sum = 0;
	int i = 0;
	//if (type == 0) return sum;
	va_start(ap, type);
	do
	{
		switch (type[i])
		{
		case 1:
			sum += va_arg(ap, int); // берём целое значение 
			break;
		case 2:
			sum += va_arg(ap, long); // берём целое длинное значение 
			break;
		case 3:
			sum += va_arg(ap, double); // берём вещественное значение
			break;
		default:
			printf("Ne pravilny format");
			return 0;
		}
		i++;
	//	type[i] = va_arg(ap, int);//opredelyaem tip sleduuzhey
	} while (i<5);
	va_end(ap);
	return sum;
}

void main()
{
	printf("1, 12, 1, 3, 2.5\n sum = ");
	int str[] = { 1, 2, 1, 1, 3 };
	printf("%f \n", varFormat(str,1,12L, 1, 3, 2.5));
	
	_getch();
}

