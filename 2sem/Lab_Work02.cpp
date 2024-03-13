// Lab_Work02.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<string.h>


struct stud *pep;

//шаблон структуры
struct stud {
	struct{
		char namee[20];
		char sname[20];
		char fname[20];
	}st;
	union rw {
		struct{
			int rost;
			int wase;
		}st1;
		struct{
			int rost;
			int wase;
			int kol;
		}st2;
	}un;
};
using namespace std;
	void menu(int, stud*);
	void sel1(int, stud*);
	void sel2(int, stud*);

//выделение памяти и инициализация
int main()
{
	int k = 0;
	printf("wedite kol-vo studentov - ");
	scanf_s("%d", &k);
	pep = (stud*)malloc(k*sizeof(stud));
	menu(k, pep);
	

		return 0;
}

//меню
void menu(int k, stud *x){
	printf("1)a\n2)b\n");
	int a = 1;
	scanf_s("%d", &a);
	switch (a){
	case 1: sel1(k, x); break;
	case 2: sel2(k, x); break;
	default:system("cls"); printf("\n\aERROR: choose everthing!\n"); menu(k, x);
	}
}


void sel1(int k, stud*x){
	for (int i = 0; i < k; i++)
	{
		printf("\n-Student number %d-\n", i + 1);

		printf("\nfamilia of %d  student-", i + 1);
		fflush(stdin);
		gets_s(x[i].st.sname);
		printf("\nname of %d  student-", i + 1);
		fflush(stdin);
		gets_s(x[i].st.namee);
		printf("\notchestvo of %d  student-", i + 1);
		fflush(stdin);
		gets_s(x[i].st.fname);
		printf("\nrost of %d  student-", i + 1);
		scanf_s("%d", &x[i].un.st1.rost);
		printf("\nwes of %d  student-", i + 1);
		scanf_s("%d", &x[i].un.st1.wase);
		fflush(stdin);
	}
	char s;
	char str[20];
	printf("\nsecond name of student, that you find - ");
	fflush(stdin);
	gets_s(str);
	system("cls");
	for (int i = 0; i < k; i++){
		if (strcmp(x[i].st.sname, str) == 0){
			printf("finded: %s %s %s with rost - %d   and wase %d ", x[i].st.sname,x[i].st.namee,x[i].st.fname,x[i].un.st1.rost,x[i].un.st1.wase);
		}
	}
		printf("\npress '0' to back in menu or any key to exit\n");
		fflush(stdin);
		scanf_s("%c", &s);
		if (s == '0'){
			system("cls");
			menu(k, x);
		}
	}




		void sel2(int k, stud*x){

			for (int i = 0; i < k; i++)
			{
				printf("\n-Student number %d-\n", i + 1);

				printf("\nfamilia of %d  student-", i + 1);
				fflush(stdin);
				gets_s(x[i].st.sname);
				printf("\nname of %d  student-", i + 1);
				fflush(stdin);
				gets_s(x[i].st.namee);
				printf("\notchestvo of %d  student-", i + 1);
				fflush(stdin);
				gets_s(x[i].st.fname);
				printf("\nrost of %d  student-", i + 1);
				scanf_s("%d", &x[i].un.st2.rost);
				printf("\nwes of %d  student-", i + 1);
				scanf_s("%d", &x[i].un.st2.wase);
				printf("\nkol-vo palcev of %d  student-", i + 1);
				scanf_s("%d", &x[i].un.st2.kol);
				fflush(stdin);
			}
			char s;
			char str[20];
			printf("\nsecond name of student, that you find - ");
			fflush(stdin);
			gets_s(str);
			system("cls");
			for (int i = 0; i < k; i++){
				if (strcmp(x[i].st.sname, str) == 0){
					printf("finded: %s %s %s with rost - %d   and wase %d  with %d palcev ", x[i].st.sname, x[i].st.namee, x[i].st.fname, x[i].un.st2.rost, x[i].un.st2.wase,x[i].un.st2.kol);
				}
			}
			printf("\npress '0' to back in menu or any key to exit\n");
			fflush(stdin);
			scanf_s("%c", &s);
			if (s == '0'){
				system("cls");
				menu(k, x);
			}	
		}