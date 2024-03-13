// LabWork05.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <conio.h>
#include <dos.h>
#include <iostream>
#include <cmath>
using namespace std;



//Объявлена структура следующего типа :
struct ttree
{
	int inf;
	ttree *left;
	ttree *rigth;
} *proot;
//Добавление нового элемента
ttree *addtree(ttree *proot, int inf)
{
	ttree *nl, *pr, *ps;
	bool b;
	nl = new ttree;
	nl->inf = inf;
	nl->left = NULL;
	nl->rigth = NULL;
	if (proot == NULL) return nl;
	ps = proot;
	while (ps != NULL)
	{
		pr = ps;
		b = (inf < ps->inf);
		if (b) ps = ps->left;
		else ps = ps->rigth;
	}
	if (b) pr->left = nl;
	else pr->rigth = nl;
	return proot;
}
//Обход всего дерева
void wrtree(ttree *p)
{
	if (p == NULL) return;
	wrtree(p->left);
	cout << p->inf << " ";
	wrtree(p->rigth);
}
//Поиск элемента с заданным ключом
void poisktree(ttree *p, int key, bool &b, int &inf)
{
	if ((p != NULL) && (b != true))
	{
		if (p->inf != key)
		{
			poisktree(p->left, key, b, inf);
			poisktree(p->rigth, key, b, inf);
		}
		else {
			b = true;
			inf = p->inf;
		}
	}
	return;
}
//Поиск элемента с максимальным ключом
int poiskmaxtree(ttree *p)
{
	while (p->rigth != NULL) p = p->rigth;
	return p->inf;
}
//Удаление всего дерева
ttree *deltree(ttree *p)
{
	if (p == NULL) return NULL;
	deltree(p->left);
	deltree(p->rigth);
	delete(p);
	p = NULL;
	return NULL;
}
//Удаление элемента с заданным ключом
ttree *dellist(ttree *proot, int inf)
{
	ttree *ps = proot, *pr = proot, *w, *v;
	// Поиск удаляемого узла
	while ((ps != NULL) && (ps->inf != inf))
	{
		pr = ps;
		if (inf < ps->inf) ps = ps->left;
		else ps = ps->rigth;
	}

	if (ps == NULL) return proot; // Если узел не найден
	// Если узел не имеет дочерей
	if ((ps->left == NULL) && (ps->rigth == NULL))
	{
		if (ps == pr) // Если это был последний элемент
		{
			delete(ps);
			return NULL;
		}
		if (pr->left == ps) // Если удаляемый узел слева
			pr->left = NULL;
		else // Если удаляемый узел справа
			pr->rigth = NULL;
		delete(ps);
		return proot;
	}

	// Если узел имеет дочь только справа
	if (ps->left == NULL)
	{
		if (ps == pr) // Если удаляется корень
		{
			ps = ps->rigth;
			delete(pr);
			return ps;
		}
		if (pr->left == ps) // Если удаляемый узел слева
			pr->left = ps->rigth;
		else // Если удаляемый узел спава
			pr->rigth = ps->rigth;
		delete(ps);
		return proot;
	}
	// Если узел имеет дочь только слева
	if (ps->rigth == NULL)
	{
		if (ps == pr) // Если удаляется корень
		{
			ps = ps->left;
			delete(pr);
			return ps;
		}
		if (pr->left == ps) // Если удаляемый узел слева
			pr->left = ps->left;
		else // Если удаляемый узел спава
			pr->rigth = ps->left;
		delete(ps);
		return proot;
	}
	// Если узел имеет двух дочерей
	w = ps->left;
	if (w->rigth == NULL) // Если максимальный следует за ps
		w->rigth = ps->rigth;
	else // Если максимальный не следует за ps
	{
		while (w->rigth != NULL)
		{
			v = w;
			w = w->rigth;
		}
		v->rigth = w->left;
		w->left = ps->left;
		w->rigth = ps->rigth;
	}
	if (ps == pr) // Если удаляется корень
	{
		delete(ps);
		return w;
	}
	if (pr->left == ps) // Если удаляемый узел слева
		pr->left = w;
	else // Если удаляемый узел справа
		pr->rigth = w;
	delete(ps);
	return proot;
}



int main(){
	printf("1-Добавление элемента\n2-Обход дерева\n3-Поиск по ключу\n4-Поиск максимального ключа\n5-");
		switch (_getch()){
		case '1':addtree(proot,*inf); break;
		case '2': wrtree(p); break;
		case '3':poisktree(ttree *p, int key, bool &b, int &inf); break;
		case'4':poiskmaxtree(ttree *p); break;
		case'5':deltree(ttree *p); break;
	}


	return 0;
}