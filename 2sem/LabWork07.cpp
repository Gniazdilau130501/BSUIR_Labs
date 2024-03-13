// LabWork07.cpp: определяет точку входа для консольного приложения.
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

	int d;
	int m;
	int y;
	printf("a - zapisat daty\n e - cЪebat naxyi ot cuda\n");
	switch (_getch()){
	case 'a':system("cls"); printf("zapishi daty paskyda - ");
		FILE *f;
	if (fopen_s(&f,"aa", "a+b")!=0)
	{
		puts("файл не может быть создан");
		return 1;
	}
	fflush(stdin); scanf_s("%d", &d); scanf_s("%d", &m); scanf_s("%d", &y); fwrite(&d, sizeof(d), 1, f); fwrite(&m, sizeof(m), 1, f); fwrite(&y, sizeof(y), 1, f);
	fclose(f);
	system("cls");
	main();
	break;
	case'e': exit(0); break;
	/*case'r':
		if (fopen_s(&f, "aa", "r+b") != 0)
		{
			puts("файл не может быть создан");
			return 1;
		} fread_s(&m, sizeof(int), sizeof(int), 1, f); fclose(f); printf("ответ - %d", m); break;*/
	case '1':break;
	default:system("cls"); main();
	}
	
	return 0;
}

