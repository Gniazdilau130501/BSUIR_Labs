// лаба7.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <stdio.h>
#include <cstdio>
#include "windows.h"
#include < string.h >
#include <locale.h>
#include <stdlib.h>
#include <conio.h>
#include <iostream>


int main()
{
	setlocale(LC_ALL, "rus");
	FILE *f;
	int d=0;
	int s = 0;
	int m=0;
	int y=0;
	int min = 10000;

	printf("a - Добавить дату в формате дд.мм.гггг\nr - Выыести дату\n1 - Самый ранний год\n2 - Вывести весенниe даты\n3 - Самая поздняя дата\ne - Выход\n");
	fflush(stdin);
	switch (_getch()){
	case 'a':system("cls"); printf("Запишите дату\n");

		if (fopen_s(&f, "aa", "a+b") != 0)
		{
			puts("файл не может быть создан");
			return 1;
		}
		fflush(stdin); printf("День-"); scanf_s("%d", &d); printf("Месяц-"); scanf_s("%d", &m); printf("Год-"); scanf_s("%d", &y); if (d > 31 || m > 12 || y > 9999){
			printf("Введите коректную дату\n"); system("pause"); system("cls"); fclose(f); main();
		} fwrite(&d, sizeof(int), 1, f); fwrite(&m, sizeof(int), 1, f); fwrite(&y, sizeof(int), 1, f); 
		fclose(f);
		system("cls");
		main();
		break;

	case'e': exit(0); break;
	case'r':
		if (fopen_s(&f, "aa", "r+b") != 0)
		{
			puts("файл не может быть создан");
			return 1;
		}  fseek(f, 0, SEEK_END);    s = (ftell(f)/(3*sizeof(int)));
		for (int l = 0; l <s; l++){
			fseek(f, (sizeof(int) * 3 * l), SEEK_SET);
			fread_s(&d, sizeof(int), sizeof(int), 1, f); fread_s(&m, sizeof(int), sizeof(int), 1, f); fread_s(&y, sizeof(int), sizeof(int), 1, f);
		printf(" %d %d %d\n",d, m, y);
		} fclose(f);    system("pause"); system("cls"); main(); break;
	case '1':if (fopen_s(&f, "aa", "r+b") != 0)
	{
		puts("файл не может быть создан");
		return 1;
	}
			 fseek(f, 0, SEEK_END);    s = (ftell(f)/(3*sizeof(int)));    for (int l = 1; l <= s; l++){ fseek(f, (sizeof(int) * 3 * l) - sizeof(int), SEEK_SET); fread_s(&d, sizeof(int), sizeof(int), 1, f);  if (d < min)min = d; }system("cls"); printf("Минимальный год - %d\n", min); fclose(f); system("pause"); system("cls"); main(); break;
	case '2':if (fopen_s(&f, "aa", "r+b") != 0)
	{
		puts("файл не может быть создан");
		return 1;
	}
			 fseek(f, 0, SEEK_END);   s = (ftell(f) / (3 * sizeof(int)));    for (int l = 1; l <= s; l++){
				 fseek(f, (sizeof(int) * 3 * l) - (2*sizeof(int)), SEEK_SET);
				 fread_s(&m, sizeof(int), sizeof(int), 1, f);  if (m == 3 || m == 4 || m == 5){
					 fseek(f, (0-2*sizeof(int)), SEEK_CUR);
					 fread_s(&d, sizeof(int), sizeof(int), 1, f);
					 fseek(f, sizeof(int), SEEK_CUR);
					 fread_s(&y, sizeof(int), sizeof(int), 1, f); 
					 printf("Одна из весенних дат - %d %d %d\n", d, m, y);
					 rewind;
				 }
				
			 }
			 fclose(f); system("pause"); system("cls"); main(); break;
	case '3': if (fopen_s(&f, "aa", "r+b") != 0)
	{
		puts("файл не может быть создан");
		return 1;
	}
			  min = 0;
			  fseek(f, 0, SEEK_END);   s = (ftell(f) / (3 * sizeof(int)));    for (int l = 1; l <= s; l++){
				  fseek(f, (sizeof(int) * 3 * l) - sizeof(int), SEEK_SET);
				  fread_s(&y, sizeof(int), sizeof(int), 1, f);  if (y > min)min = y;
			  }
			  fseek(f, 0, SEEK_END);    s = (ftell(f) / (3 * sizeof(int)));    for (int l = 1; l <= s; l++){
					  fseek(f, (sizeof(int) * 3 * l) - sizeof(int), SEEK_SET);
					  fread_s(&y, sizeof(int), sizeof(int), 1, f);  if (y == min){
						  fseek(f, (0 - 3 * sizeof(int)), SEEK_CUR);
						  fread_s(&d, sizeof(int), sizeof(int), 1, f);
						  fread_s(&m, sizeof(int), sizeof(int), 1, f); 
						 printf("Cамая поздняя дата - %d %d %d\n", d, m, y);
					  }
				 
			  } fclose(f); system("pause"); system("cls"); main(); break;
			  
	default:system("cls"); main();
	}

	return 0;
}


