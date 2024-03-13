// Lab_Work01.cpp: определ€ет точку входа дл€ консольного приложени€.
//

#include "stdafx.h"
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>
#include<string.h>

//шаблон структуры
struct toys{
		char name[20];
		int price;
		int yo;
	};
//объ€вление исп. функций
void menu(int, toys*);
void sel1(int, toys*);
void sel2(int, toys*);

//выделение пам€ти и инициализаци€
int main()

{
	int n=0;
	struct toys *box;                                 //указатель на объекты структ.
	printf("number of toys - ");
	scanf_s("%d",&n);
	box = (toys*)malloc(n*sizeof(toys));              //выделение пам€ти
	if (box == NULL){
		system("cls");
		printf("\n\aERROR: no memory allocated");
		return 1;
	}
	for (int i = 0; i < n; i++){
		fflush(stdin);                      //инициализаци€
		printf("\n - Next toy - \n");
		printf("\n Name of toy - ");
		gets_s(box[i].name);
		printf("\n Prise of toy - ");
		scanf_s("%d", &box[i].price);
		printf("\n age restriction - ");
		scanf_s("%d", &box[i].yo);
		
	}
	system("cls");
	printf("\n");
	menu(n, box);                                     //вызов меню дл€ взаимодействи€ с пользователем
	return 0;
}


//интерфейс программы

//меню
void menu(int n,toys *x){
	printf("1)price < ...  for kids 5- \n2)the best ...\n");
	int a=1;
	scanf_s("%d", &a);
	switch (a){
	case 1: sel1(n,x); break;
	case 2: sel2(n,x); break;
	default:system("cls"); printf("\n\aERROR: choose everthing!\n"); menu(n, x);
	}
}

//первый вариант действий
void sel1(int n,toys*x){
	int s=0;
	char r;
	printf("\nyou price - ");
	scanf_s("%d", &s);
	for (int i = 0; i < n; i++){
		if (x[i].price < s && x[i].yo < 5)
			printf("\nfinded: %s with price - %d%$", x[i].name, x[i].price);
	}
	printf("\npress '0' to back in menu or any key to exit\n");
	fflush(stdin);
	scanf_s("%c", &r);
	if (r == '0'){
		system("cls");
		menu(n, x);
	}
}


//второй вариант действий
void sel2(int n, toys*x){
	char s ;
	int max = 0;
	char str[20];
	printf("\nname of toy that you find - ");
	fflush(stdin);
	gets_s(str);
	system("cls");
	for (int i = 0; i < n; i++){
		if (strcmp(x[i].name, str) == 0 && x[i].price >max){
			max = x[i].price;
		}
	}
	if (max == 0){
		printf("not founded");
	}else{
		printf("finded: %s with price - %d%$", str, max);
	}
	
	printf("\npress '0' to back in menu or any key to exit\n");
	fflush(stdin);
	scanf_s("%c", &s);
	if (s == '0'){
		system("cls");
		menu(n, x);
	}
}