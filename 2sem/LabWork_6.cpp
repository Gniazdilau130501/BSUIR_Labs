// LabWork_3.cpp: îïðåäåëÿåò òî÷êó âõîäà äëÿ êîíñîëüíîãî ïðèëîæåíèÿ.
//Äàí ñèìâîëüíûé ôàéë f, ñîäåðæàùèé ïðîèçâîëüíûé òåêñò. Ñëîâà â òåêñòå ðàçäå-ëåíû ïðîáåëàìè è
//çíàêàìè ïðåïèíàíèÿ. Ïîëó÷èòü n íàèáîëåå ÷àñòî âñòðå÷àþ-ùèõñÿ ñëîâ è ÷èñëî èõ ïîÿâëåíèé.


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
	FILE *f, *g;            //îòêðûâàåì ôàéë äëÿ çàïèñè
	char s[20];        //ñîçäàåì ñòðîêó äëÿ çàïèñè
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
	printf("ôàéë f:\n");
		while (feof(f) == 0){
			fgets(s, 19, f);
			printf("%s", s);
		}
		printf("\n\nôàéë g:\n");
		rewind(g);
		while (feof(g) == 0){
			fgets(s, 19, g);
			printf("%s", s);
		}
		rewind(f); rewind(g);
		printf("\n\nÏîäñ÷¸ò ñëîâ:\n");
	int i = 0;
	int k = 0;
	while (feof(f) == 0)
		{
	fgets(s, 19, f);//çàïèñûâàåì ñòðîêó  
	printf("\nÑëîâî %s èç äîê f âñòðåòèëîñü â äîê g -  ", s);
	while (feof(g)==0)
	{
		fgets(t, 19, g);
		if (strcmp(s, t) == 0){
			ksl++;
			
		}
		i++;
	}
	printf("%d ðàç\n", ksl);
	ksl = 0;
	k++;
	i = 0;
	rewind(g);
}
	
	fclose(f);
	fclose(g);
		return 0;
}

