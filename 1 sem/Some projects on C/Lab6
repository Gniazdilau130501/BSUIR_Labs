// Lab Work_6.cpp: определяет точку входа для консольного приложения.
//


#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;


	int main(){
		setlocale(LC_ALL, "RUSSIAN");
		int len, lens;
		int a = 1;
		char st[30];
		puts("введите 1 и 0( до 30 сим)");
		gets_s(st);
		len = lens = 0;
		int b = 0;
		int p= strlen(st); //измерение длины строки



		//////////////поиск окончания групп цифр
		for (int i = 0; i < p; i++){
			if (st[i] != ' '){//поиск цифр
				b += 1;//измерение длинны группы 
			}
			if (st[i] == ' '){//поиск пробела после между группами чисел




				////////////прверка нечётности длинны группы чисел
				int d = b % 2;
				if (d == 0){//пропуск группы, если ее длина четная
					b = 0;
				}else if (d != 0){



					/////////подсчёт цифр
					for (int t = i - b; t < i; t++){
						if (st[t] == '1'){
							len++;
						}
						else if (st[t] == '0'){
							lens++;
						}
					}
					cout << "кол-во 1 - " << len << ' ' << "кол-во 0 - " << lens << endl;
					b = 0;
				}
			}
			len = 0;
			lens = 0;	
		}
		return 0;
	}
	

