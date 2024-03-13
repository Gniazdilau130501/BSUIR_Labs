// SeaBatle.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#include <locale.h>
#include <windows.h>
#include <iostream>
#include <ctime>
using namespace std;
int saper(); int batle(); int batlePvE();
int main(){
	srand(time(0));
	setlocale(LC_ALL, "RUSSIAN");
	printf("\nДобро пожаловать \nМЕНЮ: \n1)Секретики(PvP);\n2)Сапёр;\n3)Секретики(PvE);\n4)Сообщить об ошибке;\n0)Выход;");
	switch (_getch()){
	case '1':system("cls"); batle(); break;
	case '2':system("cls"); saper(); break;
    case '3':system("cls"); batlePvE(); break;
	case '4':system("cls"); ShellExecute(0, 0, L"https://vk.com/id534611115", 0, 0, SW_SHOW); main(); break;
	case '0':printf("\nДействительно хотите выйти?"); if (_getch() == 'y')exit(1); break;
	default:system("cls"); printf("Ошибка: не выбран пункт меню"); main();
	}
}

void vivod(char[][11]);
void kanec(char[][11], char[][11]);
char minir(char[][11], int);


int saper()
{
	setlocale(LC_ALL, "Russian");
	char pl1[10][11] = { { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" } };
	char pl2[10][11] = { { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" }, { "__________" } };
	int i = 9;
	int t = 4;
	int k;
	int m = 0;
	printf("\nДобро пожаловать в 'Сапёр'");
	printf("\nВведите количество мин на поле-");
	scanf_s("%d", &k);
	minir(pl2, k);
	pl1[t][i] = '*';
	printf("\nИспользуйте W A S D для перемещения и C+w/a/s/d для установки флажка\n");
	printf("Если вы наступите на мину или поставите флажок не верно, то проиграете\n");
	//vivod(pl2);
	while (1){
		m = 0;
		printf("\nНайти мин:%d\n", k);
		if (pl2[t - 1][i] == 'X')m++;
		if (pl2[t - 1][i - 1] == 'X')m++;
		if (pl2[t][i - 1] == 'X')m++;
		if (pl2[t + 1][i - 1] == 'X')m++;
		if (pl2[t + 1][i] == 'X')m++;
		if (pl2[t + 1][i + 1] == 'X')m++;
		if (pl2[t][i + 1] == 'X')m++;
		if (pl2[t - 1][i + 1] == 'X')m++;
		printf("Мин рядом:%d\n", m);
		vivod(pl1);
		switch (_getch()){
		case 'w':system("cls"); if (pl1[t][i - 1] == '^' || i - 1 < 0)break; pl1[t][i] = '_'; pl1[t][--i] = '*'; break;
		case 's':system("cls"); if (pl1[t][i + 1] == '^' || i + 1 > 9)break; pl1[t][i] = '_'; pl1[t][++i] = '*'; break;
		case 'd':system("cls"); if (pl1[t + 1][i] == '^' || t + 1 > 9)break; pl1[t][i] = '_'; pl1[++t][i] = '*'; break;
		case 'a':system("cls"); if (pl1[t - 1][i] == '^' || t - 1 < 0)break; pl1[t][i] = '_'; pl1[--t][i] = '*'; break;
		case 'c': printf("Установка флага, выбирете клетку рядом");
			switch (_getch()){
			case 'w':system("cls"); if (i - 1 < 0)break; if (pl2[t][i - 1] != 'X') kanec(pl1, pl2); pl1[t][i - 1] = '^'; pl2[t][i - 1] = '^'; if (--k == 0)kanec(pl1, pl2); break;
			case 's':system("cls"); if (i + 1 > 9)break; if (pl2[t][i + 1] != 'X')kanec(pl1, pl2); pl1[t][i + 1] = '^'; pl2[t][i + 1] = '^'; if (--k == 0)kanec(pl1, pl2); break;
			case 'd':system("cls"); if (t + 1 > 9)break; if (pl2[t + 1][i] != 'X')kanec(pl1, pl2); pl1[t + 1][i] = '^';  pl2[t + 1][i] = '^'; if (--k == 0)kanec(pl1, pl2);  break;
			case 'a':system("cls");  if (t - 1 < 0)break; if (pl2[t - 1][i] != 'X')kanec(pl1, pl2); pl1[t - 1][i] = '^'; pl2[t - 1][i] = '^';  if (--k == 0)kanec(pl1, pl2); break;
			}system("cls"); break;
		case 'e':exit(0); break;
		default:main();
		}
		if (pl2[t][i] == 'X')kanec(pl1, pl2);
	}



	return 0;
}

void vivod(char pl[][11]){
	printf("  0|1|2|3|4|5|6|7|8|9\n");
	for (int i = 0; i < 10; i++){
		printf("%d", i);
		for (int t = 0; t < 10; t++){
			printf("|%c", pl[t][i]);
		}
		printf("|\n");
	}
}


void kanec(char pl1[][11], char pl2[][11]){
	int i = 0;
	int t = 0;
	int s = 0;
	for (int i = 0; i < 10; i++){
		for (int t = 0; t < 10; t++){
			if (pl2[i][t] == 'X')
				s++;
		}
	}
	if (s == 0){
		printf("Победа!!!\n"); system("pause");
	}
	else{
		printf("\nПоражение!!!\n"); system("pause");
	}

	printf("Минные формуляры:\n");
	vivod(pl1);
	vivod(pl2);
	printf("\nСпасибо за игру!\n");
	system("pause");
	system("cls");
	main();
}


char minir(char pl2[][11], int k){
	int t, i, s = 0;
	//srand(time(0)); // автоматическая рандомизация
	while (s != k){
		s = 0;
		t = 0 + rand() % 9;
		i = 0 + rand() % 9;
		pl2[t][i] = 'X';
		for (int i = 0; i < 10; i++){
			for (int t = 0; t < 10; t++){
				if (pl2[i][t] == 'X')
					s++;
			}
		}
	}
	return *pl2[11];
}





////////////////////////////////////////////////////////////////

void vivod(char[][8]);
void kanec(char[][8], char[][8],char[10],char[10]);


int batle()
{
	setlocale(LC_ALL, "Russian");
	char pl1[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl2[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl3[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl4[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	int s =0;
	char pla1[10];
	char pla2[10];
	printf("Введите имена игроков:");
	fflush(stdin);
	gets_s(pla1);
	printf("\nСледущий игрок:");
	fflush(stdin);
	gets_s(pla2);
	system("cls");

	printf("%s прячет секретики:\n",pla1);

	///// вывод поля
	vivod(pl1);

	//1
	int p1, p2;
	for (int f = 0; f < 7; f++){
		printf("введите клетку рзмещения в форм. - строчка,столбик\n");
		scanf_s("%d%d", &p2,&p1);
		pl1[p1][p2] = 'O';
		system("cls");
		printf("Ваше поле:\n");
		vivod(pl1);
	}
	system("pause");
	system("cls");
	/////////////////////////////////////
  
	printf("%s прячет секретики:\n",pla2);

	///// вывод поля
	vivod(pl2);

	//2
	for (int f = 0; f < 7; f++){
		printf("введите клетку рзмещения в форм. - строчка,столбик\n");
		scanf_s("%d%d", &p2, &p1);
		pl2[p1][p2] = 'O';
		system("cls");
		printf("Ваше поле:\n");
		vivod(pl2);
	}
	system("pause");
	



	//////ходы
	int pip = 0;
	while (1){
		do{
			system("cls");
			printf("%s ходит\n",pla1);
			printf("Поле %s в данный момент:\n",pla2);
			vivod(pl3);
		scanf_s("%d%d", &p2, &p1);
		system("cls");
		//попадание
		if (pl2[p1][p2] == 'O'){
			pl3[p1][p2] = 'X';
			pl2[p1][p2] = 'Х';
			pip = 1;
		}//промах
		else{
			pl3[p1][p2] = '*';
			pip = 0;
		}
		printf("Поле %s:\n",pla2);
		vivod(pl3);

		//проверка поля на пустоту
		for (int i = 0; i < 7; i++){
			for (int t = 0; t < 7; t++){
				if (pl2[i][t] == 'O')
					s++;
			}
		}
		if (s == 0){ printf("%s победил!!!\n",pla1); kanec(pl1, pl2,pla1,pla2); return 0; }
		else{ s = 0; }
		}while (pip == 1);
		system("pause");
		

		do{
			system("cls");
			printf("%s ходит\n",pla2);
			printf("Поле %s в данный момент:\n",pla1);
			vivod(pl4);
			scanf_s("%d%d", &p2, &p1);
			system("cls");
			if (pl1[p1][p2] == 'O'){
				pl4[p1][p2] = 'X';
				pl1[p1][p2] = 'Х';
				pip = 1;
			}
			else{
				pl4[p1][p2] = '*';
				pip = 0;
			}
			printf("Поле %s:\n",pla1);
			vivod(pl4);

			
			for (int i = 0; i < 7; i++){
				for (int t = 0; t < 7; t++){
					if (pl1[i][t] == 'O')
						s++;
				}
			}
			if (s == 0){ printf("%s победил!!!\n",pla2); kanec(pl1, pl2,pla1,pla2); return 0; }
			else{ s = 0; }
		} while (pip == 1);
		system("pause");
		system("cls");
	}
	system("cls");
	main();
	return 0;
}




void vivod(char pl[][8]){
	printf("  0|1|2|3|4|5|6\n");
	for (int i = 0; i < 7; i++){
		printf("%d", i);
		for (int t = 0; t < 7; t++){
			printf("|%c", pl[t][i]);
		}
		printf("|\n");
	}
}

void kanec(char pl1[][8], char pl2[][8],char pla1[10],char pla2[10] ){
	printf("Показать расстановки на полях?\n");
	fflush(stdin);
	if (_getch() == 'y'||'н'){
		system("cls");
		printf("Поле %s\n",pla1);
		vivod(pl1);
		printf("\nПоле %s\n",pla2);
		vivod(pl2);
	}
	system("pause");
	printf("Спасибо за игру!!!\n");
	system("pause");
	system("cls");
	main() ;
}



int batlePvE()
{
	setlocale(LC_ALL, "Russian");
	char pl1[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl2[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl3[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	char pl4[7][8] = { { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" }, { "_______" } };
	int s = 0;
	char pla1[10];
	char pla2[] = {"Компьютер"};
	printf("Введите имя игрока:");
	fflush(stdin);
	gets_s(pla1);
	system("cls");

	printf("%s прячет секретики:\n", pla1);

	///// вывод поля
	vivod(pl1);

	//1
	int p1, p2;
	for (int f = 0; f < 7; f++){
		printf("введите клетку рзмещения в форм. - строчка,столбик\n");
		scanf_s("%d%d", &p2, &p1);
		pl1[p1][p2] = 'O';
		system("cls");
		printf("Ваше поле:\n");
		vivod(pl1);
	}
	system("pause");
	system("cls");
	/////////////////////////////////////

	int t, i;
	int p=0;
	//srand(time(0)); // автоматическая рандомизация
	while (p != 6){
		p = 0;
		t = 0 + rand() % 6;
		i = 0 + rand() % 6;
		pl2[t][i] = 'O';
		for (int i = 0; i < 6; i++){
			for (int t = 0; t < 6; t++){
				if (pl2[i][t] == 'O')
					p++;
			}
		}
	}
	/*printf("проверка:\n");
	vivod(pl2);
	system("pause");*/


	//////ходы
	int pip = 0;
	while (1){
		do{
			system("cls");
			printf("%s ходит\n", pla1);
			printf("Поле %s в данный момент:\n", pla2);
			vivod(pl3);
			scanf_s("%d%d", &p2, &p1);
			system("cls");
			//попадание
			if (pl2[p1][p2] == 'O'){
				pl3[p1][p2] = 'X';
				pl2[p1][p2] = 'Х';
				pip = 1;
			}//промах
			else{
				pl3[p1][p2] = '*';
				pip = 0;
			}
			printf("Поле %s:\n", pla2);
			vivod(pl3);

			//проверка поля на пустоту
			for (int i = 0; i < 7; i++){
				for (int t = 0; t < 7; t++){
					if (pl2[i][t] == 'O')
						s++;
				}
			}
			if (s == 0){ printf("%s победил!!!\n", pla1); kanec(pl1, pl2, pla1, pla2); return 0; }
			else{ s = 0; }
		} while (pip == 1);
		system("pause");


		do{
			system("cls");
			printf("%s ходит\n", pla2);
			
			t = 0 + rand() % 7;
			i = 0 + rand() % 7;
			if (pl1[t][i] == 'O'){
				pl4[t][i] = 'X';
				pl1[t][i] = 'Х';
				pip = 1;
			}
			else if (pl4[t][i] == '*'){
				pip = 1;
			}
			else{
				pl4[t][i] = '*';
				pip = 0;
			}
			printf("Поле %s:\n", pla1);
			vivod(pl4);


			for (int i = 0; i < 7; i++){
				for (int t = 0; t < 7; t++){
					if (pl1[i][t] == 'O')
						s++;
				}
			}
			if (s == 0){ printf("%s победил!!!\n", pla2); kanec(pl1, pl2, pla1, pla2); return 0; }
			else{ s = 0; }
		} while (pip == 1);
		system("pause");
		system("cls");
		
	}

	return 0;
}
