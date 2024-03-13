// Lab Work _2.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "stdio.h"
#include "conio.h"
#include "math.h"
#include <locale.h>
//библиотеки позволившие поменять цвет текста:
#include <iostream> 
#include <cstdlib>

using namespace std;


int main()
{
	setlocale(LC_ALL, "RUSSIAN");//установка русского языка
	system ("color a");//применение цвета шрифта
	double x, y, f, s;
	int k;
	puts("Пожалуйста, введите  x, y");
	scanf_s("%lf%lf", &x, &y);
	puts("\n Сделайте выбор функции f: \n 1:f = sinh(x);\n 2:f = pow(x, 2);\n 3:f = exp(x);");
	scanf_s("%d", &k);
	    //вариант программы через функцию switch

	    switch (k)
	    {
	      case 1:f = sinh(x);break;
	      case 2:f = pow(x, 2); break;
	      case 3:f = exp(x); break;
	      default: puts("Функция не выбрана");
	      return 1;
	    }

	 /* if (k == 1){      //выбор функции
		f = sinh(x);
	  }
	  else if (k == 2){
		f = pow(x, 2);
	  }
	  else if (k == 3){
		f = exp(x);
	  }
	  else{
		printf("Функция не выбрана");
		return 0;
	  }*/


	       if (x > y){      //решение исходя из подходящего условия
		        s = y*sqrt(f) + 3 * sin(x);
	       }
	       else if (x < y){
	        	s = x*sqrt(f);
	       }
	       else{
		        s = pow(f, 1. / 3.) + (pow(x, 3) / y);
	       }
	 printf("\n Результат = %.2lf\n", s);   //вывод ответа с тремя знаками после запятой
 	
	return 0;
}

