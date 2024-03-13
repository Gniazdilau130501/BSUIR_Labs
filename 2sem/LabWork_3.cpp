// LabWork_3.cpp: определяет точку входа для консольного приложения.
//Дан символьный файл f, содержащий произвольный текст. Слова в тексте разде-лены пробелами и
//знаками препинания. Получить n наиболее часто встречаю-щихся слов и число их появлений.


//#define _CRT_SECURE_NO_WARNINGS
#include "stdafx.h"
#include <stdio.h>
#include <cstdio>
#include "windows.h"
#include < string.h >
#include <locale.h>

int main()
{
	
	setlocale(LC_ALL, "Russian");
	FILE *f, *g;            //открываем файл для записи
	char s[20];        //создаем строку для записи
	char t[20];
	int ksl = 0;
	fflush(stdin);



	fopen_s(&f, "text.txt", "r");
	if (f == NULL){
		printf("\nERROR: File not open\a\n"); return 1;
	}
	fopen_s(&g, "text1.txt", "r");
	if (g == NULL){
		printf("\nERROR: File not open\a\n"); return 1;
	}
	printf("файл f:\n");
		while (feof(f) == 0){
			fgets(s, 19, f);
			printf("%s", s);
		}
		printf("\n\nфайл g:\n");
		rewind(g);
		while (feof(g) == 0){
			fgets(s, 19, g);
			printf("%s", s);
		}
		rewind(f); rewind(g);
		printf("\n\nПодсчёт слов:\n");
	int i = 0;
	int k = 0;
	while (feof(f) == 0)
		{
	fgets(s, 19, f);//записываем строку  
	printf("\nСлово %s из док f встретилось в док g -  ", s);
	while (feof(g)==0)
	{
		fgets(t, 19, g);
		if (strcmp(s, t) == 0){
			ksl++;
			
		}
		i++;
	}
	printf("%d раз\n", ksl);
	ksl = 0;
	k++;
	i = 0;
	rewind(g);
}
	
	fclose(f);
	fclose(g);
		return 0;
}

