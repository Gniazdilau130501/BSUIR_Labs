// LabWork_3.cpp: ���������� ����� ����� ��� ����������� ����������.
//��� ���������� ���� f, ���������� ������������ �����. ����� � ������ �����-���� ��������� �
//������� ����������. �������� n �������� ����� ��������-����� ���� � ����� �� ���������.


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
	FILE *f, *g;            //��������� ���� ��� ������
	char s[20];        //������� ������ ��� ������
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
	printf("���� f:\n");
		while (feof(f) == 0){
			fgets(s, 19, f);
			printf("%s", s);
		}
		printf("\n\n���� g:\n");
		rewind(g);
		while (feof(g) == 0){
			fgets(s, 19, g);
			printf("%s", s);
		}
		rewind(f); rewind(g);
		printf("\n\n������� ����:\n");
	int i = 0;
	int k = 0;
	while (feof(f) == 0)
		{
	fgets(s, 19, f);//���������� ������  
	printf("\n����� %s �� ��� f ����������� � ��� g -  ", s);
	while (feof(g)==0)
	{
		fgets(t, 19, g);
		if (strcmp(s, t) == 0){
			ksl++;
			
		}
		i++;
	}
	printf("%d ���\n", ksl);
	ksl = 0;
	k++;
	i = 0;
	rewind(g);
}
	
	fclose(f);
	fclose(g);
		return 0;
}

