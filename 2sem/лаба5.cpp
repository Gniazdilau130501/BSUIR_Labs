// лаба5.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "stdio.h"
#include "stdlib.h"
#include "conio.h"
#include "locale.h"

struct stec{
	char i;    //инф поле
	stec*p;
}*ver=NULL,*t=NULL;



void main(){
	while (1){
		system("cls");
		printf("a-vvodim,r-pocitay syka,d-ydali eblan,e-chekni mati.\n");
		switch (_getch())
		{
		case 'a':t = (stec*)malloc(sizeof(stec));
			printf("wedi plz");
			fflush(stdin);
			scanf_s("%c", &t->i);
			t->p = ver;
			ver = t;
			break;
		case 'r':
			system("cls");
			if (ver == NULL){ printf("stec pust\n"); system("pause"); system("cls"); main(); }
			t = ver;
			while (t != NULL){
				printf("wedennaya bykva - %c\n", t->i);
				t = t->p;
			}
			system("pause"); system("cls");
			break;
		case 'd': if (ver == NULL){ printf("stec pust\n"); system("pause"); system("cls"); main(); }
				  while(ver!=NULL){
				  t = ver;
				  ver = t->p;
				  delete(t);
		}
				  printf("stek ydalen\n\a"); system("pause"); system("cls"); break;
		case 'e':exit(0); break;
		default:system("cls"); printf("Eblanota wiberi bykvy\n"); main();
			break;
		}
	}
	
}