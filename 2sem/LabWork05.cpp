// LabWork05.cpp: ���������� ����� ����� ��� ����������� ����������.
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



//��������� ��������� ���������� ���� :
struct ttree
{
	int inf;
	ttree *left;
	ttree *rigth;
} *proot;
//���������� ������ ��������
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
//����� ����� ������
void wrtree(ttree *p)
{
	if (p == NULL) return;
	wrtree(p->left);
	cout << p->inf << " ";
	wrtree(p->rigth);
}
//����� �������� � �������� ������
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
//����� �������� � ������������ ������
int poiskmaxtree(ttree *p)
{
	while (p->rigth != NULL) p = p->rigth;
	return p->inf;
}
//�������� ����� ������
ttree *deltree(ttree *p)
{
	if (p == NULL) return NULL;
	deltree(p->left);
	deltree(p->rigth);
	delete(p);
	p = NULL;
	return NULL;
}
//�������� �������� � �������� ������
ttree *dellist(ttree *proot, int inf)
{
	ttree *ps = proot, *pr = proot, *w, *v;
	// ����� ���������� ����
	while ((ps != NULL) && (ps->inf != inf))
	{
		pr = ps;
		if (inf < ps->inf) ps = ps->left;
		else ps = ps->rigth;
	}

	if (ps == NULL) return proot; // ���� ���� �� ������
	// ���� ���� �� ����� �������
	if ((ps->left == NULL) && (ps->rigth == NULL))
	{
		if (ps == pr) // ���� ��� ��� ��������� �������
		{
			delete(ps);
			return NULL;
		}
		if (pr->left == ps) // ���� ��������� ���� �����
			pr->left = NULL;
		else // ���� ��������� ���� ������
			pr->rigth = NULL;
		delete(ps);
		return proot;
	}

	// ���� ���� ����� ���� ������ ������
	if (ps->left == NULL)
	{
		if (ps == pr) // ���� ��������� ������
		{
			ps = ps->rigth;
			delete(pr);
			return ps;
		}
		if (pr->left == ps) // ���� ��������� ���� �����
			pr->left = ps->rigth;
		else // ���� ��������� ���� �����
			pr->rigth = ps->rigth;
		delete(ps);
		return proot;
	}
	// ���� ���� ����� ���� ������ �����
	if (ps->rigth == NULL)
	{
		if (ps == pr) // ���� ��������� ������
		{
			ps = ps->left;
			delete(pr);
			return ps;
		}
		if (pr->left == ps) // ���� ��������� ���� �����
			pr->left = ps->left;
		else // ���� ��������� ���� �����
			pr->rigth = ps->left;
		delete(ps);
		return proot;
	}
	// ���� ���� ����� ���� �������
	w = ps->left;
	if (w->rigth == NULL) // ���� ������������ ������� �� ps
		w->rigth = ps->rigth;
	else // ���� ������������ �� ������� �� ps
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
	if (ps == pr) // ���� ��������� ������
	{
		delete(ps);
		return w;
	}
	if (pr->left == ps) // ���� ��������� ���� �����
		pr->left = w;
	else // ���� ��������� ���� ������
		pr->rigth = w;
	delete(ps);
	return proot;
}



int main(){
	printf("1-���������� ��������\n2-����� ������\n3-����� �� �����\n4-����� ������������� �����\n5-");
		switch (_getch()){
		case '1':addtree(proot,*inf); break;
		case '2': wrtree(p); break;
		case '3':poisktree(ttree *p, int key, bool &b, int &inf); break;
		case'4':poiskmaxtree(ttree *p); break;
		case'5':deltree(ttree *p); break;
	}


	return 0;
}